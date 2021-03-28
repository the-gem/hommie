import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String id;
  String email;
  String profilePicture = "";
  String username;
  String phoneNumber;
  String location;
  String taxIdNumber;
  String type;
  MyUser({
    this.phoneNumber,
    this.email,
    this.id,
    this.profilePicture,
    this.username,
    this.location,
    this.taxIdNumber,
    this.type,
  });

  factory MyUser.fromDocument(DocumentSnapshot doc) {
    return MyUser(
      id: doc["id"],
      type: doc["type"],
      username: doc["username"],
      location: doc["location"],
      email: doc["email address"],
      phoneNumber: doc["phone number"],
      taxIdNumber: doc["tax identification number"],
      profilePicture: doc["profile picture"],
    );
  }
}
