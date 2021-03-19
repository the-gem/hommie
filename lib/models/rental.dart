import 'package:cloud_firestore/cloud_firestore.dart';
class Rental {
  String listingType;
  String listingSubCategory;
  GeoPoint listingCoordinates;
  String propertyTitle;
  String landArea;
  String location;
  List externalAmenities = [];
  List internalAmenities = [];
  List securityFeatures = [];
  String rentAmount;
  String postId;
  List imageUrls;
  String bedrooms;
  String bathrooms;
  String deposit;
  Rental({
    this.location,
    this.securityFeatures,
    this.externalAmenities,
    this.internalAmenities,
    this.listingSubCategory,
    this.listingType,
    this.listingCoordinates,
    this.landArea,
    this.propertyTitle,
    this.rentAmount,
    this.imageUrls,
    this.postId,
    this.bathrooms,
    this.bedrooms,
    this.deposit,
  });
  factory Rental.fromDocument(DocumentSnapshot rentalsSnapshot) {
    return Rental(
        propertyTitle: rentalsSnapshot['property title'],
        rentAmount: rentalsSnapshot['rent amount'],
        listingType: rentalsSnapshot['listing type'],
        listingSubCategory: rentalsSnapshot['listing sub category'],
        landArea: rentalsSnapshot['land area'],
        listingCoordinates: rentalsSnapshot['coords'],
        // genDescription: rentalsSnapshot['general description'],
        securityFeatures: rentalsSnapshot['security feature'],
        internalAmenities: rentalsSnapshot['internal amenities'],
        externalAmenities: rentalsSnapshot['external amenities'],
        imageUrls: rentalsSnapshot['image urls'],
        location: rentalsSnapshot['location'],
        postId: rentalsSnapshot['post id'],
        deposit: rentalsSnapshot['deposit'],
        bedrooms: rentalsSnapshot['bedrooms'],
        bathrooms: rentalsSnapshot['bathrooms']);
  }
}
