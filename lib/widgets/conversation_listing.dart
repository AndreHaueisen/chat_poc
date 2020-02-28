import 'package:chat_poc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../main.dart';

import '../models/conversation.dart';

class ConversationListing extends StatelessWidget {
  const ConversationListing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final bool areConversationsLoaded =
          conversationsStore.conversations != null || conversationsStore.conversations.isEmpty;

      return areConversationsLoaded
          ? ListView.builder(
              itemCount: conversationsStore.conversations.length,
              itemBuilder: (_, index) {
                final Conversation conversation = conversationsStore.conversations[index];

                return InkWell(
                  splashColor: ColorPrimary.c200,
                  highlightColor: ColorPrimary.c100,
                  onTap: () => onTapConversation(conversation, context),
                  child: ListTile(
                    leading: _buildLeading(conversation),
                    title: _buildName(conversation),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 4),
                      child: _buildSubtitle(conversation),
                    ),
                    trailing: index % 4  == 0 ? _buildUnreadMessagesIndicator() : SizedBox(),
                  ),
                );
              },
            )
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            );
    });
  }

  void onTapConversation(Conversation conversation, BuildContext context) {
    conversationsStore.changeSelectedConversation(conversation.id);
    Navigator.of(context).pushNamed(Constants.ROUTE_MESSAGES_SCREEN);
  }

  Widget _buildLeading(Conversation conversation) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorPrimary.c500,
        boxShadow: defaultShadow,
      ),
      child: Center(
        child: conversation.imageUrl != null
            ? Image.network(conversation.imageUrl)
            : Text(
                conversation.name[0],
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildName(Conversation conversation) {
    return Text(
      conversation.name,
      style: TextStyle(color: ColorPrimary.c900, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildSubtitle(Conversation conversation) {
    if (conversation.messages.isNotEmpty) {
      final String firstMessage = conversation.messages.first.message;
      return Text(
        firstMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: ColorPrimary.c600),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildUnreadMessagesIndicator() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red[900],
        boxShadow: defaultShadow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '2',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
