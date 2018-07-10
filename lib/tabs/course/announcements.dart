import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getCourseInfo(String name) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=exportCourseInfo&course=$name');
}

Future<http.Response> doPost(String name) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=checkin&course=$name&uid=test&key=(key%20field%20information)');
}

Future<http.Response> doRemove() async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=remove&group=GROUP5&uid=test');
}

class Announcements extends StatelessWidget {
  String name;

  Announcements(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) => new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(
              Icons.description,
              size: 150.0,
              color: Colors.black12
          ),
          new Expanded(
            child: new ListView(
              children: <Widget>[
                new FutureBuilder<http.Response>(
                  future: getCourseInfo(name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int startPos = snapshot.data.body.toString().indexOf('[') + 1;
                      int endPos = snapshot.data.body.toString().indexOf(']');
                      List result = snapshot.data.body.toString().substring(startPos, endPos).split(',');
                      return new Text(
                        result[1],
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 22.0
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return new Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner
                    return new Center(
                      child: new CircularProgressIndicator(),
                    );
                  },
                )
              ],
            )
          )
        ],
      )
  );
}