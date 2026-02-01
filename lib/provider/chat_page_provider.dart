// ignore_for_file: avoid_print

import 'dart:async';

//Package
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Service
import '../services/database_service.dart';

//Providers
import '../provider/authenticator_provider.dart';

//Models
import '../models/chat.dart';
import '../models/users.dart';
import '../models/message.dart';

class ChatPageProvider extends ChangeNotifier {
  AuthenticatorProvider _auth;

  late DatabaseService _db;
  List<Chat>? chats;

  late StreamSubscription _chatsStream;

  ChatPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream = _db.getChatsForUsers(_auth.users.uid).listen((
        snapshot,
      ) async {
        chats = await Future.wait(
          snapshot.docs.map((doc) async {
            // Changed variable name from docs to doc
            try {
              Map<String, dynamic> chatData =
                  doc.data() as Map<String, dynamic>;

              // Get Last Message For Chat Page
              List<ChatMessage> messages = [];

              // Get User in Chats
              QuerySnapshot chatMessageSnapshot = await _db
                  .getLastMessageForChat(doc.id);

              // FIX 1: Add null check for chatData['members']
              List<ChatUser> membersChat = [];
              List<dynamic> membersList =
                  chatData['members'] ?? []; // Null check

              for (var uid in membersList) {
                if (uid != null) {
                  // Null check for uid
                  DocumentSnapshot userSnapshot = await _db.getUser(
                    uid.toString(),
                  );
                  if (userSnapshot.exists) {
                    Map<String, dynamic>? userData =
                        userSnapshot.data() as Map<String, dynamic>?;
                    if (userData != null) {
                      userData["uid"] = userSnapshot.id;
                      // FIX 2: Ensure ChatUser.fromJson handles null values properly
                      try {
                        membersChat.add(ChatUser.fromJson(userData));
                      } catch (e) {
                        print("Error parsing user data for uid: $uid");
                        print(e);
                      }
                    }
                  }
                }
              }

              // FIX 3: Correct the condition - should check if docs is NOT empty
              if (chatMessageSnapshot.docs.isNotEmpty) {
                // Changed from isEmpty to isNotEmpty
                Map<String, dynamic> messageData =
                    chatMessageSnapshot.docs.first.data()!
                        as Map<String, dynamic>;
                try {
                  ChatMessage message = ChatMessage.fromJSON(messageData);
                  messages.add(message);
                } catch (e) {
                  print("Error parsing message data");
                  print(e);
                }
              }

              // FIX 4: Add null checks for required fields
              return Chat(
                uid: doc.id,
                currentUserUid: _auth.users.uid,
                activity: chatData['is_activity'] ?? false, // Default value
                group:
                    chatData['is_group'] ??
                    false, // Changed from 'is_activity' to 'is_group'?
                members: membersChat,
                messages: messages,
              );
            } catch (e) {
              print("Error processing chat document ${doc.id}");
              print(e);
              // Return a default Chat or rethrow based on your needs
              return Chat(
                uid: doc.id,
                currentUserUid: _auth.users.uid,
                activity: false,
                group: false,
                members: [],
                messages: [],
              );
            }
          }).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      print("Error Getting Chats");
      print(e);
    }
  }
}
