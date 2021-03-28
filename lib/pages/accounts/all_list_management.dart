import 'package:flutter/material.dart';
import 'package:hommie/pages/accounts/plots_list_management.dart';
import 'package:hommie/pages/accounts/rental_list_management.dart';

class ListManagement extends StatefulWidget {
  @override
  _ListManagementState createState() => _ListManagementState();
}

class _ListManagementState extends State<ListManagement> {
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Your Listings'),
          bottom:   TabBar(
            tabs: [
              Tab(text: "Rentals".toUpperCase(),),
              Tab(text: "plots".toUpperCase(),),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            RentalListManagement(),
            PlotsListManagement(),
          ],
        ),
      ),
    );
  }
}