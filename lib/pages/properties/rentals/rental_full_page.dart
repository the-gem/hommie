import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RentalFullPage extends StatefulWidget {
  final String rentAmount;
  final String propertyTitle;
  final String listingType;
  final String listingSubCategory;
  final List externalAmenities;
  final List internalAmenities;
  final List imageUrls;
  final GeoPoint listingCoordinates;
  final String landArea;
  final List securityFeatures;
  final String location;
  final String postId;
  final String bedrooms;
  final String bathrooms;
  final String deposit;
  RentalFullPage({
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
    this.postId,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
  });
  @override
  _RentalFullPageState createState() => _RentalFullPageState(
        rentAmount: this.rentAmount,
        propertyTitle: this.propertyTitle,
        listingType: this.listingType,
        listingSubCategory: this.listingSubCategory,
        externalAmenities: this.externalAmenities,
        internalAmenities: this.internalAmenities,
        imageUrls: this.imageUrls,
        listingCoordinates: this.listingCoordinates,
        landArea: this.landArea,
        securityFeatures: this.securityFeatures,
        location: this.location,
        postId: this.postId,
        bathrooms: this.bathrooms,
        bedrooms: this.bedrooms,
        deposit: this.deposit,
      );
}

class _RentalFullPageState extends State<RentalFullPage> {
  final String rentAmount;
  final String postId;
  final String propertyTitle;
  final String listingType;
  final String listingSubCategory;
  final List externalAmenities;
  final List internalAmenities;
  final List imageUrls;
  final GeoPoint listingCoordinates;
  final String landArea;
  final List securityFeatures;
  final String location;
  final String bedrooms;
  final String bathrooms;
  final String deposit;
  _RentalFullPageState(
      {this.externalAmenities,
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
      this.postId,
      this.bathrooms,
      this.bedrooms,
      this.deposit});
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
        markerId: MarkerId(postId),
        draggable: false,
        position:
            LatLng(listingCoordinates.latitude, listingCoordinates.longitude)));
    print(postId);
  }

  List<Marker> myMarker = [];

  LatLng placeLoc;

  List<NetworkImage> _listOfImages = <NetworkImage>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.grey[300],
            child: SingleChildScrollView(
                child: Column(
              children: [
                imageUrls != null
                    ? SizedBox(
                        height: 250,
                        child: Carousel(
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
                  // height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                                propertyTitle.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                "Kshs ${widget.rentAmount}/month",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.withBlue(100)),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.king_bed,
                                          size: 28,
                                        ),
                                        Text(bedrooms)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.bathtub,
                                        ),
                                        Text(bathrooms)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                "$landArea sq. ft",
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
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                "quick facts".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "property type".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        listingSubCategory,
                                        style: TextStyle(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "deposit".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "kshs $deposit",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        child: Center(
                          child: Text(
                            "Amenities".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
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
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              "External".toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                            Column(
                              children: [
                                for (var item in widget.externalAmenities)
                                  amenitygriditem("$item")
                              ],
                            ),
                          ],
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
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              "Internal".toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                            Column(
                              children: [
                                for (var item in widget.internalAmenities)
                                  amenitygriditem("$item")
                              ],
                            ),
                          ],
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
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              "security".toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                            Column(
                              children: [
                                for (var item in widget.securityFeatures)
                                  amenitygriditem("$item")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.all(7),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width * 0.8,
                //         child: Text(
                //             "Wealthlink presents an executive,2br apartment in the heart of Westlands, off Waiyaki way, Mvuli road On 4th Floor, spacious, modern, airly, with alot of natural lighting Key Features: Spacious living room, with a spacious balcony Modern spacious fitted kitchen with a cooker, fridge, oven, microwave, water heater, Spacious pantry Spacious dhobi area with a washing Machine Visitors washroom Ensuite Bedroom, spacious with sufficient closet Ensuite Master bedroom with a bath tub, shower cubicle, double sink Wooden floor and tiled on wet areas. Very secure, perimeter wall, electric fence, back up generator, sufficient water supply with a borehole Ample parking Contact us for more information and viewing arrangement"),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "About the agent",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              "assets/images/logo.jpg",
                            ),
                            backgroundColor: Colors.grey[200],
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company name",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "over 5+ years in real estate",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "5 property in management",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(children: [
                                  Icon(Icons.phone),
                                  SizedBox(width: 6),
                                  Text(
                                    "0798767470",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Icon(Icons.email),
                                  SizedBox(width: 6),
                                  Text(
                                    "brian@email.com",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }
}
