import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hommie/main.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/homepage.dart';

class ResetPassword extends StatefulWidget {
  static const String idscreen = "restpassword";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: 
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
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.blue.withBlue(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
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
                        labelText: 'email address',
                      ),
                      onChanged: (value) {
                        email = value;
                        print("landlord email: $email");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => resetPassword(),
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
                          child: Text("reset password".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "log into your account",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
      ),
    );
  }

  resetPassword() async {
    var auth = FirebaseAuth.instance;
    try {
      auth.sendPasswordResetEmail(email: email).then((_) {
        // Email sent.
        SnackBar snackbar = SnackBar(
            duration: Duration(milliseconds: 3000),
            content: Text('email reset password sent!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } catch (e) {
      SnackBar snackbar = SnackBar(
          duration: Duration(milliseconds: 3000), content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    }
  }
}
