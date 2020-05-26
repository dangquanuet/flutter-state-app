import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// bloc
enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
    }
  }
}

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    print("build");
    return Scaffold(
      body: BlocBuilder<CounterBloc, int>(builder: (context, count) {
        print("center $count");
        return Center(
          child: Text(
            '$count',
            style: TextStyle(fontSize: 24.0),
          ),
        );
      }),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  counterBloc.add(CounterEvent.increment);
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
                child: Icon(Icons.remove),
                onPressed: () {
                  counterBloc.add(CounterEvent.decrement);
                }),
          ),
        ],
      ),
    );
  }
}
