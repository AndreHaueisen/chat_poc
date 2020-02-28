import 'package:chat_poc/constants.dart';
import 'package:chat_poc/screens/conversations_screen.dart';
import 'package:chat_poc/screens/messages_screen.dart';
import 'package:chat_poc/stores/conversations_store.dart';
import 'package:flutter/material.dart';

/*

Description of work to be done for chat display poc. Do not modify this text.

There will be two views. Use WhatsApp as an inspiration for basic details.

Conversation listing view
-------------------------

The main view is a conversation / chat listing, meaning listing a set of conversations.

In the bottom there should be a bottom navigation bar with four menu items/icons, when clicking on it, show a Snackbar
telling what bottom navigation icon that was pressed. It is only there for display purposes. There should also be a 
FAB docked to the bottom navigation bar (FloatingActionButtonLocation.centerDocked).

Conversation.getAll() is a future method that returns a list of conversation. Please look in the models file.

Build a list based on material ListTile.

> Conversation.id - just the id (integer), to be used to reference the conversation in the listing page.
> Conversation.type - the conversation type:
  - default: show the first letter of the conversation.name as tile head.
  - group_conversation: show some icon as the tile head.
  - team_conversation: show some other icon than the group_conversation as the tile head.
> Conversation.imageurl - if not null, show the image insteaad of the conversation.type description above.
> Conversation.name - string that is the name of the conversation.
> Conversation.unread - number of unread messages. If > 0 the count should be shown somehow, and the list tile
  should be different somehow to stand out from the other conversations.

Clicking on one of the conversations will load open new page / route referencing the conversation.id for the item 
clicked on.


Messages view
--------------------------

This is the view that one is routed to when clicking on one of the conversations in the Conversation listing view.

There should not be any bottom navigation bar nor FAB.

The top bar should have a back button to the left, and show the conversation details similar as in the
conversation listing view.

In the bottom there should be a text field together with a
send button. When adding text, the send button gets enabled, and when clicking on it append it to the messages (no
need to persist the message).

Message.getByConversationId(int id) returns a Future that contains a list of Message objects.
The objects are for this concept implementation very simple, and not fully realistic, but enough for this exercise.
The first item in the returned list is the last message sent.

> Message.id (not used)
> Message.message (the actual text)
> Message.sentByMe (boolean to indicate if the app user was the sender of the message or not). If false the
  message should be on the left side, if true then it should be on the right side.
> Message.imageUrl asset url to an image. The image should be shown as a cropped square. Use some reasonable size. When clicking on the image full image should be shown.



Extra stuff to prove your greatness :)

- demonstrate how this could be done using the Bloc design pattern
- have different view on large device, where the conversation listing is on the left, and conversation is on the right.
  Similar to how WhatsApp Desktop does.


How your code will be reviewed:

- the final look and feel of the app
- how well the separation between business logic and presentation is done

*/

ConversationsStore conversationsStore = ConversationsStore();

void main() {
  conversationsStore.initialize();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Constants.ROUTE_MESSAGES_SCREEN: (context) => MessagesScreen(),
      },
      theme: ThemeData(
        canvasColor: canvasColor,
        primaryColor: ColorPrimary.c900,
        accentColor: accentColor,
      ),
      home: WillPopScope(
          onWillPop: () async {
            conversationsStore.dispose();
            return true;
          },
          child: ConversationsScreen()),
    );
  }
}

const Color canvasColor = Color(0xFFD9DADE);
const Color accentColor = Color(0xFF1654F0);

class ColorPrimary {
  static const Color c900 = Color(0xFF19294D);
  static const Color c800 = Color(0xFF44557E);
  static const Color c700 = Color(0xFF566B9F);
  static const Color c600 = Color(0xFF7081A9);
  static const Color c500 = Color(0xFF7E8DB1);
  static const Color c400 = Color(0xFF8F9DBC);
  static const Color c300 = Color(0xFFACB7D2);
  static const Color c200 = Color(0xFFC8D2EA);
  static const Color c100 = Color(0xFFD6DFF5);

  static List<Color> colors = const [c100, c200, c300, c400, c500, c600, c700, c800, c900];
}

const List<BoxShadow> defaultShadow = [
  BoxShadow(color: ColorPrimary.c500, offset: Offset(2, 2), blurRadius: 4),
  BoxShadow(color: Colors.white, offset: Offset(-2, -2), blurRadius: 4)
];

const List<BoxShadow> defaultShadowDark = [
  BoxShadow(color: ColorPrimary.c800, offset: Offset(2, 2), blurRadius: 4),
  BoxShadow(color: Colors.white, offset: Offset(-2, -2), blurRadius: 4)
];
