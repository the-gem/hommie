import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/models/rental.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/properties/rentals/create_listing.dart';
import 'package:hommie/pages/properties/rentals/rental_full_page.dart';
import 'package:hommie/widgets/drawer_list.dart';

final rentalsTimelineRef = FirebaseFirestore.instance;
final Reference storageRef = FirebaseStorage.instance.ref("rental");
final DateTime timestamp = DateTime.now();
FirebaseFirestore firestore = FirebaseFirestore.instance;
bool isLoggedIn = false;
String currentUserId = '';
FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "+254";

class HomePage extends StatefulWidget {
  static const String idscreen = "homescreen";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Marker> allMarkers = [];
  List<Rental> rentals = [];
  double mapBottomPadding = 0;

  getTimeline() async {
    QuerySnapshot rentalsSnapshot =
        await rentalsTimelineRef.collection("rental").get();

    List<Rental> rentalsTimelinePosts = rentalsSnapshot.docs
        .map((rentalsSnapshot) => Rental.fromDocument(rentalsSnapshot))
        .toList();
    setState(() {
      this.rentals = rentalsTimelinePosts;
      rentals.isEmpty || rentals == null
          ? mapBottomPadding = 0
          : mapBottomPadding = 120;
      rentals.forEach((element) {
        allMarkers.add(Marker(
            markerId: MarkerId(element.propertyId),
            draggable: false,
            infoWindow: InfoWindow(
                title: element.propertyTitle,
                snippet: element.rentAmount,
                onTap: () {
                  // moveCamera();
                  showRentalFullPage();
                }),
            position: LatLng(element.listingCoordinates.latitude,
                element.listingCoordinates.longitude)));
        print("external amenities ${element.externalAmenities}");
        this.allMarkers = allMarkers;
      });
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
        ..addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      allMarkers != null ?? moveCamera();
    }
  }

  showRentalFullPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentalFullPage(),
        ));
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      currentUserId = "";
      if (auth.currentUser == null) {
        print('User is currently signed out!');
        isLoggedIn = false;
      } else {
        currentUserId = auth.currentUser.uid;
        isLoggedIn = true;
        print('User is signed in!');
      }
    });
    super.initState();
    getTimeline();
  }

  PageController _pageController;
  int prevPage;
  final LatLng _nairobi = const LatLng(-1.286389, 36.817223);

  String searchAddr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUserId),
      ),
      drawer: Drawer(
        child: DrawerList(),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: Set.from(allMarkers),
              padding: EdgeInsets.only(
                top: 60,
                bottom: mapBottomPadding,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                getTimeline();
              },
              initialCameraPosition: CameraPosition(
                target: _nairobi,
                zoom: 13.0,
              ),
            ),
            Positioned(
              top: 70,
              left: 11,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.withBlue(100),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getTimeline();
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: rentals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _rentalsList(index);
                    },
                  )),
            ),
            Positioned(
              bottom: mapBottomPadding + 15,
              child: Column(
                children: [
                  // FloatingActionButton(
                  //   backgroundColor: Colors.blue.withBlue(100),
                  //   heroTag: "search",
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => GetPropertyLocation(),
                  //       ),
                  //     );
                  //   },
                  //   tooltip: 'search',
                  //   child: Icon(Icons.search),
                  // ),
                  // SizedBox(height: 10),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.blue.withBlue(100),
                    heroTag: "add listing",
                    onPressed: () {
                      isLoggedIn
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateListing(),
                              ),
                            )
                          : Navigator.pushNamedAndRemoveUntil(
                              context, Login.idscreen, (route) => false);
                    },
                    // tooltip: 'add listing',
                    // child: Icon(Icons.add),
                    label: Text(
                      'Add listing',
                      style: TextStyle(fontSize: 12),
                    ),
                    icon: Icon(Icons.add, size: 15),
                    // backgroundColor: Colors.pink,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 30,
              right: 30,
              child: Container(
                width: 300,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 25,
                          color: Colors.black,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState.openDrawer()),
                    Container(
                      width: 150,
                      // constraints: BoxConstraints(maxWidth: 220),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "search place...",
                            hintStyle: TextStyle(fontSize: 15)),
                        onChanged: (value) {
                          setState(() {
                            searchAddr = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: searchAndNavigate,
                      child: Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              rentals[_pageController.page.toInt()]
                  .listingCoordinates
                  ?.latitude,
              rentals[_pageController.page.toInt()]
                  .listingCoordinates
                  ?.longitude),
          zoom: 20,
          bearing: 45,
          tilt: 45,
        ),
      ),
    );
  }

  _rentalsList(index) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          double value = 1;

          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 125.0,
              width: Curves.easeInOut.transform(value) * 350.0,
              child: widget,
            ),
          );
        },
        child: InkWell(
          onTap: () {
            // showRentalFullPage();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RentalFullPage(
                    rentAmount: rentals[index].rentAmount,
                    propertyTitle: rentals[index].propertyTitle,
                    listingType: rentals[index].listingType,
                    listingSubCategory: rentals[index].listingSubCategory,
                    externalAmenities: rentals[index].externalAmenities,
                    internalAmenities: rentals[index].internalAmenities,
                    listingCoordinates: rentals[index].listingCoordinates,
                    landArea: rentals[index].landArea,
                    securityFeatures: rentals[index].securityFeatures,
                    imageUrls: rentals[index].imageUrls,
                    location: rentals[index].location,
                    propertyId: rentals[index].propertyId,
                    bedrooms: rentals[index].bedrooms,
                    bathrooms: rentals[index].bathrooms,
                    deposit: rentals[index].deposit,
                  ),
                ));
          },
          child: Stack(
            children: [
              Center(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 100,
                    width: 265,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    // margin: EdgeInsets.symmetric(
                    //   horizontal: 10,
                    //   vertical: 20,
                    // ),
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(rentals[index].imageUrls[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("type: ${rentals[index].listingType}"),
                            Text("${rentals[index].listingSubCategory}"),
                            Text("kshs ${rentals[index].rentAmount}/month"),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.king_bed),
                                    SizedBox(width: 3),
                                    Text("1"),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bathtub,
                                      size: 20,
                                    ),
                                    SizedBox(width: 3),
                                    Text("1"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  searchAndNavigate() {
    locationFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            result[0].latitude,
            result[0].longitude,
          ),
          zoom: 13,
        ),
      ));
    });
  }
}
