import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Native Code from Dart'),
      ),
      body: new MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('method');
  @override
  initState() {
    super.initState();
  }

  String message = "whatever";
  String _adress = 'init';
  Request rs = new Request(city: 'elazığ', streets: ['hazardağlı','harput'] );

  Future<void> getadress(city,streests) async {
    Response result;
    try {
      result = Response.fromJson(await platform.invokeMethod('getadress', rs.toMap()));
    } on PlatformException catch (e) {
      message = "'${e.message}'.";
    }
    setState(() {
      _adress = result.cap.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
                child: Text('Call Native Method'),
                onPressed: () {
                  getadress(rs.city,rs.streets);
                }),
            Text(_adress.toString()),
          ],
        ),
      ),
    );
  }
}

class Request {
  String city;
  List<String> streets;
  Request({this.city, this.streets});

  Map<String, dynamic> toMap() => {
        "city": city,
        "streets": streets,
  };
}
class Response {
  String city ;
  List<String> streets;
  int cap;
  List<Response2> rp2;

  Response({this.city, this.streets,this.cap,this.rp2});
  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));
  factory  Response.fromMap(Map<String, dynamic> json){
    var streetsFromJson  = json['streets'];
    List<String> streetsList = streetsFromJson.cast<String>();
    var list = json['person'] as List;
    List<Response2> rp2 = list.map((i) => Response2.fromJson(i)).toList();
    return Response(
      city: json["city"],
      streets: streetsList,
      cap:json["cap"],
      rp2: rp2,
    );
  }
}
class Response2{
    String name,surname;
    int age;

    Response2({this.name, this.surname, this.age});
    factory Response2.fromJson(String str) => Response2.fromMap(json.decode(str));
    factory  Response2.fromMap(Map<String, dynamic> json){
      return Response2(
        name: json["name"],
        surname: json["surname"],
        age: json["age"],
      );
    }

}
