import 'package:flutter/material.dart';

class RentalFullPage extends StatefulWidget {
  @override
  _RentalFullPageState createState() => _RentalFullPageState();
}

class _RentalFullPageState extends State<RentalFullPage> {
  Container amenitygriditem(String amenityitem) {
    return Container(
      child: Row(
        children: [
          Text(amenityitem),
          Icon(Icons.done_all),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(7),
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "assets/images/logo.jpg",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "Mants Apartments",
                    ),
                  ),
                  Text("King'ore Dr, Ruaka, Kiambu County"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.king_bed,
                            ),
                            Text("2 bedrooms")
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.bathtub,
                            ),
                            Text("1 bathrooms")
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    child: Text("Kshs 200K"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Amenities".toUpperCase()),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "External".toUpperCase(),
                          maxLines: 2,
                        ),
                        Column(
                          children: [
                            amenitygriditem("balcony".toLowerCase()),
                            amenitygriditem("lift".toLowerCase()),
                            amenitygriditem("parking".toLowerCase()),
                            amenitygriditem("swimming pool".toLowerCase()),
                            amenitygriditem("gym".toLowerCase()),
                            amenitygriditem("laundry area".toLowerCase()),
                            amenitygriditem("backup generator".toLowerCase()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Internal".toUpperCase(),
                          maxLines: 2,
                        ),
                        Column(
                          children: [
                            amenitygriditem("furnished".toLowerCase()),
                            amenitygriditem("Internet".toLowerCase()),
                            amenitygriditem("serviced".toLowerCase()),
                            amenitygriditem(
                                "service fee included".toLowerCase()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "security".toUpperCase(),
                          maxLines: 2,
                        ),
                        Column(
                          children: [
                            amenitygriditem("cctv".toLowerCase()),
                            amenitygriditem("electric fence".toLowerCase()),
                            amenitygriditem(
                                "24hr security watch".toLowerCase()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                        "Wealthlink presents an executive,2br apartment in the heart of Westlands, off Waiyaki way, Mvuli road On 4th Floor, spacious, modern, airly, with alot of natural lighting Key Features: Spacious living room, with a spacious balcony Modern spacious fitted kitchen with a cooker, fridge, oven, microwave, water heater, Spacious pantry Spacious dhobi area with a washing Machine Visitors washroom Ensuite Bedroom, spacious with sufficient closet Ensuite Master bedroom with a bath tub, shower cubicle, double sink Wooden floor and tiled on wet areas. Very secure, perimeter wall, electric fence, back up generator, sufficient water supply with a borehole Ample parking Contact us for more information and viewing arrangement"),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "About the agent",
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset("assets/images/logo.jpg"),
                      ),
                      Column(
                        children: [
                          Text("Company name"),
                          Text("over 5+ years in real estate"),
                          Text("5 property in management"),
                          Row(children: [
                            Icon(Icons.phone),
                            Text("0798767470"),
                          ]),
                          Row(children: [
                            Icon(Icons.email),
                            Text("brian@email.com"),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
