import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getQuestion(String course) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=exportCourseInfo&course=$course');
}

Future<http.Response> sendAnswer(String course, String question, String answer) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=addAnswer&course=$course&uid=c1234567&question=$question&answer=$answer');
}

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => new _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool _isDisabled;

  @override
  void initState() {
    _isDisabled = false;
  }

  void _answerQuestion(String value) {
    print(value);
    showDialog(
        context: context,
        child: new AlertDialog( title: new Text('Please Confirm'),
            content: new Container(
              child: new Text("Is $value your final answer?"),
            ),
            actions: [
              new FlatButton(
                child: new Text('NO'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              new FlatButton(
                child: new Text('YES'),
                onPressed: () { Navigator.of(context).pop();
                  setState(() {
                    _isDisabled = !_isDisabled;
                  });
                  sendAnswer("TEST1234", "test", value);
                },
              ),
            ]
        ));
  }

  Widget _buildButton(String value, double size) {
    return new MaterialButton(
      child: new Text(
        _isDisabled ? "DONE" : value,
        style: new TextStyle(fontSize: size,color: Colors.white70),),
      color: Colors.blueGrey,height: MediaQuery.of(context).size.height*.25,
      onPressed: _isDisabled ? null : () {_answerQuestion(value);},
    );
  }

  Widget questionType(int value, BuildContext context, bool _isDisabled) {
    switch(value) {
      case 1: return new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.all(15.0),
                    child: _buildButton("A",69.0),
                  )
              ),
              new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.all(15.0),
                    child: _buildButton("B",69.0),
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
                    child: _buildButton("C",69.0),
                  )
              ),
              new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.all(15.0),
                    child: _buildButton("D",69.0),
                  )
              ),
            ],
          ),
        ],
      );
      break;
      case 2: return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: _buildButton("TRUE",45.0),
              )
          ),
          new Expanded(
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: _buildButton("FALSE",45.0),
              )
          ),
        ],
      );
      break;
      default: return new Text("No Questions",style: new TextStyle(fontSize: 45.0));
    }
  }

  @override
  Widget build(BuildContext context) => new Container(
    child: _isDisabled ?
    new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text("No Questions",style: new TextStyle(fontSize: 45.0)),
        new RaisedButton(onPressed: () => _answerQuestion("RESET"), child: new Text("RESET"),)
      ],
    ) : questionType(2, context, _isDisabled),
  );
}