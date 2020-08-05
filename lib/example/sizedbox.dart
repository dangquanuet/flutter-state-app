import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _currentColor = Colors.grey;

  Random _random = new Random();

  void _onPressed() {
    int randomNumber = _random.nextInt(30);
    setState(() {
      _currentColor = Colors.primaries[randomNumber % Colors.primaries.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('building `MyHomePage`');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: Icon(Icons.colorize),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BackgroundWidget(),
          ),
          Center(
            child: Container(
              height: 150,
              width: 150,
              color: _currentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building `BackgroundWidget`');
    return Image.network(
      'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
      fit: BoxFit.cover,
    );
  }
}

class MyButton extends StatelessWidget {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                child: Text('Click me $count'),
                onTap: () {
                  count++;
                  print("CLicked $count ${DateTime.now()}");
                  build(context);
                },
              ),
            ),
            FutureBuilder<String>(
              future: Future.delayed(
                Duration(seconds: 1),
              ),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Text(snapshot.data);
              },
            ),
            StreamBuilder<String>(
              stream: Stream.periodic(Duration(seconds: 1)),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Text(snapshot.data);
              },
            )
          ],
        ),
      ),
    );
  }
}
