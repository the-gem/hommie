import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hommie/pages/add_rental_internal_amenities.dart';

class AddRentalExternalAmenities extends StatefulWidget {
  @override
  _AddRentalExternalAmenitiesState createState() => _AddRentalExternalAmenitiesState();
}

class _AddRentalExternalAmenitiesState extends State<AddRentalExternalAmenities> {
    addRentalInternalAmenities() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRentalInternalAmenities(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: [
          Text("External Amenities"),
          CheckboxListTile(
        title: const Text('parking'),
        value: timeDilation != 1.0,
        onChanged: (bool parking) {
          setState(() {
            timeDilation = parking ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
           CheckboxListTile(
        title: const Text('lift'),
        value: timeDilation != 1.0,
        onChanged: (bool lift) {
          setState(() {
            timeDilation = lift ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ), CheckboxListTile(
        title: const Text('Gym'),
        value: timeDilation != 1.0,
        onChanged: (bool gym) {
          setState(() {
            timeDilation = gym ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
      CheckboxListTile(
        title: const Text('swimming pool'),
        value: timeDilation != 1.0,
        onChanged: (bool pool) {
          setState(() {
            timeDilation = pool ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),CheckboxListTile(
        title: const Text('laundry area'),
        value: timeDilation != 1.0,
        onChanged: (bool laundry) {
          setState(() {
            timeDilation = laundry ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),CheckboxListTile(
        title: const Text('backup generator'),
        value: timeDilation != 1.0,
        onChanged: (bool generator) {
          setState(() {
            timeDilation = generator ? 2.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
            ElevatedButton(
                  onPressed: () => addRentalInternalAmenities(), child: Text("next")),
        ],
      ),
    );
  }
}
