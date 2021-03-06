import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  String dropdownValue  = 'Rental';
  DropDown(this.dropdownValue);
  @override
  _DropDownState createState(
   
  ) => _DropDownState(
     dropdownValue = this.dropdownValue,
  );
}

class _DropDownState extends State<DropDown> {
    String dropdownValue;
  _DropDownState(this.dropdownValue);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
      items: <String>['Rental'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
