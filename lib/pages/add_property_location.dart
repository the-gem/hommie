import 'package:flutter/material.dart';
import 'package:hommie/pages/create_listing.dart';

class AddPropertyLocation extends StatefulWidget {
  @override
  _AddPropertyLocationState createState() => _AddPropertyLocationState();
}

class _AddPropertyLocationState extends State<AddPropertyLocation> {
  String dropdownValue = 'Nairobi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Where is the property located?"),
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
            items: <String>[
              'Nairobi',
              'Uasin Gishu',
              'Nakuru',
              'Bungoma',
              'Kakamega',
              'Kericho',
              'Baringo',
              'Mombasa',
              'Kwale',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'town e.g Nairobi',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Area e.g Westlands',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateListing(),
                  ),
                );
              },
              child: Text("next")),
        ],
      ),
    );
  }
}
