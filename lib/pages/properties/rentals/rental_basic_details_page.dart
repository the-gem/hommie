import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/rentals/add_rental__external_amenities.dart';

class AddRentalBasicDetails extends StatefulWidget {
  TextEditingController landTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  final String listingType;
  final String listingSubCategory;
  final LatLng listingCoordinates;
  AddRentalBasicDetails(
      {this.listingSubCategory, this.listingType, this.listingCoordinates});
  @override
  _AddRentalBasicDetailsState createState() => _AddRentalBasicDetailsState();
}

class _AddRentalBasicDetailsState extends State<AddRentalBasicDetails> {
  addRentalAmenities() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalExternalAmenities(
          listingSubCategory: widget.listingSubCategory,
          listingType: widget.listingType,
          listingCoordinates: widget.listingCoordinates,
          genDescription: genDescription,
          landArea: landArea,
          propertyTitle: propertyTitle,
          rentAmount: rentAmount,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          deposit: deposit,
        ),
      ),
    );

    print(propertyTitle);
    print(genDescription);
    print(landArea);
    print('basic details: ${widget.listingCoordinates}');
  }

  String propertyTitle;
  String landArea;
  String genDescription;
  String rentAmount;
  String bedrooms;
  String bathrooms;
  String deposit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
                    "Property Details",
                    style: TextStyle(
                      color: Colors.blue.withBlue(100),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'title/property name',
                ),
                onChanged: (value) {
                  propertyTitle = value;
                  print("title: $propertyTitle");
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'rent amount',
                ),
                onChanged: (value) {
                  rentAmount = value;
                  print("rent amount: $rentAmount");
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'how much deposit is paid when moving in?',
                ),
                onChanged: (value) {
                  deposit = value;
                  print("deposit: $deposit");
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'number of rooms',
                ),
                onChanged: (value) {
                  bedrooms = value;
                  print("bedrooms: $bedrooms");
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'bathrooms',
                ),
                onChanged: (value) {
                  bathrooms = value;
                  print("bathrooms: $bathrooms");
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'land area in square feet',
                ),
                onChanged: (value) {
                  landArea = value;
                  print("land: $landArea");
                },
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => addRentalAmenities(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Colors.blue.withBlue(100),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text("next".toUpperCase(),
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
      ),
    );
  }
}
