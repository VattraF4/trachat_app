import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { TEXT, IMAGE, UNKNOWN }

class ChatMessage {
  final String senderID;
  final String content;
  final MessageType type;
  final DateTime sendtime;

  ChatMessage({
    required this.content,
    required this.type,
    required this.senderID,
    required this.sendtime,
  });

  factory ChatMessage.fromJSON(Map<String, dynamic> json) {
    MessageType messageType;

    switch (json["type"]) {
      case 'text':
        messageType = MessageType.TEXT;
        break;
      case 'image':
        messageType = MessageType.IMAGE;
        break;
      default:
        messageType = MessageType.UNKNOWN;
    }
    return ChatMessage(
      content: json["content"],
      type: messageType,
      senderID: json["sender_id"],
      sendtime: (json["send_time"] as Timestamp).toDate(),
    );
  }

  //Object to JSON
  Map<String, dynamic> toJson() {
    String messageType;

    switch (type) {
      case MessageType.TEXT:
        messageType = 'text';
        break;
      case MessageType.IMAGE:
        messageType = 'image';
        break;
      default:
        messageType = '';
    }
    return {
      'content': content,
      'type': messageType,
      'sender_id': senderID,
      'send_time': Timestamp.fromDate(sendtime),
    };
  }
}
