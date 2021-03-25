import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/agency_setup.dart';
import 'package:hommie/pages/accounts/landlord_setup.dart';
import 'package:hommie/pages/homepage.dart';

class ChooseAccountType extends StatefulWidget {
  static const String idscreen = "choose account type";
  @override
  _ChooseAccountTypeState createState() => _ChooseAccountTypeState();
}

class _ChooseAccountTypeState extends State<ChooseAccountType> {
  String accountType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withBlue(150),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
              top: 100,
            ),
            child: Center(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: Text("Choose one",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        accountType = "landlord";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandLordRegistration(
                                    accountType: accountType,
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              color: Colors.transparent,
                              child: Center(
                                  child: Text(
                                "LandLord",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              )),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        accountType = "agent";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgencyRegistration(
                                    accountType: accountType,
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              color: Colors.transparent,
                              child: Center(
                                child: Text(
                                  "Real Estate Agency",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
    );
  }
}
