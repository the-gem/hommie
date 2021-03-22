import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/otp.dart';
import 'package:hommie/pages/homepage.dart';

class LandLordRegistration extends StatefulWidget {
  static const String idscreen = "LandlordRegistration";
  final String accountType;
  LandLordRegistration({this.accountType});
  @override
  _LandLordRegistrationState createState() => _LandLordRegistrationState();
}

class _LandLordRegistrationState extends State<LandLordRegistration> {
  String landlordName;
  String phoneNumber;
  String idNumber;
  String phone;
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
                        labelText: 'phone number',
                        hintText: '712345678',
                        prefixText: countryCode,
                      ),
                      onChanged: (value) {
                        phoneNumber = value;
                        phone = countryCode + phoneNumber;
                        print(phone);
                        print("phone number: $phoneNumber");
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    phoneNumber: phone,
                                    accountType: widget.accountType,
                                    idNumber: idNumber,
                                    name: landlordName,
                                  )));
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
            Positioned(
                right: 10,
                top: 30,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.idscreen, (route) => false);
                  },
                  child: Icon(Icons.cancel,
                      size: 35, color: Colors.blue.withBlue(150)),
                )),
          ],
        ),
      ),
    );
  }
}
