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
          snapshot.docs.map((docs) async {
            Map<String, dynamic> chatData = docs.data() as Map<String, dynamic>;
            //Get Last Message For Chat Pagfe
            List<ChatMessage> messages = [];
            //Get User in Chats
            QuerySnapshot chatMessage = await _db.getLastMessageForChat(
              docs.id,
            );
            List<ChatUser> memebersChat = [];

            for (var uid in chatData['members']) {
              DocumentSnapshot userSnapshot = await _db.getUser(uid);
              Map<String, dynamic> userData =
                  userSnapshot.data() as Map<String, dynamic>;
              memebersChat.add(ChatUser.fromJson(userData));
            }

            if (chatMessage.docs.isEmpty) {
              Map<String, dynamic> messageData =
                  chatMessage.docs.first.data()! as Map<String, dynamic>;
              ChatMessage message = ChatMessage.fromJSON(messageData);
              messages.add(message);
            }
            //Return Chat Instance
            return Chat(
              uid: docs.id,
              currentUserUid: _auth.users.uid,
              activity: chatData['is_activity'],
              group: chatData['is_activity'],
              members: memebersChat,
              messages: messages,
            );
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
