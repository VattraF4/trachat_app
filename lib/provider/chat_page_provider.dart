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

  void getChats() async {}
}
