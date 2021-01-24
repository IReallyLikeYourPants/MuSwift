import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("HomePage")),
        body: MyWidget(),
      ),
    );
  }
}

class UrlObject {
  final String url;

  UrlObject(this.url);
}

Stream<List<UrlObject>> generate(int num, Duration timeout) async* {
  List<UrlObject> list = [];
  int seed = Random().nextInt(200);
  for (int i = 0; i < num; ++i) {
    await Future.delayed(timeout);
    yield list..add(UrlObject("https://loremflickr.com/640/480/dog?random=$i$seed"));
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Stream<List<UrlObject>> stream1;
  Stream<List<UrlObject>> stream2;
  Stream<List<UrlObject>> stream3;

  @override
  void initState() {
    stream1 = generate(10, Duration(seconds: 1, milliseconds: 500));
    stream2 = generate(10, Duration(seconds: 1));
    stream3 = generate(30, Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        streamItems(stream1, (context, list) => HList(objects: list)),
        streamItems(stream2, (context, list) => HList(objects: list)),
        streamItems(stream3, (context, list) => HList(objects: list)),
      ],
    );
  }

  Widget streamItems(Stream stream, Widget builder(BuildContext context, List<UrlObject> objects)) {
    return StreamBuilder(
      initialData: new List<UrlObject>(),
      builder: (context, snapshot) => builder(context, snapshot.data),
      stream: stream,
    );
  }
}

class HList extends StatelessWidget {
  final List<UrlObject> objects;

  const HList({Key key, this.objects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: objects.length,
        itemBuilder: (context, index) {
          return new AspectRatio(
            aspectRatio: 3.0 / 2.0,
            child: Image.network(
              objects[index].url,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}