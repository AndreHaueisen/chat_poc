import 'package:chat_poc/widgets/conversation_listing.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amazing chat'),
      ),
      body: ConversationListing(),
    );
  }
}
