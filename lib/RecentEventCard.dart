import 'package:flutter/material.dart';

class RecentEventCard extends StatelessWidget {
  String courseName;
  String courseDesc;
  String courseLocation;
  String courseTime;

  RecentEventCard(String courseName, String courseDesc, String courseLocation, String courseTime) {
    this.courseName = courseName.trim();
    this.courseDesc = courseDesc;
    this.courseLocation = courseLocation;
    this.courseTime = courseTime;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.tag_faces,size: 40.0,),
              title: new Text(courseName),
              subtitle: new Text("$courseLocation\n$courseTime\n$courseDesc"),
            ),
            new ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Lecture Material'),
                    onPressed: () { /* ... */ },
                  ),
                  new FlatButton(
                    child: const Text('Questions'),
                    onPressed: () { /* ... */ },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
