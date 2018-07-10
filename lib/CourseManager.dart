import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> modifyCourse(String courseName, String courseDesc, String courseLocation, String courseTime) async {
  return http.get(
    'https://svg25118.herokuapp.com/API?command=addCourse&course=$courseName&loc=$courseLocation&desc=$courseDesc');
}

class CourseManager extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final courseName = TextEditingController();
  final courseDescription = TextEditingController();
  final courseLocation = TextEditingController();
  final courseTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: new ListView(
        padding: new EdgeInsets.symmetric(horizontal: 25.0),
        children: <Widget>[
          new TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your course name starting with TEST',
              labelText: 'Course Name',
            ),
            controller: courseName,
          ),
          new TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.add_location),
              hintText: 'Enter your course location - E.G. ES409',
              labelText: 'Course Location',
            ),
            controller: courseLocation,
          ),
          new TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.date_range),
              hintText: 'Enter your course time - E.G. Mon 4pm-6pm',
              labelText: 'Course Time',
            ),
            controller: courseTime,
          ),
          new TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.description),
              hintText: 'Enter your course description',
              labelText: 'Course Description',
            ),
            controller: courseDescription,
          ),
          new Padding(padding: new EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0), child: new RaisedButton(onPressed: () => modifyCourse(courseName.text, courseDescription.text, courseLocation.text, courseTime.text),child: new Text('Submit')))
        ],
      ),
    );
  }
}

