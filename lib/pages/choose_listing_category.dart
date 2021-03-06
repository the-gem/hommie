import 'package:flutter/material.dart';
import 'package:hommie/widgets/rental_category_grid_card.dart';

class ChooseListingCategory extends StatefulWidget {
  @override
  _ChooseListingCategoryState createState() => _ChooseListingCategoryState();
}

class _ChooseListingCategoryState extends State<ChooseListingCategory> {

  Scaffold chooseListingType() {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900].withBlue(110),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: GridView.count(
              crossAxisCount: 1,
              children: List.generate(
                1,
                (index) {
                  return RentalCategoryGridCard("rental",);
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "select type of listing",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return chooseListingType();
  }
}
