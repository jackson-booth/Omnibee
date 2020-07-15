import 'package:flutter/material.dart';

class MinEarnings extends StatelessWidget {
  List<Map<String, Object>> requesters;

  MinEarnings(this.requesters);

  String _getMinEarnings() {
    double minEarnings = 0;
    for (int i = 0; i < requesters.length; i++) {
      if (requesters[i]['selected'] == true) {
        minEarnings += requesters[i]['min_earnings'];
      }
    }

    return minEarnings.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Minimum Earnings',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {},
              ),
            ],
          ),
          Text('\$${_getMinEarnings()}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
