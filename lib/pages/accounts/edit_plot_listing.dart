import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/models/plot.dart';
import 'package:hommie/pages/homepage.dart';

class EditPlotListing extends StatefulWidget {
  String price;
  String plotTitle;
  List imageUrls;
  GeoPoint listingCoordinates;
  String landArea;
  String location;
  String plotId;
  String plotOwnerId;
  String genDescription;
  EditPlotListing({
    this.imageUrls,
    this.landArea,
    this.listingCoordinates,
    this.plotTitle,
    this.price,
    this.location,
    this.plotId,
    this.plotOwnerId,
    this.genDescription,
  });

  @override
  _EditPlotListingState createState() => _EditPlotListingState(
        price: this.price,
        plotTitle: this.plotTitle,
        imageUrls: this.imageUrls,
        landArea: this.landArea,
        location: this.location,
        plotId: this.plotId,
        plotOwnerId: this.plotOwnerId,
        genDescription: this.genDescription,
      );
}

class _EditPlotListingState extends State<EditPlotListing> {
  String price;
  String plotId;
  String plotTitle;
  List imageUrls;
  String landArea;
  String location;
  String plotOwnerId;
  String genDescription;
  _EditPlotListingState({
    this.imageUrls,
    this.landArea,
    this.plotTitle,
    this.price,
    this.location,
    this.plotId,
    this.plotOwnerId,
    this.genDescription,
  });
  TextEditingController genDescriptionController = TextEditingController();
  TextEditingController plotTitleController = TextEditingController();
  TextEditingController landAreaController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool plotTitleValid = true;
  @override
  void initState() {
    super.initState();
    getProperty();
  }

  getProperty() async {
    plot = Plot();
    DocumentSnapshot plotDocumantSnapshot =
        await usersRef.doc(currentUserId).collection("plots").doc(plotId).get();
    plot = Plot.fromDocument(plotDocumantSnapshot);
    setState(() {
      genDescriptionController.text = plot.genDescription;
      landAreaController.text = plot.landArea;
      plotTitleController.text = plot.plotTitle;
      priceController.text = plot.price;
    });
  }

  updateProperty() {
    setState(() {
      plotTitleController.text.length < 3 || plotTitleController.text.isEmpty
          ? plotTitleValid = false
          : plotTitleValid = true;
      if (plotTitleValid) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection("plots")
            .doc(widget.plotId)
            .update({
          "price": priceController.text.trim(),
          "plot title": plotTitleController.text,
          "land area": landAreaController.text.trim(),
          "general description": genDescriptionController.text,
        }).then((value) {
          SnackBar snackbar = SnackBar(content: Text('update successful'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "edit $plotTitle",
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
                  Text("Basic Plot Details",
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
                      controller: plotTitleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'title/plot name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'price',
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelText: 'land area in acres',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // width: 250,
                    child: TextField(
                      controller: genDescriptionController,
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
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
