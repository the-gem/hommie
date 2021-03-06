import 'package:flutter/material.dart';
import 'package:hommie/widgets/rental_list_card.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: ListView(
        children: [
          RentalListCard(),
          RentalListCard(),
          RentalListCard(),
          RentalListCard(),
        ],
      ),
    );
  }
}