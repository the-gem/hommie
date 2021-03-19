const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
exports.onCreateRental = functions.firestore
    .document("/{county}/{locality}/{placeName}/{listingType}/{listingSubCategory}/{postId}")
    .onCreate(async (snapshot, context) => {
        const county = context.params.county;
        const locality = context.params.locality;
        const placeName = context.params.placeName;
        const listingType = context.params.listingType;
        const listingSubCategory = context.params.listingSubCategory;
        const postId = context.params.postId;
        // const categoryName = context.params.categoryName;
        //create user posts ref
        const propertyPostsRef = admin
            .firestore()
            .collection(county)
            .doc(locality)
            .collection(placeName)
            .doc(listingType)
            .collection(listingSubCategory)
        //create rentals timelineRef
        const listingsRef = admin
            .firestore()
            .collection(listingType);
        //get users posts
        const querySnapshot = await propertyPostsRef.get();
        //add each user posts to users timeline
        querySnapshot.forEach(doc => {
            if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                listingsRef.doc(postId).set(postData);
            }
        })
    });
exports.onCreateNewProperty = functions.firestore
    .document("/properties/{listingType}/{listingSubCategory}/{county}/{locality}/{postId}")
    .onCreate(async (snapshot, context) => {
        const county = context.params.county;
        const locality = context.params.locality;
        // const placeName = context.params.placeName;
        const listingType = context.params.listingType;
        const listingSubCategory = context.params.listingSubCategory;
        const postId = context.params.postId;
        // const categoryName = context.params.categoryName;
        //create user posts ref
        const propertyRef = admin
            .firestore()
            .collection("properties")
            .doc(listingType)
            .collection(listingSubCategory)
            .doc(county)
            .collection(locality)
        //create rentals timelineRef
        const propertiesListingsRef = admin
            .firestore()
            .collection(listingType);
        //get users posts
        const querySnapshot = await propertyRef.get();
        //add each user posts to users timeline
        querySnapshot.forEach(doc => {
            if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                propertiesListingsRef.doc(postId).set(postData);
            }
        })
    });