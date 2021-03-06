import 'package:flutter/material.dart';

class ChatTopBar extends StatefulWidget {
  @override
  _ChatTopBarState createState() => _ChatTopBarState();
}

class _ChatTopBarState extends State<ChatTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Chats".toUpperCase(),
              style: TextStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text("cards".toUpperCase()),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text("status".toUpperCase()),
          ),
        ],
      ),
    );
  }
}
