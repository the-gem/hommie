import 'package:flutter/material.dart';
import 'package:hommie/pages/rental_basic_details_page.dart';

class CreateListing extends StatefulWidget {
  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  String dropdownValue = 'rental';
  String rentalCategoryValue = "apartment";
  addRentalDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalBasicDetails(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("upload listing"),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['rental']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text("select rental category"),
            DropdownButton<String>(
              value: rentalCategoryValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  rentalCategoryValue = newValue;
                });
              },
              items: <String>[
                'apartment',
                'bedsitter',
                'warehouse',
                'shop',
                'offices',
                'commercial property',
                'villas',
                'townhouse',
                'house',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () => addRentalDetails(), child: Text("next"))
          ],
        ),
      ),
    );
  }
}
