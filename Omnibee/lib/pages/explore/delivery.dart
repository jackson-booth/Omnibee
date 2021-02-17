import 'package:Omnibee/pages/explore/restaurantCard.dart';
import 'package:flutter/material.dart';
import 'package:Omnibee/widgets/largeTextSection.dart';
import 'package:Omnibee/pages/explore/errandFee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    final String arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arg),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ErrandFee(),
            LargeTextSection("Choose a restaurant"),
            Column(children: [
              StreamBuilder(
                  stream:
                      Firestore.instance.collection('restaurants').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading....');
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return RestaurantCard(context,
                              document: snapshot.data.documents[index]);
                        });
                  }),
            ]),
          ],
        ),
      ),
    );
  }
}
