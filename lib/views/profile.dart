import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int red = 0;
  int blue = 0;
  int green = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(child: Text('Color picker'), padding: EdgeInsets.all(20),),
          Row(
            children: [
              Expanded(
                child: Container( padding: EdgeInsets.all(20), color: Colors.red, child: Text('$red'), alignment: Alignment.center,),
              ),
              Expanded(
                child: Container(padding: EdgeInsets.all(20), color: Colors.blue, child: Text('$blue'), alignment: Alignment.center,),
              ),
              Expanded(child: Container(padding: EdgeInsets.all(20), color: Colors.green, child: Text('$green'), alignment: Alignment.center,))
            ],
          ),
          Slider(
            value: red.toDouble(),
            min: 0,
            max: 255,
            onChanged: (double value) {
              setState(() {
                red = value.floor();
              });
            },
          ),
          Slider(
            value: blue.toDouble(),
            min: 0,
            max: 255,
            onChanged: (double value) {
              setState(() {
                blue = value.floor();
              });
            },
          ),
          Slider(
            value: green.toDouble(),
            min: 0,
            max: 255,
            onChanged: (double value) {
              setState(() {
                green = value.floor();
              });
            },
          ),
          Divider(thickness: 20,height: 150,),
          Container(padding: EdgeInsets.all(60) ,color: Color.fromRGBO(red, green, blue , 10) )
        ],
      ),
    );
  }
}
