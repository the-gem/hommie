const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.createCurrentUserListings = functions.firestore
    .document("/users/{user_id}/properties/{county}/{locality}/{propertyId}")
    .onCreate(async (snapshot, context) => {
        const county = context.params.county;
        const locality = context.params.locality;
        const listingType = context.params.listingType;
        const listingSubCategory = context.params.listingSubCategory;
        const propertyId = context.params.propertyId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const currentUserPropertiesRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("properties")
            .doc(county)
            .collection(locality)
            .doc(listingType)
            .collection(listingSubCategory)
        // .doc(propertyId)
        // get all user listings
        //users => user id => all listings => property_id //=> profile page
        //create all current user listings 
        const currentUserListingRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("all listings");
        //get all user properties
        const userListingSnapshot = await currentUserPropertiesRef.get();
        //add each user properties to users timeline
        userListingSnapshot.forEach(doc => {
            if (doc.exists) {
                const currentUserListingData = doc.data();
                currentUserListingRef.doc(propertyId).set(currentUserListingData);
            }
        })
    });

exports.createAllUsersListings = functions.firestore
    .document("/users/{user_id}/properties/{county}/{locality}/{propertyId}")
    .onCreate(async (snapshot, context) => {
        const county = context.params.county;
        const locality = context.params.locality;
        const listingType = context.params.listingType;
        const listingSubCategory = context.params.listingSubCategory;
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
            .doc(county)
            .collection(locality)
            .doc(listingType)
            .collection(listingSubCategory)
        // .doc(propertyId)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersListingRef = admin
            .firestore()
            .collection("users")
            .doc("listings")
            .collection("general");
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

exports.onAccountcreation = functions.firestore
    .document("/users/{user_id}/{accountType}/{agencyName}")
    .onCreate(async (snapshot, context) => {
        const accountType = context.params.accountType;
        const agencyName = context.params.agencyName;
        const user_id = context.params.user_id;

        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const userAccountsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection(accountType)
        // .doc(agencyName)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersAccountsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("personal infor");
        //get all user properties
        const userAccountSnapshot = await userAccountsRef.get();
        //add each user properties to users timeline
        userAccountSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersAccountsData = doc.data();
                allUsersAccountsRef.doc(agencyName).set(allUsersAccountsData);
            }
        })
    });
    .document("/users/{user_id}/{accountType}/{agencyName}")
    .onCreate(async (snapshot, context) => {
        const accountType = context.params.accountType;
        const agencyName = context.params.agencyName;
        const user_id = context.params.user_id;

        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const userAccountsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection(accountType)
        // .doc(agencyName)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersAccountsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("personal infor");
        //get all user properties
        const userAccountSnapshot = await userAccountsRef.get();
        //add each user properties to users timeline
        userAccountSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersAccountsData = doc.data();
                allUsersAccountsRef.doc(agencyName).set(allUsersAccountsData);
            }
        })
    });