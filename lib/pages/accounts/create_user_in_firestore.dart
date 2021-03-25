import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/models/user.dart';
import 'package:hommie/pages/homepage.dart';

class  CreateUserInFirestore extends StatefulWidget {
  final String phoneNumber;
  CreateUserInFirestore({this.phoneNumber});
  @override
  _CreateUserInFirestoreState createState() => _CreateUserInFirestoreState();
}

class _CreateUserInFirestoreState extends State<CreateUserInFirestore> {
  String chooseAccountDropdown = 'landlord';
  String name;
  String idNumber;
  String location;
  String email;
  List<String> profilePic = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 100,
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: Center(
                child: Text(
                  chooseAccountDropdown == "agent"
                      ? "Agency Details"
                      : "Landlord Details",
                  style: TextStyle(
                    color: Colors.blue.withBlue(100),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Account Type",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: DropdownButton<String>(
                value: chooseAccountDropdown,
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconSize: 24,
                elevation: 16,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                onChanged: (String newValue) {
                  setState(() {
                    chooseAccountDropdown = newValue;
                  });
                },
                items: <String>[
                  'landlord',
                  'agent',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            chooseAccountDropdown == "agent"
                ? Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'Agency Name',
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  )
                : Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'full names',
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: chooseAccountDropdown == "agent"
                      ? 'tax identification number'
                      : 'national identification number',
                ),
                onChanged: (value) {
                  idNumber = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                createUser();
              },
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: Colors.blue.withBlue(150),
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Text("Register".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createUser() async {
    await usersRef
        .doc(auth.currentUser.uid)
        .set({
      "id": auth.currentUser.uid,
      "type": chooseAccountDropdown,
      "username": name,
      "location": location,
      "email address": email,
      "phone number": widget.phoneNumber,
      "tax identification number": idNumber,
      "profile picture": profilePic,
    }).then((value) {
      setState(() {
        isLoggedIn = true;
        currentUserId = auth.currentUser.uid;
      });
      getUser();
    });
  }

  getUser() async {
    DocumentSnapshot documentSnapshot = await usersRef
        .doc(currentUserId)
        .get();
    currentUser = MyUser.fromDocument(documentSnapshot);
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.idscreen, (route) => false);
  }
}
