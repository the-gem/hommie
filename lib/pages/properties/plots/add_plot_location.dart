import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/pages/properties/plots/plot_basic_details_page.dart';
import 'package:hommie/widgets/drawer_list.dart';

class AddPlotLocation extends StatefulWidget {
  @override
  _AddPlotLocationState createState() => _AddPlotLocationState();
}

class _AddPlotLocationState extends State<AddPlotLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String searchAddr;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Tip!"),
          content: new Text(
              "Tap on the map to add plot location, or click continue to type the location",
              style: TextStyle(
                letterSpacing: 1,
              )),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  searchAndNavigate() {
    locationFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            result[0].latitude,
            result[0].longitude,
          ),
          zoom: 14,
        ),
      ));
    });
  }

  // String dropdownValue = 'Nairobi';
  List<Marker> myMarker = [];
  GoogleMapController mapController;
  LatLng placeCoords;

  final LatLng _nairobi = const LatLng(-1.286389, 36.817223);
  Position position;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.0,
    )));
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        onDragEnd: (dragEndPosition) {},
      ));
    });
    setState(() {
      placeCoords = tappedPoint;
    });
    print(placeCoords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add plot location"),
      ),
      drawer: Drawer(
        child: DrawerList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add plot",
        onPressed: () {
          if (placeCoords != null) {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPlotBasicDetails(

                listingCoordinates: placeCoords,
              ),
            ),
          );
          } else {
             SnackBar snackbar = SnackBar(
               duration: Duration(seconds: 5),
               content: Text('we could not get your location, choose a location on map or check your internet connection'),);
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        tooltip: 'add plot',
        // child: Icon(Icons.add),
        label: Text('continue'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue.withBlue(100),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(
              top: 60,
            ),
            markers: Set.from(myMarker),
            onTap: _handleTap,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _nairobi,
              zoom: 14.0,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
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
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
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
    );
  }
}
