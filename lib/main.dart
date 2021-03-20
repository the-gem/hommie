import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/agency_setup.dart';
import 'package:hommie/pages/accounts/choose_account_type.dart';
import 'package:hommie/pages/accounts/landlord_setup.dart';
import 'package:hommie/pages/accounts/login.dart';
import 'package:hommie/pages/accounts/reset_password.dart';
import 'package:hommie/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

User user = FirebaseAuth.instance.currentUser;

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
        });
  }
}
