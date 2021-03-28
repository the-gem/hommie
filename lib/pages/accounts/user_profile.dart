import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hommie/models/user.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/widgets/progress_dialog.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController officeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool fullNameValid = true;
  bool officeValid = true;
  bool emailValid = true;
  List<Asset> images = [];
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    getUser();
    super.dispose();
  }

  getUser() async {
    currentUser = MyUser();
    DocumentSnapshot userDocSnap =
        await usersRef.doc(auth.currentUser.uid).get();
    currentUserId = auth.currentUser.uid;

    currentUser = MyUser.fromDocument(userDocSnap);
    setState(() {
      fullNameController.text = currentUser.username;
      emailController.text = currentUser.email;
      officeController.text = currentUser.location;
    });
  }

  updateProfile() {
    setState(() {
      fullNameController.text.length < 3 || fullNameController.text.isEmpty
          ? fullNameValid = false
          : fullNameValid = true;
      !emailController.text.contains("@") || emailController.text.isEmpty
          ? emailValid = false
          : emailValid = true;
      officeController.text.length < 8 || officeController.text.isEmpty
          ? officeValid = false
          : officeValid = true;
      officeController.text.length < 5
          ? officeValid = false
          : officeValid = true;
      if (officeValid && fullNameValid && emailValid) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .update({
          "username": fullNameController.text,
          "location": officeController.text.trim(),
          "email address": emailController.text.trim(),
        }).then((value) {
          SnackBar snackbar = SnackBar(content: Text('update successfull'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }
    });
  }

  Widget buildGridView() {
    Asset asset = images[0];
    return Container(
      height: 200,
      width: 100,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 120,
        child: AssetThumb(
          asset: asset,
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
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

  @override
  Widget build(BuildContext context) {
    Stream documentStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: documentStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Something went wrong')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Loading",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.withBlue(150),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(currentUser.username.toUpperCase()),
          ),
          body: Container(
            padding: EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
            ),
            alignment: Alignment.center,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                images.isNotEmpty
                    ? buildGridView()
                    : currentUser.profilePicture.isNotEmpty ||
                            currentUser.profilePicture != null
                        ? Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(
                                  currentUser.profilePicture[0],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 150,
                            width: 100,
                            child: CircleAvatar(
                              child: Image.network(
                                  currentUser.profilePicture[0],
                                  fit: BoxFit.contain),
                            ),
                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: loadAssets,
                      child: Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 27,
                                color: Colors.blue.withBlue(100),
                              ),
                              SizedBox(height: 14),
                              Text("Choose Photo".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (images.isNotEmpty || images.length > 0) {
                          SnackBar snackbar = SnackBar(
                              content: Text('Please wait, we are uploading'));

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          uploadImages(context);
                        }
                      },
                      child: Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                Icons.upload_rounded,
                                size: 27,
                                color: Colors.blue.withBlue(100),
                              ),
                              SizedBox(height: 14),
                              Text("Upload Photo".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: Text(
                    "Personal Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  height: 65,
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      labelText: 'Full name',
                      errorText:
                          fullNameValid ? null : "full name is not valid",
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 65,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      errorText:
                          emailValid ? null : "input a valid email address",
                      labelText: 'email address',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 65,
                  child: TextField(
                    controller: officeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      errorText: officeValid ? null : "e.g. nairobi, westlands",
                      labelText: 'office location',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    updateProfile();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: Colors.blue.withBlue(150),
                    child: Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("save".toUpperCase(),
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
        );
      },
    );
  }

  void uploadImages(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "updating profile...",
          );
        });
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(currentUserId)
              .update({
            "profile picture": imageUrls,
          }).then((_) {
            SnackBar snackbar =
                SnackBar(content: Text('Uploaded Successfully'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);

            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        SnackBar snackbar = SnackBar(content: Text(err));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    }
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    String imagesurl = await (await uploadTask).ref.getDownloadURL();
    return imagesurl;
  }
}
