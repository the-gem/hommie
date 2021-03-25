const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.createAllUsersListings = functions.firestore
    .document("/users/{user_id}/properties/{propertyId}")
    .onCreate(async (snapshot, context) => {
        const propertyId = context.params.propertyId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const allUsersPropertiesRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("properties")
        // .doc(county)
        // .collection(locality)
        // .doc(listingType)
        // .collection(listingSubCategory)
        // .doc(propertyId)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersListingRef = admin
            .firestore()
            .collection("listings");
        //get all user properties
        const userListingSnapshot = await allUsersPropertiesRef.get();
        //add each user properties to users timeline
        userListingSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersListingData = doc.data();
                allUsersListingRef.doc(propertyId).set(allUsersListingData);
            }
        })
    });
exports.updateAllUsersListings = functions.firestore
    .document("/users/{user_id}/properties/{propertyId}")
    .onUpdate(async (snapshot, context) => {
        const propertyId = context.params.propertyId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const allUsersPropertiesRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("properties")
        // .doc(county)
        // .collection(locality)
        // .doc(listingType)
        // .collection(listingSubCategory)
        // .doc(propertyId)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersListingRef = admin
            .firestore()
            .collection("listings");
        //get all user properties
        const userListingSnapshot = await allUsersPropertiesRef.get();
        //add each user properties to users timeline
        userListingSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersListingData = doc.data();
                allUsersListingRef.doc(propertyId).update(allUsersListingData);
            }
        })
    });
exports.deletePropertyOnAllListings = functions.firestore
    .document("/users/{user_id}/properties/{propertyId}")
    .onDelete(async (snapshot, context) => {
        const propertyId = context.params.propertyId;


        admin
            .firestore()
            .collection("listings").doc(propertyId).delete();
    });
