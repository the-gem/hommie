import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/rentals/uploadimages.dart';

class AddRentalSecurityFeatures extends StatefulWidget {
  String listingType;
  String listingSubCategory;
  LatLng listingCoordinates;
  String propertyTitle;
  String landArea;
  String genDescription;
  List externalAmenities = [];
  List internalAmenities = [];
  String rentAmount;
  String bedrooms;
  String bathrooms;
  String deposit;
  AddRentalSecurityFeatures({
    this.externalAmenities,
    this.internalAmenities,
    this.listingSubCategory,
    this.listingType,
    this.listingCoordinates,
    this.landArea,
    this.propertyTitle,
    this.genDescription,
    this.rentAmount,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
  });
  @override
  _AddRentalSecurityFeaturesState createState() =>
      _AddRentalSecurityFeaturesState();
}

class _AddRentalSecurityFeaturesState extends State<AddRentalSecurityFeatures> {
  addPhotosAndUpload() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadImages(
          landArea: widget.landArea,
          externalAmenities: widget.externalAmenities,
          internalAmenities: widget.internalAmenities,
          listingSubCategory: widget.listingSubCategory,
          listingType: widget.listingType,
          listingCoordinates: widget.listingCoordinates,
          propertyTitle: widget.propertyTitle,
          rentAmount: widget.rentAmount,
          securityFeatures: securityFeatures,
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
  List securityFeatures = [];
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
                    "Security",
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
                      'cctv surveillance',
                      'electric fence',
                      '24hr security watch',
                    ],
                    values: [
                      "cctv",
                      "electricFence",
                      "securityWatch",
                    ],
                    activeColor: Colors.red,
                    checkFirstElement: false,
                    onItemSelected: (selectedItems) {
                      print(selectedItems);
                      setState(() {
                        securityFeatures = selectedItems;
                      });
                      print(
                          'dataa ${widget.listingSubCategory},${widget.listingCoordinates},${widget.landArea}, ${widget.internalAmenities}');
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => addPhotosAndUpload(),
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
