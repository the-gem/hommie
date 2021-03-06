import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hommie/pages/add_rental_security_features.dart';

class AddRentalInternalAmenities extends StatefulWidget {
  @override
  _AddRentalInternalAmenitiesState createState() =>
      _AddRentalInternalAmenitiesState();
}

class _AddRentalInternalAmenitiesState
    extends State<AddRentalInternalAmenities> {
  addRentalSecurityFeatures() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalSecurityFeatures(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          Text("Internal Amenities"),
          CheckboxListTile(
            title: const Text('furnished'),
            value: timeDilation != 1.0,
            onChanged: (bool furnished) {
              setState(() {
                timeDilation = furnished ? 5.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('internet'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('serviced'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('service charge included'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('hot shower'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          CheckboxListTile(
            title: const Text('balcony'),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
              });
            },
            secondary: const Icon(Icons.hourglass_empty),
          ),
          ElevatedButton(
              onPressed: () => addRentalSecurityFeatures(), child: Text("next")),
        ],
      ),
    );
  }
}
