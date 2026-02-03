import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trachat_app/models/message.dart';
import 'package:trachat_app/models/users.dart';
// import 'package:get_it/get_it.dart';

//Provider
import '../provider/authenticator_provider.dart';
import '../provider/chat_page_provider.dart';

//Widget
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

//Model
import '../models/chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeigh;
  late double _deviceWidth;

  late AuthenticatorProvider _auth;
  late ChatPageProvider _chatPageProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeigh = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _auth = Provider.of<AuthenticatorProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create: (_) => ChatPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext context) {
        _chatPageProvider = context.watch<ChatPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03, // padding 3% of width
            vertical: _deviceHeigh * 0.02, // padding 2% of heigh
          ),
          // color: Colors.red,
          height: _deviceHeigh * 0.98, //98% of height
          width: _deviceWidth * 0.97, // 97% of width
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                "Chats",
                primaryAction: IconButton(
                  icon: Icon(Icons.logout, color: Colors.redAccent),
                  onPressed: () {
                    _auth.logout();
                  },
                ),
                // secondaryAction: null,
              ),
              _chatsList(),
            ],
          ),
        );
      },
    );
  }

  Widget _chatsList() {
    List<Chat>? chats = _chatPageProvider.chats;
    print(chats);
    return Expanded(
      child: (() {
        if (chats != null) {
          if (chats.isNotEmpty) {
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return _chatTile(chats[index]);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
      }()),
    );
  }

  Widget _chatTile(Chat chat) {
    List<ChatUser> recipients = chat.recipient();
    bool isActive = recipients.any((doc) => doc.wasRecentlyActiveHours());
    String subtitle = "";
    if (chat.messages.isNotEmpty) {
      subtitle = chat.messages.first.type != MessageType.TEXT
          ? "Media Attachment"
          : chat.messages.first.content;
      print(chat.imageURL());
    }

    return CustomListViewTile(
      height: _deviceHeigh * 0.15,
      title: chat.title(),
      subtitle: subtitle,
      imagePath: chat.imageURL(),
      isActive: isActive,
      isAcitivty: false,
      onTap: () {},
    );
  }
}
