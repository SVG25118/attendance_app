import 'package:flutter/material.dart';
import 'package:attendance_app/screens/CoursePage.dart' as _coursePage;

class CourseCard extends StatelessWidget {
  String courseName;
  String courseDesc;
  String courseLocation;
  String courseTime;

  CourseCard(String courseName, String courseDesc, String courseLocation, String courseTime) {
    this.courseName = courseName.trim();
    this.courseDesc = courseDesc.trim();
    this.courseLocation = courseLocation.trim();
    this.courseTime = courseTime.trim();
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => _coursePage.CoursePage(courseName,courseDesc),
      )),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(5.0,10.0,5.0,0.0),
        child: new Card(
          child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //new Icon(Icons.tag_faces,size: 30.0,),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      courseName,
                      style: new TextStyle(fontSize: 25.0),
                    ),
                    new Text("$courseLocation\n$courseTime\n$courseDesc")
                  ],
                ),
                new IconButton(
                  icon: new Icon(Icons.exit_to_app,size: 40.0,color: Colors.blueGrey,),
                  onPressed: () => Navigator.of(context).push(new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => _coursePage.CoursePage(courseName,courseDesc),
                  )),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
