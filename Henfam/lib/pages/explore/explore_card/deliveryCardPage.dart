import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:Henfam/widgets/miniHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryCardPage extends StatelessWidget {
  Widget _getOrderInformation(DocumentSnapshot doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Name'),
        _getRequesterName(doc),
        MiniHeader('Items'),
        _getYourItems(doc),
      ],
    );
  }

  Widget _getRequesterName(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(doc['user_id']['name']),
    );
  }

  Widget _getYourItems(DocumentSnapshot doc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: doc['user_id']['basket'].length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(doc['user_id']['basket'][index]['name']),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                      '\$${doc['user_id']['basket'][index]['price'].toString()}'),
                )
              ],
            );
          }),
    );
  }

  Widget _getDeliveryWindow(DocumentSnapshot doc) {
    String startTime = doc['user_id']['delivery_window']['start_time'];
    String endTime = doc['user_id']['delivery_window']['end_time'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text("$startTime to $endTime"),
    );
  }

  Widget _getDeliveryLocation(DocumentSnapshot doc) {
    String location = doc['user_id']['location'];
    List<String> wordList = location.split(',');
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(wordList[0]),
    );
  }

  Widget _getDeliveryInformation(DocumentSnapshot doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Delivery Window'),
        _getDeliveryWindow(doc),
        MiniHeader('Destination'),
        _getDeliveryLocation(doc),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Delivery'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Information'),
          _getDeliveryInformation(document),
          MediumTextSection('Order Information'),
          _getOrderInformation(document),
        ],
      ),
    );
  }
}