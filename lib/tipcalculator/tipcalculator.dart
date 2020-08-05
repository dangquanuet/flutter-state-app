import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: TipCalculator(),
  ));
}

class TipCalculator extends StatelessWidget {
  double billAmount = 0.0;
  double tipPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    TextField billAmountTextField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          billAmount = double.parse(value);
        } catch (e) {
          billAmount = 0.0;
        }
      },
      decoration: InputDecoration(labelText: 'Bill amount (\$)'),
    );

    TextField tipPercentField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          tipPercent = double.parse(value);
        } catch (e) {
          tipPercent = 0.0;
        }
      },
      decoration: InputDecoration(labelText: 'Tip %', hintText: '15'),
    );

    RaisedButton calculateButton = RaisedButton(
        child: Text('Calculate'),
        onPressed: () {
          double calculateTip = billAmount * tipPercent / 100.0;
          double total = billAmount + calculateTip;

          AlertDialog alertDialog = AlertDialog(
            content: Text('Tip: \$$calculateTip\nTotal: \$$total'),
          );

          showDialog(context: context, builder: (context) => alertDialog);
        });

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [billAmountTextField, tipPercentField, calculateButton],
        ),
      ),
    );
  }
}
