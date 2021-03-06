import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/edit_rental_listing.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/pages/properties/rentals/create_listing.dart';
import 'package:hommie/pages/properties/rentals/rental_full_page.dart';

class RentalListManagement extends StatefulWidget {
  @override
  _RentalListManagementState createState() => _RentalListManagementState();
}

class _RentalListManagementState extends State<RentalListManagement> {
  CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(currentUserId)
      .collection('rentals');
  @override
  Widget build(BuildContext context) {
    Stream collectionStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('rentals')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: collectionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Something went wrong')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Loading..",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.withBlue(150),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(

          bottomSheet: GestureDetector(
            onTap: () {
              isLoggedIn
                  ? Navigator.pushReplacement(
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
                  child: Text("Add Rental Listing",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                )),
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 50),
            child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Card(
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
                        image: DecorationImage(
                          image: NetworkImage(document["image urls"][0]),
                          fit: BoxFit.cover,
                        ),
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
                            child: Text(document.data()['property title'],
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: Text(
                              document["location"],
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
                              "Kshs ${document["rent amount"]} per month",
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RentalFullPage(
                                            rentAmount: document["rent amount"],
                                            propertyTitle:
                                                document["property title"],
                                            listingType:
                                                document["listing type"],
                                            listingSubCategory: document[
                                                "listing sub category"],
                                            externalAmenities:
                                                document["external amenities"],
                                            internalAmenities:
                                                document["internal amenities"],
                                            listingCoordinates:
                                                document["coords"],
                                            landArea: document["land area"],
                                            securityFeatures:
                                                document["security feature"],
                                            imageUrls: document["image urls"],
                                            location: document["location"],
                                            propertyId: document["property id"],
                                            bedrooms: document["bedrooms"],
                                            bathrooms: document["bathrooms"],
                                            deposit: document["deposit"],
                                            rentalOwnerId: document["user id"],
                                          ),
                                        ));
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
                                          builder: (context) => EditRentalListing(
                                            rentAmount: document["rent amount"],
                                            propertyTitle:
                                                document["property title"],
                                            listingType:
                                                document["listing type"],
                                            listingSubCategory: document[
                                                "listing sub category"],
                                            externalAmenities:
                                                document["external amenities"],
                                            internalAmenities:
                                                document["internal amenities"],
                                            listingCoordinates:
                                                document["coords"],
                                            landArea: document["land area"],
                                            securityFeatures:
                                                document["security feature"],
                                            imageUrls: document["image urls"],
                                            location: document["location"],
                                            rentalId: document["property id"],
                                            bedrooms: document["bedrooms"],
                                            bathrooms: document["bathrooms"],
                                            deposit: document["deposit"],
                                            rentalOwnerId: document["user id"],
                                          ),
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
                                                        userCollection
                                                            .doc(document[
                                                                "property id"])
                                                            .delete();

                                                        Navigator.of(context)
                                                            .pop();
                                                        SnackBar snackbar = SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    3000),
                                                            content: Text(
                                                                "listing has been removed"));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackbar);
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
              );
            }).toList()),
          ),
        );
      },
    );
  }
}
