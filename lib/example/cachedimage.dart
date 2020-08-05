import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Cached Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          width: 100,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  'https://pix10.agoda.net/hotelImages/1199068/-1/09cb9a2780bf41ad1e8f8a3d2e074754.jpg?s=1024x768',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(BuildContext buildContext) {
    return Container(
      width: 100,
      height: 100,
      child: GestureDetector(
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: 'https://picsum.photos/250?image=9',
        ),
        onTap: () {
          showModalBottomSheet<void>(
            context: buildContext,
            builder: (context) {
              return Container(
                child: Text('model bottom sheet'),
              );
            },
          );
        },
      ),
    );
  }
}
