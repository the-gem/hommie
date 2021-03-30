import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hommie/keys.dart';
import 'package:hommie/pages/accounts/agency_setup.dart';
import 'package:hommie/pages/accounts/choose_account_type.dart';
import 'package:hommie/pages/accounts/create_user_in_firestore.dart';
import 'package:hommie/pages/accounts/landlord_setup.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/accounts/otp.dart';
import 'package:hommie/pages/accounts/reset_password.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/pages/properties/plots/plots_home_page.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);
  runApp(MyApp());
}

User user = FirebaseAuth.instance.currentUser;


class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hommie',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        // home: HomePage());
        initialRoute: HomePage.idscreen,
        routes: {
          HomePage.idscreen: (context) => HomePage(),
          AgencyRegistration.idscreen: (context) => AgencyRegistration(),
          LandLordRegistration.idscreen: (context) => LandLordRegistration(),
          Login.idscreen: (context) => Login(),
          ChooseAccountType.idscreen: (context) => ChooseAccountType(),
          ResetPassword.idscreen: (context) => ResetPassword(),
          PlotsHomePage.idscreen: (context) => PlotsHomePage(),
          OtpScreen.idscreen: (context) => OtpScreen(),
          CreateUserInFirestore.idscreen: (context) => CreateUserInFirestore(),
        });
  }
}
