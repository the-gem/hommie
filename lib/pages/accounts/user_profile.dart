import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String countryCode = "254";
  String landlordName;
  String landlordEmail;
  String landlordPhone;
  String phoneNumber;
  String officeLocation;
  String idNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 30,
          right: 30,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey[300],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5,
                        bottom: 5,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.blue.withBlue(150),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
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
              onTap: () => null,
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
                    child: Text("save".toUpperCase(),
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
}
