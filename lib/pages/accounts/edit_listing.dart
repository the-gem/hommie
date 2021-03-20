import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';

class EditListing extends StatefulWidget {
  @override
  _EditListingState createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
  GroupController securityController = GroupController(
    isMultipleSelection: true,
  );
  GroupController exAmenitiesController = GroupController(
    isMultipleSelection: true,
  );
  GroupController inAmenitiesController = GroupController(
    isMultipleSelection: true,
  );
  List securityFeatures = [];
  List internalAmenities = [];
  List externalAmenities = [];
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
      appBar: AppBar(
        title: Text(
          "edit property for rent",
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          print("saved!");
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.blue.withBlue(150),
            child: Center(
              child: Text("Save Updates",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            )),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 7,
              ),
              padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text("Basic Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        letterSpacing: 1,
                      )),
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
                        labelText: 'title/property name',
                      ),
                      onChanged: (value) {
                        propertyTitle = value;
                        print("title: $propertyTitle");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 7,
              ),
              padding: EdgeInsets.only(
                top: 15,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Add more photos",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          print("choose photos");
                        },
                        icon: Icon(Icons.add_a_photo, size: 27),
                        label: Text("Choose photos"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          print("upload photos");
                        },
                        icon: Icon(Icons.upload_sharp, size: 27),
                        label: Text("Upload photos"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 7,
              ),
              padding: EdgeInsets.only(
                top: 15,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Internal Amenities",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SimpleGroupedCheckbox<String>(
                      controller: inAmenitiesController,
                      itemsTitle: [
                        'furnished',
                        'internet',
                        'serviced',
                        'service charge included',
                        'hot shower',
                        'balcony',
                        'Backup Generator',
                        'En Suite',
                        'Walk In Closet',
                      ],
                      values: [
                        'furnished',
                        'internet',
                        'serviced',
                        'service charge included',
                        'hot shower',
                        'balcony',
                        'Backup Generator',
                        'En Suite',
                        'Walk In Closet',
                      ],
                      activeColor: Colors.blue.withBlue(100),
                      checkFirstElement: false,
                      onItemSelected: (selectedItems) {
                        print(selectedItems);
                        setState(() {
                          internalAmenities = selectedItems;
                        });
                        print("internal amenities $internalAmenities");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 7,
              ),
              padding: EdgeInsets.only(
                top: 15,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text("External Amenities",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        letterSpacing: 1,
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SimpleGroupedCheckbox<String>(
                      activeColor: Colors.blue.withBlue(100),
                      controller: exAmenitiesController,
                      itemsTitle: [
                        "laundry",
                        "lift",
                        "parking",
                        "gym",
                        "swimming pool"
                      ],
                      values: [
                        "laundry",
                        "lift",
                        "parking",
                        "gym",
                        "swimming pool",
                      ],
                      checkFirstElement: false,
                      onItemSelected: (selectedItems) {
                        print(selectedItems);
                        setState(() {
                          externalAmenities = selectedItems;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              // margin: EdgeInsets.only(
              //   bottom: 15,
              // ),
              padding: EdgeInsets.only(
                top: 15,
                bottom: 60,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text("Security Features",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        letterSpacing: 1,
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SimpleGroupedCheckbox<String>(
                      controller: securityController,
                      itemsTitle: [
                        'cctv surveillance',
                        'Alarm',
                        'Electric fence',
                        '24hr security watch',
                      ],
                      values: [
                        "cctv",
                        'Alarm',
                        "ElectricFence",
                        "securityWatch",
                      ],
                      activeColor: Colors.blue.withBlue(100),
                      checkFirstElement: false,
                      onItemSelected: (selectedItems) {
                        print(selectedItems);
                        setState(() {
                          securityFeatures = selectedItems;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
