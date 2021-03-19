import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/rentals/add_rental_security_features.dart';

class AddRentalInternalAmenities extends StatefulWidget {
  String listingType;
  String listingSubCategory;
  LatLng listingCoordinates;
  String propertyTitle;
  String landArea;
  String genDescription;
  String rentAmount;
  List externalAmenities = [];
  String bedrooms;
  String bathrooms;
  String deposit;
  AddRentalInternalAmenities({
    this.externalAmenities,
    this.listingSubCategory,
    this.listingType,
    this.listingCoordinates,
    this.genDescription,
    this.landArea,
    this.propertyTitle,
    this.rentAmount,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
  });
  @override
  _AddRentalInternalAmenitiesState createState() =>
      _AddRentalInternalAmenitiesState();
}

class _AddRentalInternalAmenitiesState
    extends State<AddRentalInternalAmenities> {
  addRentalSecurityFeatures() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalSecurityFeatures(
          landArea: widget.landArea,
          externalAmenities: widget.externalAmenities,
          internalAmenities: internalAmenities,
          listingSubCategory: widget.listingSubCategory,
          listingType: widget.listingType,
          listingCoordinates: widget.listingCoordinates,
          propertyTitle: widget.propertyTitle,
          rentAmount: widget.rentAmount,
          bathrooms: widget.bathrooms,
          bedrooms: widget.bedrooms,
          deposit: widget.deposit,
        ),
      ),
    );
  }

  GroupController controller = GroupController(
    isMultipleSelection: true,
  );
  List internalAmenities = [];
  String furnished;
  String internet;
  String serviced;
  String chargeIncluded;
  String balcony;
  String shower;
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
                    "Internal Amenities",
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
                    controller: controller,
                    itemsTitle: [
                      'furnished',
                      'internet',
                      'serviced',
                      'service charge included',
                      'hot shower',
                      'balcony',
                      'Alarm',
                      'Backup Generator',
                      'En Suite',
                      'Fibre Internet',
                      'Walk In Closet',
                    ],
                    values: [
                      'furnished',
                      'internet',
                      'serviced',
                      'service charge included',
                      'hot shower',
                      'balcony',
                      'Alarm',
                      'Backup Generator',
                      'En Suite',
                      'Fibre Internet',
                      'Walk In Closet',
                    ],
                    activeColor: Colors.red,
                    checkFirstElement: false,
                    onItemSelected: (selectedItems) {
                      print(selectedItems);
                      setState(() {
                        internalAmenities = selectedItems;
                      });
                      print("external amenities ${widget.externalAmenities}");
                      print("internal amenities $internalAmenities");
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => addRentalSecurityFeatures(),
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
