import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/main.dart';
import 'package:hommie/pages/accounts/choose_account_type.dart';
import 'package:hommie/pages/accounts/reset_password.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/widgets/progress_dialog.dart';

class Login extends StatefulWidget {
  static const String idscreen = "Login";
  final String accountType;
  Login({this.accountType});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      top: 60,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue.withBlue(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 44,
                        ),
                      ),
                    ),
                  ),
                  TextField(
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
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
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
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Text("Login".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseAccountType()));
                          },
                          child: Text(
                            "create account",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                          },
                          child: Text(
                            "reset password",
                             style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
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

  Future<void> createAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging into your account...",
          );
        });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: landlordEmail, password: password)
          .then((_) {
        if (user.uid != null) {
          setState(() {
            isLoggedIn = true;
          });
          if (user.emailVerified) {
            SnackBar snackbar = SnackBar(
                duration: Duration(milliseconds: 3000),
                content: Text('login success!'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.idscreen, (route) => false);
          } else {
            verifyUser();
          }
        }
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

    return user.uid;
  }

  verifyUser() async {
    await user.sendEmailVerification();
    SnackBar snackbar = SnackBar(content: Text('please verify your email'));
    SnackBar snackbar2 = SnackBar(
        duration: Duration(milliseconds: 3000),
        content: Text('verification email sent!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    ScaffoldMessenger.of(context).showSnackBar(snackbar2);
  }
}
