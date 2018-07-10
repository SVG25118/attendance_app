import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getQuestion(String course) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=exportCourseInfo&course=$course');
}

Future<http.Response> sendAnswer(String course, String answer) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=checkin&course=$course&uid=test&key=(key%20field%20information)');
}

class Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text("blah"),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new MaterialButton(onPressed: () => print("A"),child: new Text("A",style: new TextStyle(fontSize: 69.0,color: Colors.white70),),color: Colors.blueGrey,height: MediaQuery.of(context).size.height*.25,),
                )
            ),
            new Expanded(
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new MaterialButton(onPressed: () => print("B"),child: new Text("B",style: new TextStyle(fontSize: 69.0,color: Colors.white70),),color: Colors.blueGrey,height: MediaQuery.of(context).size.height*.25,),
                )
            ),
          ],
        ),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new MaterialButton(onPressed: () => print("C"),child: new Text("C",style: new TextStyle(fontSize: 69.0,color: Colors.white70),),color: Colors.blueGrey,height: MediaQuery.of(context).size.height*.25,),
                )
            ),
            new Expanded(
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new MaterialButton(onPressed: () => print("D"),child: new Text("D",style: new TextStyle(fontSize: 69.0,color: Colors.white70),),color: Colors.blueGrey,height: MediaQuery.of(context).size.height*.25,),
                )
            ),
          ],
        ),
      ],
    ),
  );
}