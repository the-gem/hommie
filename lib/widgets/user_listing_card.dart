// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Post extends StatefulWidget {
//   final String postId;
//   final String ownerId;
//   final String mediaUrl;
//   final String location;
//   final String description;
//   final String displayName;
//   final String bedrooms;
//   final String parking;
//   final String bathrooms;
//   final String internet;
//   final String rent;
//   final String phone;
//   final String placeDescription;
//   final String locationDescription;
//   Post({
//     this.locationDescription,
//     this.placeDescription,
//     this.postId,
//     this.ownerId,
//     this.mediaUrl,
//     this.location,
//     this.description,
//     this.displayName,
//     this.bathrooms,
//     this.bedrooms,
//     this.internet,
//     this.parking,
//     this.phone,
//     this.rent,
//   });
//   factory Post.fromDocument(DocumentSnapshot postDocSnap) {
//     return Post(
//       postId: postDocSnap['postId'],
//       ownerId: postDocSnap['ownerId'],
//       location: postDocSnap['location'],
//       description: postDocSnap['description'],
//       mediaUrl: postDocSnap['medialUrl'],
//       displayName: postDocSnap['display name'],
//       bathrooms: postDocSnap['bathrooms'],
//       bedrooms: postDocSnap['bedrooms'],
//       internet: postDocSnap['internet'],
//       parking: postDocSnap['parking'],
//       phone: postDocSnap['phone'],
//       rent: postDocSnap['rent'],
//       locationDescription: postDocSnap['location description'],
//       placeDescription: postDocSnap['place description'],
//     );
//   }
//   @override
//   _PostState createState() => _PostState(
//         postId: this.postId,
//         ownerId: this.ownerId,
//         mediaUrl: this.mediaUrl,
//         location: this.location,
//         description: this.description,
//         displayName: this.displayName,
//         bedrooms: this.bedrooms,
//         parking: this.parking,
//         bathrooms: this.bathrooms,
//         internet: this.internet,
//         rent: this.rent,
//         phone: this.phone,
//         locationDescription: this.locationDescription,
//         placeDescription: this.placeDescription,
//       );
// }

// class _PostState extends State<Post> {
//   final String placeDescription;
//   final String locationDescription;
//   final String postId;
//   final String ownerId;
//   final String mediaUrl;
//   final String location;
//   final String description;
//   final String displayName;
//   final String bedrooms;
//   final String parking;
//   final String bathrooms;
//   final String internet;
//   final String rent;
//   final String phone;
//   _PostState({
//     this.locationDescription,
//     this.placeDescription,
//     this.postId,
//     this.ownerId,
//     this.mediaUrl,
//     this.location,
//     this.description,
//     this.displayName,
//     this.bathrooms,
//     this.bedrooms,
//     this.internet,
//     this.parking,
//     this.phone,
//     this.rent,
//   });
//   buildPostHeader() {
//     return FutureBuilder(
//         future: usersRef.doc(widget.ownerId).get(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: Text("no data available"),);
//           }
//           User user = User.fromDocument(snapshot.data);
//           return GestureDetector(
//             onTap: () => showProfile(context, profileId: widget.ownerId),
//             child: ListTile(
//               leading: CircleAvatar(
//                 radius: 20,
//                 backgroundColor: Colors.grey,
//                 backgroundImage: NetworkImage(user.photoUrl),
//               ),
//               title: GestureDetector(child: Text(user.displayName)),
//               subtitle: Text(location),
//             ),
//           );
//         });
//   }

//   buildPostImage() {
//     return GestureDetector(
//       onTap: () => showFullPost(context),
//       child: Container(
//         color: Colors.grey[200],
//         width: double.infinity,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: 180),
//           child: Image.network(
//             mediaUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }

//   showPost(context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RentalPostScreen(postId: postId, userId: ownerId),
//       ),
//     );
//   }

//   showFullPost(context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RentalPostScreen(postId: postId, userId: ownerId),
//       ),
//     );
//   }

//   buildPostFooter(context) {
//     return GestureDetector(
//       onTap: () => showFullPost(context),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 4),
//               child: Text(
//                 "Kshs $rent/month",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 color: Colors.blueAccent,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
//                   child: Text(
//                     "Apartment",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: 15),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.king_bed,
//                           color: Colors.black,
//                           size: 25,
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           bedrooms,
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 15),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.bathtub_sharp,
//                           color: Colors.black,
//                           size: 23,
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           bathrooms,
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 15),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.directions_car_outlined,
//                           color: Colors.black,
//                           size: 25,
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           parking,
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 15),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.wifi,
//                           color: Colors.black,
//                           size: 23,
//                         ),
//                         SizedBox(width: 3),
//                         Text(
//                           internet,
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 10,
//       ),
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             buildPostHeader(),
//             buildPostImage(),
//             buildPostFooter(context),
//           ],
//         ),
//       ),
//     );
//   }
// }
