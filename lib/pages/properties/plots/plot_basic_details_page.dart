import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/plots/upload_plot_images.dart';
import 'package:hommie/pages/properties/rentals/add_rental__external_amenities.dart';

class AddPlotBasicDetails extends StatefulWidget {
  TextEditingController landTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  final String listingType;
  final String listingSubCategory;
  final LatLng listingCoordinates;
  AddPlotBasicDetails(
      {this.listingSubCategory, this.listingType, this.listingCoordinates});
  @override
  _AddPlotBasicDetailsState createState() => _AddPlotBasicDetailsState();
}

class _AddPlotBasicDetailsState extends State<AddPlotBasicDetails> {
  addPlotImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPlotImages(
          listingCoordinates: widget.listingCoordinates,
          genDescription: genDescription,
          landArea: landArea,
          plotTitle: plotTitle,
        ),
      ),
    );
  }

  String plotTitle = "";
  String landArea = "";
  String genDescription = "";
  String price = "";

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
                    "PLot Details".toUpperCase(),
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
                  errorText: plotTitle.isEmpty || plotTitle == null
                      ? "please enter plot title"
                      : null,
                  labelText: 'title/plot name',
                ),
                onChanged: (value) {
                  plotTitle = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  errorText: price.isEmpty || price == null
                      ? "please enter some amount"
                      : null,
                  hintText: "2.5 M",
                  labelText: 'price',
                ),
                onChanged: (value) {
                  price = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'land area in acres',
                    hintText: "1/5"),
                onChanged: (value) {
                  landArea = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                // width: 250,
                child: TextField(
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'general description',
                  ),
                  onChanged: (value) {
                    genDescription = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => addPlotImages(),
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
