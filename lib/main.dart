import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hommie/pages/homepage.dart';
import 'package:hommie/widgets/progress_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text("something went wrong"),
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Hommie',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              // home: HomePage());
              initialRoute: HomePage.idscreen,
              routes: {
                HomePage.idscreen: (context) => HomePage(),
              });
        }

        // Otherwise, show something whilst waiting for initialization to complete

        return MaterialApp(
          home: ProgressDialog(
            message: "Getting things ready...",
          ),
        );
      },
    );
  }
}
