import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: DemoANimation(),
    );
  }
}

class DemoANimation extends StatefulWidget {
  @override
  _DemoANimationState createState() => _DemoANimationState();
}

class _DemoANimationState extends State<DemoANimation> {
  bool bigger = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          children: [
            AnimatedContainer(
              width: bigger ? 100 : 400,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Text(
                "Hello",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  bigger = !bigger;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
