import 'package:flutter/material.dart';
import 'package:hommie/pages/properties/rentals/add_property_location.dart';

class CreateListing extends StatefulWidget {
  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  String dropdownValue = 'rental';
  String rentalCategoryValue = "apartment";
  addRentalLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyLocation(
          listingType: dropdownValue,
          listingSubCategory: rentalCategoryValue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.withBlue(100),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    "upload listing".toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Card(
                  margin: EdgeInsets.only(top: 100),
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20,),),),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['rental',]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Select rental category",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        DropdownButton<String>(
                          value: rentalCategoryValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          onChanged: (String newValue) {
                            setState(() {
                              rentalCategoryValue = newValue;
                            });
                          },
                          items: <String>[
                            'apartment',
                            'bedsitter',
                            'warehouse',
                            'studio',
                            'shop',
                            'offices',
                            'commercial property',
                            'villas',
                            'townhouse',
                            'house',
                            'other',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 22,
                                  )),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => addRentalLocation(),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            color: Colors.blue.withBlue(150),
                            child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                      "add property location".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                          ),
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
    );
  }
}
