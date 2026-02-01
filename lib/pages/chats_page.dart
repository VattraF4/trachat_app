import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:get_it/get_it.dart';

//Provider
import '../provider/authenticator_provider.dart';
import '../provider/chat_page_provider.dart';

//Widget
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

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
    return Container(child: _chatTile());
  }

  Widget _chatTile() {
    return CustomListViewTile(
      height: _deviceHeigh * 0.15,
      title: "Yan Pich",
      subtitle: "Hi Pro",
      imagePath: "https://i.pravatar.cc/300?image=2",
      isActive: true,
      isAcitivty: false,
      onTap: () {},
    );
  }
}
