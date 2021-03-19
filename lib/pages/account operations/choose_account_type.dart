import 'package:flutter/material.dart';
import 'package:hommie/pages/account%20operations/agency_setup.dart';
import 'package:hommie/pages/account%20operations/landlord_setup.dart';

class ChooseAccountType extends StatefulWidget {
  @override
  _ChooseAccountTypeState createState() => _ChooseAccountTypeState();
}

class _ChooseAccountTypeState extends State<ChooseAccountType> {
  String accountType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  accountType = "landlord";
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LandLordRegistration(
                  accountType: accountType,
                )));
              },
              child: Card(
                child: Text("LandLord"),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  accountType = "agent";
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AgencyRegistration(
                  accountType: accountType,
                )));
              },
              child: Card(
                child: Text("Real Estate Agency"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
