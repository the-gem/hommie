import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/rentals/add_rental_internal_amenities.dart';

class AddRentalExternalAmenities extends StatefulWidget {
  String listingType;
  String listingSubCategory;
  LatLng listingCoordinates;
  String propertyTitle;
  String landArea;
  String genDescription;
  String rentAmount;
  String bedrooms;
  String bathrooms;
  String deposit;
  AddRentalExternalAmenities({
    this.rentAmount,
    this.listingSubCategory,
    this.listingType,
    this.listingCoordinates,
    this.genDescription,
    this.landArea,
    this.propertyTitle,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
  });
  @override
  _AddRentalExternalAmenitiesState createState() =>
      _AddRentalExternalAmenitiesState();
}

class _AddRentalExternalAmenitiesState
    extends State<AddRentalExternalAmenities> {
  addRentalInternalAmenities() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalInternalAmenities(
          listingSubCategory: widget.listingSubCategory,
          listingType: widget.listingType,
          listingCoordinates: widget.listingCoordinates,
          genDescription: widget.genDescription,
          landArea: widget.landArea,
          propertyTitle: widget.propertyTitle,
          rentAmount: widget.rentAmount,
          externalAmenities: externalAmenities,
          bathrooms: widget.bathrooms,
          bedrooms: widget.bedrooms,
          deposit: widget.deposit,
        ),
      ),
    );
    print("external amenities$externalAmenities");

    print('coordinates: ${widget.listingCoordinates}');
  }

  String parking;
  String lift;
  String gym;
  String pool;
  String laundry;
  String generator;
  GroupController controller = GroupController(
    isMultipleSelection: true,
  );
  List externalAmenities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withBlue(100),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 50,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    "External Amenities",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SimpleGroupedCheckbox<String>(
                    activeColor: Colors.blue.withBlue(100),
                    controller: controller,
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
                GestureDetector(
                  onTap: () => addRentalInternalAmenities(),
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
      ),
    );
  }
}
