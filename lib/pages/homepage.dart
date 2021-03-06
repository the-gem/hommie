import 'package:flutter/material.dart';
import 'package:hommie/pages/add_property_location.dart';
import 'package:hommie/pages/get_property_location.dart';
import 'package:hommie/widgets/chat_list_card.dart';
import 'package:hommie/widgets/chat_top_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hommie"),
        actions: [
          Icon(Icons.nightlight_round),
          Icon(Icons.more_vert),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: // This trailing
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              color: Colors.white,
              width: double.infinity,
              child: ListView(
                children: [
                  ChatListCard("assets/images/logo.jpg", "Axis Real Estate"),
                  ChatListCard("assets/images/logo.jpg", "Axis Real Estate"),
                  ChatListCard("assets/images/logo.jpg", "Axis Real Estate"),
                  ChatListCard("assets/images/logo.jpg", "Axis Real Estate"),
                ],
              ),
            ),
            ChatTopBar(),
            Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetPropertyLocation(),
                        ),
                      );
                    },
                    tooltip: 'search',
                    child: Icon(Icons.search),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPropertyLocation(),
                        ),
                      );
                    },
                    tooltip: 'add listing',
                    child: Icon(Icons.add),
                    // label: Text('add listing'),
                    // icon: Icon(Icons.add),
                    // backgroundColor: Colors.pink,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
