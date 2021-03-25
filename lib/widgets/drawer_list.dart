import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/list_management.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/accounts/user_profile.dart';
import 'package:hommie/pages/general_pages/feedback_page.dart';
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
          padding: EdgeInsets.only(
            bottom: 20,
            left: 20,
          ),
          child: GestureDetector(
            onTap: () {
              isLoggedIn
                  ? Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.idscreen, (route) => false)
                  : Navigator.pushNamedAndRemoveUntil(
                      context, Login.idscreen, (route) => false);
            },
          ),
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.multiply,
            color: Colors.grey[200],
            image: isLoggedIn
                ? DecorationImage(
                    image: NetworkImage(
                      currentUser.profilePicture[0],
                    ),
                  )
                : DecorationImage(
                    image: NetworkImage(""),
                  ),
          ),
        ),
        ListTile(
          title: Text('Your Profile'.toUpperCase()),
          onTap: () {
            isLoggedIn
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfile()))
                : Navigator.pushNamedAndRemoveUntil(
                    context, Login.idscreen, (route) => false);
          },
        ),
        ListTile(
          title: Text('Listing Management'.toUpperCase()),
          onTap: () {
            isLoggedIn
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListManagement()))
                : Navigator.pushNamedAndRemoveUntil(
                    context, Login.idscreen, (route) => false);
          },
        ),
        ListTile(
          title: Text('give feedback'.toUpperCase()),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedbackPage()));
          },
        ),
        isLoggedIn
            ? ListTile(
                title: Text('LogOut'.toUpperCase()),
                onTap: () {
                  logoutUser();
                },
              )
            : ListTile(
                title: Text('create account'.toUpperCase()),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Login.idscreen, (route) => false);
                },
              ),
      ],
    );
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      isLoggedIn = false;
      currentUserId = "";
    });
    SnackBar snackbar = SnackBar(content: Text('Successfully logged out'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
