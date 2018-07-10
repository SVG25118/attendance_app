import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  String eventName;
  String eventDesc;
  String eventTime;
  String eventImage;

  EventCard(String eventName, String eventDesc, String eventTime, String eventImage) {
    this.eventName = eventName.trim();
    this.eventDesc = eventDesc;
    this.eventTime = eventTime;
    this.eventImage = eventImage;
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => print("Pushed"),
      child: new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Card(
          child: new Row(
            children: <Widget>[
              new Image.asset("assets/img/$eventImage.png",height: 125.0,),
              new Expanded(
                child: new ListTile(
                  title: new Text(eventName),
                  subtitle: new Text("$eventTime\n\n$eventDesc",overflow: TextOverflow.ellipsis,),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
