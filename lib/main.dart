import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
//  runApp(StateApp());

  runApp(ChangeNotifierProvider(
    create: (context) => CountModel(),
    child: ProviderApp(),
  ));
}

/// setState sample
class StateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StatePage(),
    );
  }
}

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Scaffold $_counter");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/// provider sample
class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProviderPage(),
    );
  }
}

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Scaffold");
    return Scaffold(
      body: Center(
        child: Consumer<CountModel>(builder: (context, countModel, child) {
          print("Consumer ${countModel.count}");
          return GestureDetector(
            onTap: () => getCountModel(context).decreaseCounter(),
            child: Text(
              countModel.count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getCountModel(context).increaseCounter(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  CountModel getCountModel(context) =>
      Provider.of<CountModel>(context, listen: false);
}

class CountModel with ChangeNotifier {
  int count = 0;

  increaseCounter() {
    count++;
    notifyListeners();
  }

  decreaseCounter() {
    count--;
    notifyListeners();
  }
}
