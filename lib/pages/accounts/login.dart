import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/otp.dart';
import 'package:hommie/pages/homepage.dart';

class Login extends StatefulWidget {
  static const String idscreen = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone;
  String phoneNumber;
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
                      top: 150,
                    ),
                    child: Center(
                      child: Text(
                        "enter phone number".toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue.withBlue(100),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixText: countryCode,
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      labelText: 'phone number',
                    ),
                    onChanged: (value) {
                      phoneNumber = value;
                        phone = countryCode + phoneNumber;
             
                    },
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    phoneNumber: phone,
                                  )));
                    },
                    child: Card(
                      // margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      color: Colors.blue.withBlue(150),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Text("continue".toUpperCase(),
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
}
