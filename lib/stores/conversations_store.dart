import 'dart:async';
import 'dart:math';

import 'package:chat_poc/models/message.dart';
import 'package:mobx/mobx.dart';

import '../models/conversation.dart';

//flutter packages pub run build_runner clean
//flutter packages pub run build_runner build

part 'conversations_store.g.dart';

class ConversationsStore = _ConversationsStore with _$ConversationsStore;

abstract class _ConversationsStore with Store {
  @observable
  ObservableList<Conversation> conversations = ObservableList();

  @observable
  Conversation selectedConversation;

  final StreamController<Conversation> conversationsStream = StreamController();

  Future<void> initialize() async {
    conversationsStream.stream.listen(_onConversationAdded);
    Random randomGenerator = Random.secure();

    final numberOfConversationsGenerated = 50;

    for (var i = 0; i < numberOfConversationsGenerated; i++) {
      // we distribute the type as this is just static data, for development purpose...
      String type;
      if (i % 3 == 0) {
        type = 'default';
      } else if (i % 3 == 1) {
        type = 'team_conversation';
      } else {
        type = 'group_conversation';
      }

      // The image URL is now referencing assets in the project, in the final version it will reference
      // a network image, but for now we can just support asset images.
      String imageUrl;
      if (i % 4 == 0) {
        imageUrl = 'images/conversation.png';
      }

      int unread = 0;
      if (randomGenerator.nextInt(100) > 80) {
        unread = randomGenerator.nextInt(5) + 1;
      }

      Random.secure();

      List<Message> messages = await _loadConversationMessages(i);

      final Conversation newConversation = Conversation(
        id: i,
        name: 'Conversation #$i',
        type: type,
        imageUrl: imageUrl,
        unread: unread,
        messages: messages,
      );

      await Future.delayed(Duration(seconds: 3), () {});

      conversationsStream.add(newConversation);
    }
  }

  void _onConversationAdded(Conversation conversation) {
    addNewConversation(conversation);
  }

  Future<List<Message>> _loadConversationMessages(int conversationId) async {
    print('Getting messages for conversation $conversationId');
    Random randomGenerator = Random.secure();
    List<String> sentences = [
      'How are you doing today?',
      'Cool, great stuff!',
      'What were you thinking about today? You looked to be dreaming about something.',
      'Where should we have lunch today?',
      'This is probably a silly sentence. But I need to write something that is long to be able to give a full example to the developers. This is probably long enough, soon, in a while, maybe now? Long enough! Stop!!!',
    ];

    List<Message> messages = [];

    for (var i = 0; i < 100; i++) {
      String imageUrl;
      int randomNumber = randomGenerator.nextInt(100);
      if (randomNumber > 90) {
        imageUrl = 'images/message-portrait.jpg';
      } else if (randomNumber > 80 && randomNumber <= 90) {
        imageUrl = 'images/message-landscape.jpg';
      }

      messages.add(
        Message(
          id: i,
          message: sentences[randomGenerator.nextInt(sentences.length)],
          sentByMe: randomGenerator.nextBool(),
          imageUrl: imageUrl,
        ),
      );
    }

    await Future.delayed(Duration(seconds: 2), () {});

    return messages;
  }

  @action
  void addNewConversation(Conversation conversation) {
    conversations.add(conversation);
  }

  @action
  void changeSelectedConversation(int conversationId) {
    selectedConversation = _findConversationById(conversationId);
  }

  @action
  void sendMessage(Message message) {
    selectedConversation.messages.add(message);
    selectedConversation = selectedConversation.copy(messages: List.from(selectedConversation.messages));
  }

  void dispose() {
    conversationsStream.close();
  }

  Conversation _findConversationById(int conversationId) {
    return conversations.firstWhere((conversation) => conversation.id == conversationId, orElse: () => null);
  }
}
