const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.createAllUsersRentals = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onCreate(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => Plots => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const allUsersRentalsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("rentals")
        // .doc(county)
        // .collection(locality)
        // .doc(PlotsType)
        // .collection(PlotsubCategory)
        // .doc(rentalId)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersRentalsListings = admin
            .firestore()
            .collection("rentals")
        //get all user properties
        const userRentalSnapshot = await allUsersRentalsRef.get();
        //add each user properties to users timeline
        userRentalSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersListingData = doc.data();
                allUsersRentalsListings.doc(rentalId).set(allUsersListingData);
            }
        })
    });
exports.updateAllUsersRentals = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onUpdate(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => Rentals => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user Rentals ref
        const allUsersRentalsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("rentals")
        // .doc(county)
        // .collection(locality)
        // .doc(listingType)
        // .collection(listingSubCategory)
        // .doc(rentalId)
        // all users listings
        //users => listings => general => property_id //=> main page/maps
        //create all users listings 
        const allUsersRentalsListing = admin
            .firestore()
            .collection("rentals")
        //get all user Rentals
        const userRentalSnapshot = await allUsersRentalsRef.get();
        //add each user Rentals to users timeline
        userRentalSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersRentalsData = doc.data();
                allUsersRentalsListing.doc(rentalId).update(allUsersRentalsData);
            }
        })
    });
exports.deleteRentalOnAllListings = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onDelete(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        admin
            .firestore()
            .collection("rentals").doc(rentalId).delete();
    });

exports.createAllUsersPlots = functions.firestore
    .document("/users/{user_id}/plots/{plotId}")
    .onCreate(async (snapshot, context) => {
        const plotId = context.params.plotId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => properties => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user properties ref
        const allUsersPlotsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("plots")
        // .doc(county)
        // .collection(locality)
        // .doc(listingType)
        // .collection(PlotsubCategory)
        // .doc(plotId)
        // all users Plots
        //users => Plots => general => property_id //=> main page/maps
        //create all users Plots 
        const allUsersPlotsListings = admin
            .firestore()
            .collection("plots")
        //get all user Plots
        const userPlotsnapshot = await allUsersPlotsRef.get();
        //add each user Plots to users timeline
        userPlotsnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersPlotsData = doc.data();
                allUsersPlotsListings.doc(plotId).set(allUsersPlotsData);
            }
        })
    });
exports.updateAllUsersPlots = functions.firestore
    .document("/users/{user_id}/plots/{plotId}")
    .onUpdate(async (snapshot, context) => {
        const plotId = context.params.plotId;
        const user_id = context.params.user_id;
        // const categoryName = context.params.categoryName;
        // users => user_id => Plots => kiambu county => ruaka => rentals => bedsitters => property_id
        //create user Plots ref
        const allUsersPlotsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("plots")
        // .doc(county)
        // .collection(locality)
        // .doc(PlotsType)
        // .collection(PlotsubCategory)
        // .doc(plotId)
        // all users Plots
        //users => Plots => general => property_id //=> main page/maps
        //create all users Plots 
        const allUsersPlotsListings = admin
            .firestore()
            .collection("plots")
        //get all user Plots
        const userPlotsnapshot = await allUsersPlotsRef.get();
        //add each user Plots to users timeline
        userPlotsnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersPlotsData = doc.data();
                allUsersPlotsListings.doc(plotId).update(allUsersPlotsData);
            }
        })
    });
exports.deletePlots = functions.firestore
    .document("/users/{user_id}/plots/{plotId}")
    .onDelete(async (snapshot, context) => {
        const plotId = context.params.plotId;
        admin
            .firestore()
            .collection("plots").doc(plotId).delete();
    });
