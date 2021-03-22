import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:pinput/pin_put/pin_put.dart';

final auth = FirebaseAuth.instance;

class OtpScreen extends StatefulWidget {
  final String phone;
  final String accountType;
  final String name;
  final String location;
  String email;
  String phoneNumber;
  String idNumber;
  String profilePic;
  OtpScreen({
    this.phone,
    this.accountType,
    this.email,
    this.idNumber,
    this.location,
    this.name,
    this.phoneNumber,
    this.profilePic,
  });
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String _verificationCode;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
    print(widget.phoneNumber);
  }

  String myPin;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.green,
      ),
      home: Scaffold(
        bottomSheet: Container(
          color: Colors.blue.withBlue(150),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  elevation: 0,
                  primary: Colors.blue.withBlue(150),
                ),
                onPressed: () => _pinPutController.text = '',
                child: Text(
                  'Clear'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withBlue(150),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  elevation: 0,
                ),
                onPressed: () => submitPin(myPin),
                child: Text(
                  'next'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return ListView(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 40,
                  ),
                  child: Center(
                    child: Text(
                      "Enter Code".toUpperCase(),
                      style: TextStyle(
                        color: Colors.blue.withBlue(100),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.all(20.0),
                          child: PinPut(
                            fieldsCount: 5,
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            submittedFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            selectedFieldDecoration: _pinPutDecoration,
                            followingFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: Colors.deepPurpleAccent.withOpacity(.5),
                              ),
                            ),
                            onSubmit: (pin) {
                              submitPin(pin);
                              myPin = pin;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  submitPin(String pin) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: pin);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(phoneAuthCredential).then((value) async {
        if (value.user != null) {
          print("user logged in");
          FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                isLoggedIn = true;
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, HomePage.idscreen, (route) => false);
            } else {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(auth.currentUser.uid)
                  .collection(widget.accountType)
                  .doc(widget.name)
                  .set({
                "id": auth.currentUser.uid,
                "type": widget.accountType,
                "username": widget.name,
                "location": widget.location,
                "email address": widget.email,
                "phone number": widget.phoneNumber,
                "tax identification number": widget.idNumber,
                "profile picture": widget.profilePic,
              }).then((value) {
                setState(() {
                  isLoggedIn = true;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.idscreen, (route) => false);
              });
            }
          });
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      SnackBar snackbar = SnackBar(
          duration: Duration(milliseconds: 3000),
          content: Text("invalid otp code"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  verifyPhone() async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+254${widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            print("user logged in");
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e.message);
        // Handle other errors
      },
      codeSent: (String verificationId, int resendToken) async {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
    );
  }
}
