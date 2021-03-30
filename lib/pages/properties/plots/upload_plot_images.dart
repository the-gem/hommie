import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hommie/models/account.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/pages/payments/payment.dart';
import 'package:hommie/pages/properties/plots/plots_home_page.dart';
import 'package:hommie/widgets/progress_dialog.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadPlotImages extends StatefulWidget {
  LatLng listingCoordinates;
  String plotTitle;
  String landArea;
  String genDescription;
  String price;

  UploadPlotImages({
    this.listingCoordinates,
    this.landArea,
    this.plotTitle,
    this.genDescription,
    this.price,
  });
  @override
  _UploadPlotImagesState createState() => new _UploadPlotImagesState();
}

class _UploadPlotImagesState extends State<UploadPlotImages> {
  int newAccountBal;
  List<Asset> images = [];
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;
  bool enoughAccountBal = false;
  @override
  void initState() {
    super.initState();
    getLocation();
    getAccountBalance();
  }

  String plotid = Uuid().v4();
  String county;
  String locality;
  String placeLocation;
  String placeName;
  getLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.listingCoordinates.latitude,
        widget.listingCoordinates.longitude);
    Placemark placemark = placemarks[0];
    String name = placemark.name;
    // String subLocality = placemark.subLocality;
    String local = placemark.locality;
    String administrativeArea = placemark.administrativeArea;
    // String postalCode = placemark.postalCode;
    // String country = placemark.country;
    String address = name + ', ' + local + ', ' + administrativeArea;
    setState(() {
      placeLocation = address;
      locality = local;
      county = administrativeArea;
      placeName = name;
    });
  }

  Stream<DocumentSnapshot> getAccountBalance() {
    DocumentReference stream = FirebaseFirestore.instance
        .collection("payments")
        .doc(currentUserId)
        .collection("balance")
        .doc("account");
    stream.snapshots().listen((DocumentSnapshot element) {
      account = Account.fromDocument(element);
      print('account ballance is: ${account.balance}');
      if (account.balance >= 49) {
        setState(() {
          enoughAccountBal = true;
        });
      } else if (account.balance <= 48) {
        enoughAccountBal = false;
      }
      return account;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          padding: EdgeInsets.all(1.0),
          height: 100,
          width: 100,
          color: Colors.white,
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.withBlue(100),
                          padding: EdgeInsets.all(12),
                          elevation: 6,
                        ),
                        onPressed: loadAssets,
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 27,
                          color: Colors.white,
                        ),
                        label: Text("Choose photos",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.withBlue(100),
                          padding: EdgeInsets.all(12),
                          elevation: 6,
                        ),
                        onPressed: () {
                          if (images.length == 0) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    content: Text("No image selected",
                                        style: TextStyle(color: Colors.white)),
                                    actions: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 30,
                                          child: Center(
                                              child: Text(
                                            "Ok",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          } else {
                            uploadPlotImages(context);
                          }
                        },
                        icon: Icon(
                          Icons.upload_rounded,
                          size: 27,
                          color: Colors.white,
                        ),
                        label: Text("Upload photos",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: buildGridView(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateAccount() async {
    if (account.balance >= 49) {
      setState(() {
        enoughAccountBal = true;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Checking your account...",
            );
          });
      await FirebaseFirestore.instance
          .collection("payments")
          .doc(currentUserId)
          .collection("balance")
          .doc("account")
          .update({
        "wallet":  account.balance - 49,
      });
    } else if (account.balance <= 48) {
      setState(() {
        enoughAccountBal = false;
      });
      Navigator.of(context).pop();
      SnackBar snackbar = SnackBar(
          content: Text(
              'You need a minimum of 49Kshs to upload a plot, Recharge and try again'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void uploadPlotImages(context) async {
    updateAccount();
    if (enoughAccountBal == true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "uploading your property...",
            );
          });
      for (var imageFile in images) {
        postImage(imageFile).then((downloadUrl) {
          imageUrls.add(downloadUrl.toString());
          if (imageUrls.length == images.length) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(currentUserId)
                .collection("plots")
                .doc(plotid)
                .set({
              "plot id": plotid,
              "user id": currentUserId,
              "price": widget.price,
              "plot title": widget.plotTitle,
              "image urls": imageUrls,
              "coords": GeoPoint(
                widget.listingCoordinates.latitude,
                widget.listingCoordinates.longitude,
              ),
              "general description": widget.genDescription,
              "land area": widget.landArea,
              "location": placeLocation,
            }).then((_) {
              Navigator.of(context).pop();
              SnackBar snackbar =
                  SnackBar(content: Text('Uploaded Successfully'));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);

              setState(() {
                images = [];
                imageUrls = [];
                plotid = Uuid().v4();
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, PlotsHomePage.idscreen, (route) => false);
            });
          }
        }).catchError((err) {
          SnackBar snackbar = SnackBar(content: Text(err));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
    } else {
      Navigator.of(context).pop();
      SnackBar snackbar =
          SnackBar(content: Text('Not enough balance in your account'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child("$plotid/$fileName");
    UploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    String imagesurl = await (await uploadTask).ref.getDownloadURL();
    return imagesurl;
  }
}
