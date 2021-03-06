import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hommie/pages/homepage.dart';

class AddRentalSecurityFeatures extends StatefulWidget {
  @override
  _AddRentalSecurityFeaturesState createState() =>
      _AddRentalSecurityFeaturesState();
}

class _AddRentalSecurityFeaturesState
    extends State<AddRentalSecurityFeatures> {
  submitRental() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          Text("security"),
          CheckboxListTile(
            title: const Text('cctv surveillance'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('electric fence'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('24hr security watch'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          ElevatedButton(
              onPressed: () => submitRental(), child: Text("next")),
        ],
      ),
    );
  }
}
