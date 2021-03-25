import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/models/rental.dart';
import 'package:hommie/pages/homepage.dart';

class EditListing extends StatefulWidget {
  String rentAmount;
  String propertyTitle;
  String listingType;
  String listingSubCategory;
  List externalAmenities;
  List internalAmenities;
  List imageUrls;
  GeoPoint listingCoordinates;
  String landArea;
  List securityFeatures;
  String location;
  String propertyId;
  String bedrooms;
  String bathrooms;
  String rentalOwnerId;
  String deposit;
  EditListing({
    this.externalAmenities,
    this.imageUrls,
    this.internalAmenities,
    this.landArea,
    this.listingCoordinates,
    this.listingSubCategory,
    this.listingType,
    this.propertyTitle,
    this.rentAmount,
    this.securityFeatures,
    this.location,
    this.propertyId,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
    this.rentalOwnerId,
  });

  @override
  _EditListingState createState() => _EditListingState(
      rentAmount: this.rentAmount,
      propertyTitle: this.propertyTitle,
      imageUrls: this.imageUrls,
      landArea: this.landArea,
      location: this.location,
      propertyId: this.propertyId,
      bathrooms: this.bathrooms,
      bedrooms: this.bedrooms,
      deposit: this.deposit,
      rentalOwnerId: this.rentalOwnerId);
}

class _EditListingState extends State<EditListing> {
  String rentAmount;
  String propertyId;
  String propertyTitle;
  String listingType;
  String listingSubCategory;
  List imageUrls;
  String landArea;
  String location;
  String bedrooms;
  String bathrooms;
  String deposit;
  String rentalOwnerId;
  _EditListingState({
    this.imageUrls,
    this.landArea,
    this.propertyTitle,
    this.rentAmount,
    this.location,
    this.propertyId,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
    this.rentalOwnerId,
  });
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController propertyTitleController = TextEditingController();
  TextEditingController landAreaController = TextEditingController();
  TextEditingController rentAmountController = TextEditingController();
  bool propertyTitleValid = true;
  @override
  void initState() {
    super.initState();
    getProperty();
  }

  getProperty() async {
    rental = Rental();
    DocumentSnapshot userDocSnap = await usersRef
        .doc(currentUserId)
        .collection("properties")
        .doc(propertyId)
        .get();
    rental = Rental.fromDocument(userDocSnap);
    setState(() {
      bedroomsController.text = rental.bedrooms;
      depositController.text = rental.deposit;
      bathroomsController.text = rental.bathrooms;
      landAreaController.text = rental.landArea;
      propertyTitleController.text = rental.propertyTitle;
      rentAmountController.text = rental.rentAmount;
    });
  }

  updateProperty() {
    setState(() {
      propertyTitleController.text.length < 3 ||
              propertyTitleController.text.isEmpty
          ? propertyTitleValid = false
          : propertyTitleValid = true;
      if (propertyTitleValid) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection("properties")
            .doc(widget.propertyId)
            .update({
          "rent amount": rentAmountController.text.trim(),
          "property title": propertyTitleController.text,
           "external amenities": selectedExternalAmenities.length == 0 ? widget.externalAmenities : selectedExternalAmenities,
          "internal amenities": selectedInternalAmenities.length == 0 ? widget.internalAmenities : selectedInternalAmenities,
          "land area": landAreaController.text.trim(),
          "security feature": selectedSecurityFeatures.length == 0 ? widget.securityFeatures : selectedSecurityFeatures,
          "bedrooms": bedroomsController.text,
          "bathrooms": bathroomsController.text,
          "deposit": depositController.text,
        }).then((value) {
          SnackBar snackbar = SnackBar(content: Text('update successful'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
    });
  }

  GroupController securityController = GroupController(
    isMultipleSelection: true,
  );
  GroupController exAmenitiesController = GroupController(
    isMultipleSelection: true,
  );
  GroupController inAmenitiesController = GroupController(
    isMultipleSelection: true,
  );
  List selectedSecurityFeatures = [];
  List selectedInternalAmenities = [];
  List selectedExternalAmenities = [];
  // String propertyTitle;
  // String landArea;
  // String genDescription;
  // String rentAmount;
  // String bedrooms;
  // String bathrooms;
  // String deposit;
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
          updateProperty();
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
                      controller: propertyTitleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'title/property name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: rentAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'rent amount',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: depositController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'how much deposit is paid when moving in?',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: bedroomsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'number of rooms',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: bathroomsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'bathrooms',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: landAreaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'land area in square feet',
                      ),
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
                        setState(() {
                          selectedInternalAmenities = selectedItems;
                        });
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
                        setState(() {
                          selectedExternalAmenities = selectedItems;
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
                        setState(() {
                          selectedSecurityFeatures = selectedItems;
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
