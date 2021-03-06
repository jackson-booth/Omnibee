import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Omnibee/factory/factory.dart';

class RestaurantCard extends StatelessWidget {
  final DocumentSnapshot document;

  RestaurantCard(BuildContext context, {this.document}); //this.restaurant);

  String _getTimeRange(DocumentSnapshot doc) {
    int index = DateTime.now().weekday - 1;
    String startTime = document["new_hours"][index]["start_time"];
    String endTime = document["new_hours"][index]["end_time"];
    return "Open from $startTime - $endTime";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          // parse location
          GeoPoint position = document['location'];
          List<double> location = [position.latitude, position.longitude];

          // parse cuisine types
          List<String> cuisineTypes = List<String>.from(document['type_food']);

          int index = DateTime.now().weekday - 1;
          // parse hours
          Map<String, String> hours = {
            'start_time': document['new_hours'][index]['start_time'],
            'end_time': document['new_hours'][index]['end_time'],
          };

          Restaurant selectedRestaurant = Restaurant(
            name: document['restaurant_name'],
            location: location,
            cuisineTypes: cuisineTypes,
            hours: hours,
            menu: MenuFactory.constructMenu(document),
            bigImagePath: document['big_photo'],
            smallImagePath: document['small_photo'],
          );
          BlocProvider.of<RestaurantBloc>(context)
              .add(RestaurantUpdated(selectedRestaurant));
          Navigator.pushNamed(context, '/Menu');
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Image(
                  image: AssetImage(document['small_photo']),
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(document['restaurant_name'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.only(bottom: 7)),
                      Text(document['type_food'].join(', ')),
                      Padding(padding: EdgeInsets.only(bottom: 7)),
                      Text(
                        _getTimeRange(document),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
