import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/models/plot.dart';
import 'package:hommie/models/user.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/properties/plots/add_plot_location.dart';
import 'package:hommie/pages/properties/plots/plot_full_page.dart';
import 'package:hommie/widgets/drawer_list.dart';
import 'package:hommie/pages/homepage.dart';

class PLotsHomePage extends StatefulWidget {
  static const String idscreen = "plotshomescreen";
  @override
  _PLotsHomePageState createState() => _PLotsHomePageState();
}

class _PLotsHomePageState extends State<PLotsHomePage> {
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Marker> allMarkers = [];
  List<Plot> plots = [];
  double mapBottomPadding = 0;

  // void _onScroll() {
  //   if (_pageController.page.toInt() != prevPage) {
  //     prevPage = _pageController.page.toInt();
  //     if (allMarkers != null) {
  //       moveCamera();
  //     }
  //   }
  // }

  getUser() async {
    usersRef
        .doc(currentUserId)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      currentUser = MyUser.fromDocument(documentSnapshot);
    });
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      currentUserId = "";
      if (auth.currentUser == null) {
        isLoggedIn = false;
      } else {
        currentUserId = auth.currentUser.uid;
        isLoggedIn = true;
        getUser();
      }
    });
    super.initState();
  }
  @override
  void dispose() { 
    
    super.dispose();
  }

  PageController _pageController;
  int prevPage;
  final LatLng _nairobi = const LatLng(-1.286389, 36.817223);

  String searchAddr;
  @override
  Widget build(BuildContext context) {
    CollectionReference listings =
        FirebaseFirestore.instance.collection('plots');
    listings.snapshots().listen((QuerySnapshot plotsSnapshot) {
      List<Plot> plotsTimelinePosts = plotsSnapshot.docs
          .map((plotsSnapshot) => Plot.fromDocument(plotsSnapshot))
          .toList();
     
        this.plots = plotsTimelinePosts;
        plots.isEmpty || plots == null
            ? mapBottomPadding = 0
            : mapBottomPadding = 120;
        plots.forEach((element) {
          allMarkers.add(Marker(
              markerId: MarkerId(element.plotId),
              draggable: false,
              infoWindow: InfoWindow(
                  title: element.plotTitle,
                  snippet: element.price,
                  onTap: () {
                    // moveCamera();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlotFullPage(
                            price: element.price,
                            plotTitle: element.plotTitle,
                            listingCoordinates: element.listingCoordinates,
                            landArea: element.landArea,
                            imageUrls: element.imageUrls,
                            location: element.location,
                            plotId: element.plotId,
                            plotOwnerId: element.userId,
                            genDescription: element.genDescription,
                          ),
                        ));
                  }),
              position: LatLng(element.listingCoordinates.latitude,
                  element.listingCoordinates.longitude)));
          this.allMarkers = allMarkers;
      
        _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
        // ..addListener(_onScroll);
      });
    });
    return StreamBuilder<QuerySnapshot>(
      stream: listings.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
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
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _nairobi,
                    zoom: 12.0,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: plots.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _plotsList(index);
                        },
                      )),
                ),
                Positioned(
                  bottom: mapBottomPadding + 15,
                  child: Column(
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.blue.withBlue(100),
                        heroTag: "add plot listing",
                        onPressed: () {
                          isLoggedIn
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPlotLocation(),
                                  ),
                                )
                              : Navigator.pushNamedAndRemoveUntil(
                                  context, Login.idscreen, (route) => false);
                        },
                        label: Text(
                          'Add Plot Listing',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: Icon(Icons.add, size: 15),
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
      },
    );
  }

  moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              plots[_pageController.page.toInt()].listingCoordinates?.latitude,
              plots[_pageController.page.toInt()]
                  .listingCoordinates
                  ?.longitude),
          zoom: 17,
          bearing: 45,
          tilt: 45,
        ),
      ),
    );
  }

  _plotsList(index) {
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
            // showplotFullPage();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlotFullPage(
                    price: plots[index].price,
                    plotTitle: plots[index].plotTitle,
                    listingCoordinates: plots[index].listingCoordinates,
                    landArea: plots[index].landArea,
                    imageUrls: plots[index].imageUrls,
                    location: plots[index].location,
                    plotId: plots[index].plotId,
                    plotOwnerId: plots[index].userId,
                    genDescription: plots[index].genDescription,
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
                          height: 250,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(plots[index].imageUrls[0]),
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
                            Text(
                              "${plots[index].plotTitle}".toUpperCase(),
                              style: TextStyle(
                                color: Colors.blue.withBlue(150),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("kshs ${plots[index].price}"),
                            Text("${plots[index].landArea} acres"),
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
