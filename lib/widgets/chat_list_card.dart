import 'package:flutter/material.dart';

class ChatListCard extends StatelessWidget {
  final String imageUrl;
  final String username;
  ChatListCard(this.imageUrl, this.username);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(imageUrl),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(username), Text("Last text....")],
        ),
      ],
    );
  }
}
