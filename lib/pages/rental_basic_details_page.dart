import 'package:flutter/material.dart';
import 'package:hommie/pages/add_rental__external_amenities.dart';

class AddRentalBasicDetails extends StatefulWidget {
  @override
  _AddRentalBasicDetailsState createState() => _AddRentalBasicDetailsState();
}

class _AddRentalBasicDetailsState extends State<AddRentalBasicDetails> {
    addRentalAmenities() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalExternalAmenities(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'title/property name',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'location',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'land area in square metre',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
            ),
          ),
            ElevatedButton(
                  onPressed: () => addRentalAmenities(), child: Text("next")),
        ],
      ),
    );
  }
}
