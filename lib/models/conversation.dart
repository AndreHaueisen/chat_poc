import 'package:chat_poc/models/message.dart';

class Conversation {
  int id;
  String name;
  String type;
  String imageUrl;
  int unread;
  List<Message> messages;

  Conversation({this.id, this.name, this.type, this.imageUrl, this.unread, this.messages});

  Conversation copy({
    int id,
    String name,
    String type,
    String imageUrl,
    int unread,
    List<Message> messages,
  }) {
    return Conversation(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      unread: unread ?? this.unread,
      messages: messages ?? this.messages,
    );
  }
}
