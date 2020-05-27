import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static const COUNTER_KEY = "COUNTER";
  int count;

  CountModel() {
    _getCounter();
  }

  _getCounter() async {
    SharedPreferences.getInstance().then((value) {
      final countValue = value.getInt(COUNTER_KEY);
      if (countValue != null) {
        count = countValue;
      } else {
        count = 0;
      }
      notifyListeners();
    });
  }

  increaseCounter() async {
    count++;
    notifyListeners();
    SharedPreferences.getInstance().then((value) {
      value.setInt(COUNTER_KEY, count);
    });
  }

  decreaseCounter() async {
    count--;
    notifyListeners();
    SharedPreferences.getInstance().then((value) {
      value.setInt(COUNTER_KEY, count);
    });
  }
}
