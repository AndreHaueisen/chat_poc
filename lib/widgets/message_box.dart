import 'package:chat_poc/main.dart';
import 'package:chat_poc/models/message.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool sentByMe;

  MessageBox({@required this.message, @required this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return sentByMe
        ? _buildSelfMessageContainer()
        : _buildPartnerMessageContainer();
  }

  Widget _buildSelfMessageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 64, right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorPrimary.c200,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: defaultShadow,
      ),
      child: Text(
        message.message,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 16,
          color: ColorPrimary.c800,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildPartnerMessageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 64),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorPrimary.c900,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: defaultShadow,
      ),
      child: Text(
        message.message,
        style: TextStyle(
          color: ColorPrimary.c200,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
