import 'package:flutter/material.dart';
import 'package:attendance_app/helper/EventCard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(
              Icons.school,
              size: 150.0,
              color: Colors.black12
          ),
          new Divider(),
          new Expanded(
            child: new ListView(
              padding: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              children: <Widget>[
                new EventCard("Lean Startup Workshop Series","Learn how to turn your idea into a successful business About the I2N Lean Startup Workshop Series I2N Lean Startup Workshops are highly interactive an...","5:30pm Monday, 9th Jul 2018","lean"),
                new EventCard("HRF Centre Economic Breakfast", "The next HRF Centre Hunter Economic Breakfast will feature a special focus on connecting the Hunter - transport infrastructure for the future. The fut...", "6:45am Friday, 27th Jul 2018", "economic-breakfast"),
                new EventCard("Newcastle Open Day","Now, more than ever, the world needs new. New thinking, new ideas, new ways to solve the world’s greatest problems. New needs your passion, your...","10am Saturday, 25th Aug 2018","open-day"),
              ],
            )
          )
        ],
      )
  );
}