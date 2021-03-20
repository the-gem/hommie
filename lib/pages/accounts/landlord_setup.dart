import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/main.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/widgets/progress_dialog.dart';

class LandLordRegistration extends StatefulWidget {
  static const String idscreen = "LandlordRegistration";
  final String accountType;
  LandLordRegistration({this.accountType});
  @override
  _LandLordRegistrationState createState() => _LandLordRegistrationState();
}

class _LandLordRegistrationState extends State<LandLordRegistration> {
  String countryCode = "254";
  String landlordName;
  String landlordEmail;
  String landlordPhone;
  String phoneNumber;
  String officeLocation;
  String idNumber;
  String password;
  bool isObsecure = true;
  Icon obsecureIcon = Icon(Icons.visibility_off);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
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
                        "Landlord Details",
                        style: TextStyle(
                          color: Colors.blue.withBlue(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
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
                        labelText: 'Full name',
                      ),
                      onChanged: (value) {
                        landlordName = value;
                        print("landlord: $landlordName");
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
                        labelText: 'email address',
                      ),
                      onChanged: (value) {
                        landlordEmail = value;
                        print("landlord email: $landlordEmail");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          width: MediaQuery.of(context).size.width * 0.30 - 20,
                    height: 50,
                          child: DropdownButton<String>(
                            value: countryCode,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (String newValue) {
                              setState(() {
                                countryCode = newValue;
                              });
                            },
                            items: <String>[
                              '254',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.70 - 20,
                    height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              labelText: 'phone number',
                            ),
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {
                                landlordPhone = countryCode + phoneNumber;
                              });
                              print("phone number: $landlordPhone");
                            },
                          ),
                        ),
                      ],
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
                        labelText: 'tax identification number',
                      ),
                      onChanged: (value) {
                        idNumber = value;
                        print("id: $idNumber");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      obscureText: isObsecure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObsecure
                                ? setState(() {
                                    isObsecure = false;
                                    obsecureIcon = Icon(Icons.remove_red_eye);
                                  })
                                : setState(() {
                                    isObsecure = true;
                                    obsecureIcon = Icon(Icons.visibility_off);
                                  });
                          },
                          icon: obsecureIcon,
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                        print("password: $password");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => createAccount(),
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
             Positioned(
              right: 10,
              top: 30,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.idscreen, (route) => false);
                },
                child: Icon(Icons.cancel, size: 35, color: Colors.blue.withBlue(150)),
              )),
          ],
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Creating your account...",
          );
        });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: landlordEmail, password: password)
          .then((_) {
        FirebaseFirestore.instance
            .collection(widget.accountType)
            .doc(landlordName)
            .set({
          "id": user.uid,
          "username": landlordName,
          "location": officeLocation,
          "email address": landlordEmail,
          "phone number": landlordPhone,
          "tax identification number": idNumber,
        });
        SnackBar snackbar =
            SnackBar(content: Text('Account was created successully'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBar snackbar =
            SnackBar(content: Text('The password provided is too weak.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBar snackbar = SnackBar(
            content: Text('The account already exists for that email.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      print(e);
    }
    if (user.uid != null) {
      setState(() {
        isLoggedIn = true;
      });
      user.emailVerified
          ? Navigator.pushNamedAndRemoveUntil(
              context, Login.idscreen, (route) => false)
          : verifyUser();
    }

    return user.uid;
  }

  verifyUser() async {
    SnackBar snackbar = SnackBar(
        duration: Duration(milliseconds: 3000),
        content: Text('verification email sent!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    Navigator.pushNamedAndRemoveUntil(
        context, Login.idscreen, (route) => false);
  }
}
