import 'package:bag_of_holding/models/Vliegtuig.dart';
import 'package:bag_of_holding/models/Voertuig.dart';
import 'package:flutter/material.dart';

import '../models/Auto.dart';

Widget voertuigTemplate(Voertuig voertuig) {
  return Card(
    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
    color: Colors.blue,
    child: Column(
      children: [
        if (voertuig.wheels == null) ...[
          Icon(Icons.directions_boat_filled_rounded, size: 60),
        ],
        if (voertuig is Vliegtuig) ...[
          Icon(Icons.airplanemode_active, size: 60),
        ] else if (voertuig is Auto) ...[
          Icon(Icons.directions_car_filled, size: 60),
        ],
        Text(
          voertuig.name,
          style: TextStyle(fontSize: 18, color: Colors.white60),
        ),
        SizedBox(height: 22),
        Text(
          '${voertuig.brand} heeft aantal: ${voertuig.passangers} plekken voor passagiers',
          style: TextStyle(fontSize: 12, color: Colors.black12),
        ),
      ],
    ),
  );
}
