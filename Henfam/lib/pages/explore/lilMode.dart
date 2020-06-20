import 'package:Henfam/models/errandModel.dart';
import 'package:Henfam/pages/explore/errandDropDown.dart';
import 'package:Henfam/pages/explore/errandsNearby.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/pages/explore/helpcard.dart';
import './scheduledRequests.dart';
import './currentOrder.dart';
import 'package:Henfam/widgets/largeTextSection.dart';

class LilMode extends StatelessWidget {
  final List<Map<String, Object>> activities;

  LilMode(this.activities);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        CurrentOrder("Jessie", "7:30", "on the way"),
        ScheduledRequests(),
        LargeTextSection("What would you like help with, John?"),
        Container(
          child: HelpCard(activities),
        ),
        LargeTextSection("Or choose from other errands nearby!"),
        Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: ErrandsNearby(),
        ),
      ],
    );
  }
}