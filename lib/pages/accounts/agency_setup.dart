import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/otp.dart';
import 'package:hommie/pages/homepage.dart';

class AgencyRegistration extends StatefulWidget {
  static const String idscreen = "AgencyRegistration";
  final String accountType;
  AgencyRegistration({this.accountType});
  @override
  _AgencyRegistrationState createState() => _AgencyRegistrationState();
}

class _AgencyRegistrationState extends State<AgencyRegistration> {
  String agencyName;
  String phoneNumber;
  String taxIdNumber;
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
                      top: 30,
                    ),
                    child: Center(
                      child: Text(
                        "Agency Details",
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
                        labelText: 'Agency Name',
                      ),
                      onChanged: (value) {
                        agencyName = value;
                        print("agency: $agencyName");
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
                        prefixText: countryCode,
                         hintText: '712345678',
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
                    height: 20,
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
                        taxIdNumber = value;
                        print("tax id: $taxIdNumber");
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
                                    idNumber: taxIdNumber,
                                    name: agencyName,
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
                  child: Icon(Icons.cancel, size: 35, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
