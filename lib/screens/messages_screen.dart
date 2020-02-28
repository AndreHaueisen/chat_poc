import 'package:chat_poc/main.dart';
import 'package:chat_poc/models/message.dart';
import 'package:chat_poc/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ScrollController _chatScrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _messageController = TextEditingController();

  ReactionDisposer _onNewMessageAdded;

  @override
  void initState() {
    super.initState();

    // _onNewMessageAdded = autorun((_) {
    //   print(conversationsStore.selectedConversation.messages.toString());
    //   _chatScrollController.animateTo(
    //     _chatScrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 800),
    //     curve: Curves.easeInOutCirc,
    //   );
    // }, delay: 300);
  }

  @override
  void dispose() {
    _onNewMessageAdded?.reaction?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double typingFieldHeight = 64;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(conversationsStore.selectedConversation.name),
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: <Widget>[
            _buildChat(typingFieldHeight: typingFieldHeight),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildTypingField(fieldHeight: typingFieldHeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChat({
    @required double typingFieldHeight,
  }) {
    return Observer(builder: (_) {
      return ListView.builder(
        reverse: true,
        controller: _chatScrollController,
        padding: EdgeInsets.only(
          bottom: typingFieldHeight + 8 ?? 0,
          top: 4,
        ),
        itemBuilder: (context, index) {
          final Message message =
              conversationsStore.selectedConversation.messages[index];

          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: MessageBox(message: message, sentByMe: message.sentByMe),
          );
        },
        itemCount: conversationsStore.selectedConversation.messages.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );
    });
  }

  Widget _buildTypingField({@required double fieldHeight}) {
    return Container(
      constraints: BoxConstraints(minHeight: fieldHeight),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorPrimary.c100,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                child: TextFormField(
                  controller: _messageController,
                  validator: _messageValidator,
                  minLines: 1,
                  maxLines: 6,
                  cursorColor: ColorPrimary.c900,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: ColorPrimary.c900),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(
                        color: ColorPrimary.c200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(
                        color: ColorPrimary.c200,
                      ),
                    ),
                    hintText: "Say something...",
                    hintStyle: TextStyle(
                      color: ColorPrimary.c300,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
            ),
            Observer(builder: (_) {
              return _buildSendButton();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    final bool isTextEmpty = _messageController.text.isNotEmpty;

    return GestureDetector(
      onTap: isTextEmpty
          ? null
          : () {
              if (_formKey.currentState.validate()) {
                if (_messageController.text.isNotEmpty) {
                  conversationsStore.sendMessage(Message(
                    id: 0,
                    message: _messageController.value.text,
                    sentByMe: true,
                    imageUrl: null,
                  ));
                  _messageController.text = "";
                }
              }
            },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPrimary.c900,
            boxShadow: defaultShadow),
        child: Icon(
          Icons.arrow_upward,
          color: ColorPrimary.c100,
        ),
      ),
    );
  }

  String _messageValidator(String message) {
    if (message.length > 500) {
      return "Can't send message above 500 characters";
    }

    return null;
  }
}
