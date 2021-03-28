import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/models/user.dart';
import 'package:hommie/pages/homepage.dart';

class PlotFullPage extends StatefulWidget {
  final String price;
  final String plotTitle;
  final List imageUrls;
  final GeoPoint listingCoordinates;
  final String landArea;
  final String location;
  final String plotId;
  final String plotOwnerId;
  final String genDescription;
  PlotFullPage({
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
  _PlotFullPageState createState() => _PlotFullPageState(
      price: this.price,
      plotTitle: this.plotTitle,
      imageUrls: this.imageUrls,
      listingCoordinates: this.listingCoordinates,
      landArea: this.landArea,
      location: this.location,
      plotId: this.plotId,
      plotOwnerId: this.plotOwnerId);
}

class _PlotFullPageState extends State<PlotFullPage> {
  final String price;
  final String plotId;
  final String plotTitle;
  final List imageUrls;
  final GeoPoint listingCoordinates;
  final String landArea;
  final String location;
  final String plotOwnerId;
  _PlotFullPageState({
    this.imageUrls,
    this.landArea,
    this.listingCoordinates,
    this.plotTitle,
    this.price,
    this.location,
    this.plotId,
    this.plotOwnerId,
  });
  Container amenitygriditem(String amenityitem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            amenityitem,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.done_all,
            color: Colors.blue.withBlue(100),
          ),
        ],
      ),
    );
  }

  MyUser plotOwner;
  String userEmail = "";
  String ownerUsername = "";
  String userPhone = "";
  String userProfilePicture = "";
  @override
  void initState() {
    super.initState();
    _listOfImages = [];
    for (int i = 0; i < imageUrls.length; i++) {
      _listOfImages.add(NetworkImage(imageUrls[i]));
    }
    placeLoc =
        LatLng(listingCoordinates.latitude, listingCoordinates.longitude);
    myMarker.add(Marker(
        markerId: MarkerId(plotId),
        draggable: false,
        position:
            LatLng(listingCoordinates.latitude, listingCoordinates.longitude)));
    getUser();
  }

  List<Marker> myMarker = [];

  LatLng placeLoc;

  List<NetworkImage> _listOfImages = <NetworkImage>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view ${widget.plotTitle}".toUpperCase(),
            style: TextStyle(
              letterSpacing: 1,
              wordSpacing: 1,
            )),
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            imageUrls != null
                ? SizedBox(
                    height: 250,
                    child: Carousel(
                        autoplayDuration: Duration(seconds: 10),
                        boxFit: BoxFit.cover,
                        images: _listOfImages,
                        autoplay: true,
                        indicatorBgPadding: 5.0,
                        dotPosition: DotPosition.bottomCenter,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 2000)),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              alignment: Alignment.topLeft,
              // width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text(
                      plotTitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "Kshs ${widget.price}",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.withBlue(100)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "$landArea acres".toUpperCase(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  child: GoogleMap(
                    markers: Set.from(myMarker),
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: placeLoc,
                      zoom: 16.0,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  child: Text(
                    widget.location,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )),
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "general description".toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
              ),
            ),
            widget.genDescription.isNotEmpty ?
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                widget.genDescription,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
              ),
            ) : Container(),
            Container(
              width: 200,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          userProfilePicture,
                        ),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(height: 10),
                  Text(
                    ownerUsername.toUpperCase(),
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    userPhone,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userEmail.isNotEmpty ? userEmail : "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUser() async {
    plotOwner = MyUser();
    DocumentSnapshot userDocSnap = await usersRef.doc(widget.plotOwnerId).get();
    plotOwner = MyUser.fromDocument(userDocSnap);
    setState(() {
      userEmail = plotOwner.email;
      ownerUsername = plotOwner.username;
      userPhone = plotOwner.phoneNumber;
      userProfilePicture = plotOwner.profilePicture[0];
    });
  }
}
