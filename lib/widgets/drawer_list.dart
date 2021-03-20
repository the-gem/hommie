import 'package:flutter/material.dart';
import 'package:hommie/main.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/accounts/user_profile.dart';
import 'package:hommie/pages/homepage.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  bool menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: GestureDetector(
            onTap: () {
              isLoggedIn
                  ? Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.idscreen, (route) => false)
                  : Navigator.pushNamedAndRemoveUntil(
                      context, Login.idscreen, (route) => false);
            },
            child: isLoggedIn
                ? Text(user.email)
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('sign in or create account'),
                  ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('User Profile'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        ),
        ListTile(
          title: Text('Listing Management'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('help center'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('give feedback'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('LogOut'.toUpperCase()),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}
