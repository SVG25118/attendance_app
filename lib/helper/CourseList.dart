import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CourseCard.dart';

var uid = {};
List<Widget> courses = [];

Future<http.Response> fetchUID() async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=exportCourses');
}

Future<http.Response> fetchInfo(String courseID) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=exportCourseInfo&course=$courseID');
}

Widget buildCourse() {
  return new FutureBuilder(
    future: courseRequest(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return new ListView(
          padding: new EdgeInsets.all(0.0),
          children: courses,
        );
      } else if (snapshot.hasError) {
        print(snapshot.error.toString());
        return new Text(
          'NO COURSES NEARBY',
          style: new TextStyle(fontSize: 22.0,color: Colors.white),
        );
      } else {
        return new CircularProgressIndicator();
      }
    },
  );
}

Future courseRequest() async {
  uid = {};
  List s = await buildCourseList();
  for(var item in s) {
    uid[item.trim()] = await buildCourseInfo(item.trim());
  }
  courses = [];
  uid.forEach((k,v) {
    courses.add(new CourseCard(k,v[0],v[1],v[2]));
    print('$k: $v'); //DEBUGGING
  });
  return courses;
}

Future buildCourseList() {
  return fetchUID().then((data) => data.body.toString().substring(data.body.toString().indexOf('[') + 1, data.body.toString().indexOf(']')).split(','));
}
Future buildCourseInfo(String course) {
  //fetchInfo(course).then((data) => print(data.body.toString().substring(data.body.toString().indexOf('[') + 1, data.body.toString().indexOf(']')).split(',')));
  return fetchInfo(course).then((data) => data.body.toString().substring(data.body.toString().indexOf('[') + 1, data.body.toString().indexOf(']')).split(','));
}

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: buildCourse(),
    );
  }
}