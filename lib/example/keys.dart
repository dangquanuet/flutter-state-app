import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  String hint = '';

  MyTextField(Key key, this.hint) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState(hint);
}

class _MyTextFieldState extends State<MyTextField> {
  final controller = TextEditingController();
  String hint = '';

  _MyTextFieldState(this.hint);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            if (showFirst) MyTextField(ValueKey(1), 'first'),
            MyTextField(ValueKey(2), 'second'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            showFirst = false;
          });
        },
      ),
    );
  }
}

main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
