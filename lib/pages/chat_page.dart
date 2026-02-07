// Package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Widget
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

//Model
import '../models/chat.dart';
import '../models/message.dart';

//Provider
import '../provider/authenticator_provider.dart';
import '../provider/chat_page_provider.dart';

//Service
import '../services/navigation_service.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticatorProvider _auth;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messageListViewController;
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  //UI
  Widget _buildUI() {
    return Scaffold();
  }
}
