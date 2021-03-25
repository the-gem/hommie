import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:uuid/uuid.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String header;
  String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 60,
                    ),
                    child: Center(
                      child: Text(
                        "help us get better".toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue.withBlue(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'topic'.toUpperCase(),
                      ),
                      onChanged: (value) {
                        header = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    // width: 250,
                    child: TextField(
                      minLines: 10,
                      maxLines: 20,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        body = value;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isLoggedIn) {
                        sendFeedback();
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Login.idscreen, (route) => false);
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      color: Colors.blue.withBlue(150),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Text("send feedback".toUpperCase(),
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
            Positioned(
                right: 10,
                top: 30,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.idscreen, (route) => false);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 35,
                    color: Colors.blue.withBlue(150),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  sendFeedback() async {
    final CollectionReference feedbackRef =
        FirebaseFirestore.instance.collection("feedback");
    String feedbackId = Uuid().v4();
    await feedbackRef.doc(feedbackId).set({
      "header": header,
      "phone number": currentUser.phoneNumber,
      "body": body,
    }).then((value) {
      setState(() {
        feedbackId = Uuid().v4();
      });
      SnackBar snackbar = SnackBar(
        duration: Duration(seconds: 5),
        content: Text('well solve the issue as soon as possible!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });
  }
}
