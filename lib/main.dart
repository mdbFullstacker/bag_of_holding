import 'package:bag_of_holding/views/asyncOefening.dart';
import 'package:bag_of_holding/views/voertuigenVergelijker.dart';
import 'package:flutter/material.dart';
import 'views/signup.dart';
import 'views/profile.dart';
import 'views/voertuigenVergelijker.dart';

void main() {
  runApp(const BagOfHolding());
}

class BagOfHolding extends StatelessWidget {
  const BagOfHolding({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
      ),
      home: const MyHomePage(title: 'Bag of Holding'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => voertuigen()),
              );
            },
            icon: const Icon(Icons.directions_car_filled_rounded),
            tooltip: 'Voertuigen vergelijker',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => asyncOefening()),
              );
            },
            icon: const Icon(Icons.http_rounded),
            tooltip: 'async oefening',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile()),
              );
            },
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profiel',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text('Choose your destiny'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'loginButton',
                    onPressed: null,
                    tooltip: 'click to login',
                    label: Text(" Login "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    heroTag: 'registerButton',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    tooltip: 'click to register',
                    label: Text("Register"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
