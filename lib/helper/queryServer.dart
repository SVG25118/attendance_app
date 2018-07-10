import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchPost() async {
  return http.get(
      'https://engg1500.newcastle.edu.au/ENGG1500DemoServer/API?command=export&group=GROUP5');
}

List uid = [];

class QueryServer extends StatefulWidget {
  @override
  _QueryServerState createState() => new _QueryServerState();
}

class _QueryServerState extends State<QueryServer> {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new FutureBuilder<http.Response>(
        future: fetchPost(),
        builder: (context, snapshot) {
          int startPos;
          int endPos;
          if (snapshot.hasData) {
            startPos = snapshot.data.body.toString().indexOf('[') + 1;
            endPos = snapshot.data.body.toString().indexOf(']');
            uid = snapshot.data.body
                .toString()
                .substring(startPos, endPos)
                .split(',');
            return new Container(
                height: (MediaQuery.of(context).size.height) * 0.4,
                margin: new EdgeInsets.all(15.0),
                child: new ListView.builder(
                    itemCount: uid.length,
                    itemBuilder: (context, index) {
                      return new Padding(
                        padding: new EdgeInsets.only(bottom: 5.0),
                        child: new MaterialButton(
                          height: 50.0,
                          onPressed: fetchPost,
                          color: Colors.blueGrey,
                          child: new Text(
                            uid[index].trim(),
                            style: new TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }));
            //return new Text(uid.toString());
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return new CircularProgressIndicator();
        },
      ),
    );
  }
}
