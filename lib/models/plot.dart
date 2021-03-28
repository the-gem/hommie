import 'package:cloud_firestore/cloud_firestore.dart';

class Plot {
  GeoPoint listingCoordinates;
  String plotTitle;
  String landArea;
  String location;
  String price;
  String plotId;
  List imageUrls;
  String userId;
  String genDescription;
  Plot({
    this.location,
    this.listingCoordinates,
    this.landArea,
    this.plotTitle,
    this.price,
    this.imageUrls,
    this.plotId,
    this.userId,
    this.genDescription,
  });
  factory Plot.fromDocument(DocumentSnapshot plotsSnapshot) {
    return Plot(
      plotTitle: plotsSnapshot['plot title'],
      price: plotsSnapshot['price'],
      landArea: plotsSnapshot['land area'],
      listingCoordinates: plotsSnapshot['coords'],
      genDescription: plotsSnapshot['general description'],
      imageUrls: plotsSnapshot['image urls'],
      location: plotsSnapshot['location'],
      plotId: plotsSnapshot['plot id'],
      userId: plotsSnapshot['user id'],
    );
  }
}
