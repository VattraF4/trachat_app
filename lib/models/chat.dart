import '../models/users.dart';
import '../models/message.dart';

class Chat {
  final String uid;
  final String currentUserUid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;

  late final List<ChatUser> _recipient;

  Chat({
    required this.uid,
    required this.currentUserUid,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
  }) {
    _recipient = members
        .where((element) => element.uid != currentUserUid)
        .toList();
  }

  List<ChatUser> recipient() => _recipient;

  String title() {
    return !group
        ? _recipient.first.name
        : _recipient.map((user) => user.name).join(", ");
  }

  String imageURL() {
    String defaultGroupImage =
        "https://cdn-icons-png.flaticon.com/512/166/166289.png";
    return !group
        ? _recipient
              .first
              .imageUrl // if not group
        : defaultGroupImage;
  }
}
