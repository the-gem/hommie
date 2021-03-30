import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/all_list_management.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/accounts/user_profile.dart';
import 'package:hommie/pages/general_pages/feedback_page.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/pages/payments/payment.dart';
import 'package:hommie/pages/properties/plots/plots_home_page.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  DocumentReference paymentsRef;
  bool menuOpen = false;
  Stream<DocumentSnapshot> getAccountBalance() {
    return FirebaseFirestore.instance.collection("payments").doc(currentUserId).collection("balance").doc("account").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            padding: EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 40,
                color: Colors.blue.withBlue(150),
                child: Center(
                  child: isLoggedIn ? StreamBuilder<DocumentSnapshot>(
                    stream: getAccountBalance(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      } else if (snapshot == null ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Scaffold(
                          body: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.data.data() != null && snapshot.data.data().isNotEmpty) {
                          Map<String, dynamic> documentFields =
                              snapshot.data.data();
                          return Text(
                              documentFields.containsKey("wallet")
                                  ? "Account balance: " +
                                      documentFields["wallet"].toString()
                                  : "Account balance: 0",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ));
                        } else if (snapshot.data.data() == null || snapshot.data.data().isEmpty){
                          return Text("Account balance 0".toUpperCase(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ));
                        }
                      } else {
                        return Text("Account balance 0".toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ));
                      }
                    },
                  ) : Text("Account balance 0".toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            )),
                ),
              ),
            ),
            decoration: isLoggedIn &&
                    (currentUser.profilePicture != null &&
                        currentUser.profilePicture.isNotEmpty)
                ? BoxDecoration(
                    backgroundBlendMode: BlendMode.multiply,
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: NetworkImage(
                        currentUser.profilePicture,
                      ),
                    ))
                : BoxDecoration(
                    color: Colors.grey[200],
                  )),
        ListTile(
          title: Text('Rentals'.toUpperCase()),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.idscreen, (route) => false);
          },
        ),
        ListTile(
          title: Text('Plots for sale'.toUpperCase()),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, PlotsHomePage.idscreen, (route) => false);
          },
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
          title: Text('payments'.toUpperCase()),
          onTap: () {
            isLoggedIn
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentsPage()))
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
                title: Text('create account/log in'.toUpperCase()),
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
