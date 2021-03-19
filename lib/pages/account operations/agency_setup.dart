import 'package:flutter/material.dart';

class AgencyRegistration extends StatefulWidget {
  static const String idscreen = "AgencyRegistration";
  final String accountType;
  AgencyRegistration({this.accountType});
  @override
  _AgencyRegistrationState createState() => _AgencyRegistrationState();
}

class _AgencyRegistrationState extends State<AgencyRegistration> {
  String dropdownValue = 'rental';
  String rentalCategoryValue = "apartment";
  String propertyTitle;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Text(
                  "Select one",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                DropdownButton<String>(
                  value: rentalCategoryValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  onChanged: (String newValue) {
                    setState(() {
                      rentalCategoryValue = newValue;
                    });
                  },
                  items: <String>[
                    'apartment',
                    'bedsitter',
                    'warehouse',
                    'studio',
                    'shop',
                    'offices',
                    'commercial property',
                    'villas',
                    'townhouse',
                    'house',
                    'other',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          )),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'title/property name',
                  ),
                  onChanged: (value) {
                    propertyTitle = value;
                    print("title: $propertyTitle");
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
