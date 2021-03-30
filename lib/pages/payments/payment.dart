import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/widgets/progress_dialog.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  DocumentReference paymentsRef;
  String mUserAccount = currentUser.phoneNumber;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  String phone;
  String phoneNumber;
  String amount;
  Future<void> updateAccount(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };

    paymentsRef.set({"info": "$mUserAccount receipts data goes here."});

    return paymentsRef
        .collection("deposit")
        .doc(mCheckoutRequestID)
        .set(initData)
        .then((value) => print("Transaction Initialized."))
        .catchError((error) => print("Failed to init transaction: $error"));
  }

  Stream<DocumentSnapshot> getAccountBalance() {
    if (_initialized) {
      return paymentsRef.collection("balance").doc("account").snapshots();
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> getDepositHistory() {
    return paymentsRef.collection("deposit").snapshots();
  }

  Future<dynamic> startTransaction({double amount, String phone}) async {
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Processing payment...",
          );
        },
      );
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: phone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https",
              host: "us-central1-homie-app-15b0f.cloudfunctions.net",
              path: "paymentCallback"),
          accountReference: "she",
          phoneNumber: phone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purc",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      var result = transactionInitialisation as Map<String, dynamic>;

      if (result.keys.contains("ResponseCode")) {
        String mResponseCode = result["ResponseCode"];
        print("Resulting Code: " + mResponseCode);
        if (mResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"]);
          Navigator.of(context).pop();
        }
      }
      SnackBar snackbar = SnackBar(
          duration: Duration(milliseconds: 3000),
          content: Text("Success! wait for Mpesa"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print("Exception Caught: " + e.toString());
      Navigator.of(context).pop();
      SnackBar snackbar = SnackBar(
          duration: Duration(milliseconds: 3000), content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      paymentsRef =
          FirebaseFirestore.instance.collection('payments').doc(currentUserId);
    } catch (e) {
      print(e.toString());
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My account".toUpperCase()),
      ),
      backgroundColor: Colors.teal[50],

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
              stream: getAccountBalance(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    strokeWidth: 1.0,
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.data() != null) {
                    Map<String, dynamic> documentFields = snapshot.data.data();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              currentUser.username.toUpperCase(),
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "+" + currentUser.phoneNumber,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Card(
                          elevation: 10,
                          color: Colors.blue.withBlue(150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'account balance'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  documentFields.containsKey("wallet")
                                      ? documentFields["wallet"].toString() +
                                          " Kshs"
                                      : "0 Kshs",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              currentUser.username.toUpperCase(),
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "+" + currentUser.phoneNumber,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Card(
                          elevation: 10,
                          color: Colors.blue.withBlue(150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'account balance'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text("0 Kshs",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              currentUser.username.toUpperCase(),
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "+" + currentUser.phoneNumber,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Card(
                          elevation: 10,
                          color: Colors.blue.withBlue(150),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  'account balance'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text("0 Kshs",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
          Divider(),
          Text(
            "Account history".toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "code".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "amount".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: StreamBuilder(
              stream: getDepositHistory(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    strokeWidth: 1.0,
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.docs != null) {
                    return Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          children: snapshot.data.docs.map(
                            (DocumentSnapshot document) {
                              if (document.data().containsKey("amount")) {
                                return Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(document.data()["receipt"]),
                                          Text(
                                            "Kshs " +
                                                document
                                                    .data()["amount"]
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              }
                              return Container();
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  } else {
                    return Text(
                      '0!',
                    );
                  }
                } else {
                  return Text("!");
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show error message if initialization failed
          if (_error) {
            print("Error initializing Fb");
            return;
          }

          // Show a loader until FlutterFire is initialized
          if (!_initialized) {
            print("Fb Not initialized");
            return;
          }
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  elevation: 10,
                  title: Text(
                    "Pay through Mpesa",
                    style: TextStyle(
                      color: Colors.blue.withBlue(100),
                      fontSize: 25,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Container(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: countryCode,
                              hintText: 'phone number',
                            ),
                            onChanged: (value) {
                              phoneNumber = value;
                              phone = countryCode + phoneNumber;
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixStyle: TextStyle(
                                color: Colors.black,
                              ),
                              hintText: 'amount',
                            ),
                            onChanged: (value) {
                              amount = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel")),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.withBlue(100),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              startTransaction(
                                amount: double.parse(amount),
                                phone: phone,
                              );
                              setState(() {
                                amount = "";
                                phone = null;
                                phoneNumber = null;
                              });
                            },
                            child: Text("Pay".toUpperCase())),
                      ],
                    ),
                  ],
                );
              });
        },
        tooltip: 'Increment',
        label: Text("Top Up"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
