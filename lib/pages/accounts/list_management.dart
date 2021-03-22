import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/edit_listing.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/pages/properties/rentals/create_listing.dart';
import 'package:hommie/pages/properties/rentals/rental_full_page.dart';

class ListManagement extends StatefulWidget {
  @override
  _ListManagementState createState() => _ListManagementState();
}

class _ListManagementState extends State<ListManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("your listings"),
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            isLoggedIn
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateListing(),
                    ),
                  )
                : Navigator.pushNamedAndRemoveUntil(
                    context, Login.idscreen, (route) => false);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.blue.withBlue(150),
              child: Center(
                child: Text("Add Listing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              )),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: ListView(
            addAutomaticKeepAlives: true,
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: Text("Property for rent",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: Text(
                              "ruaka, kiambaa",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: Text(
                              "Kshs 23000",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  label: Text("view",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => RentalFullPage(),
                                    //     ));
                                    print("gone to full page");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white, // background
                                  ),
                                ),
                                ElevatedButton.icon(
                                  label: Text("edit",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditListing(),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white, // background
                                  ),
                                ),
                                ElevatedButton.icon(
                                  label: Text("delete",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 10,
                                            title: Text(
                                              "Confirmation",
                                              style: TextStyle(
                                                color:
                                                    Colors.blue.withBlue(100),
                                                fontSize: 25,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Text(
                                              "You are about to delete this listing, do you wish to continue?",
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.blue,
                                                      ),
                                                      onPressed: () {
                                                        print("cancelled!");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel")),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        print("deleted!");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Delete")),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white, // background
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
