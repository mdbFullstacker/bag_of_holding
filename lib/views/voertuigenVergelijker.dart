import 'package:bag_of_holding/models/Boot.dart';
import 'package:bag_of_holding/models/Vliegtuig.dart';
import 'package:bag_of_holding/models/Voertuig.dart';
import 'package:bag_of_holding/styles/voertuigTemplate.dart';
import 'package:flutter/material.dart';

import '../models/Auto.dart';

class voertuigen extends StatefulWidget {
  const voertuigen({super.key});

  @override
  State<voertuigen> createState() => _voertuigenState();
}

class _voertuigenState extends State<voertuigen> {
  List<Voertuig> voertuigen = [
    Auto(1, 'betsie', 'Kia', 4, 6),
    Auto(2, 'betsie2','BMW', 4, 6),
    Vliegtuig(3, 'flytje', 'Bowing', 8, 250),
    Vliegtuig(4, 'flytje2', 'Bowing737', 8, 750),
    Boot(5, 'Zr.Ms. Groningen', 'OPV', null, 200)

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Voertuig orginizer!"),
        centerTitle: true,
      ),
    body: Column(
      children: voertuigen.map((voertuig) => voertuigTemplate(voertuig)).toList(),
    ),
    );
  }
}
