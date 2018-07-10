import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../helper/static_maps_provider.dart';
import '../helper/CourseList.dart';

class courseFinder extends StatefulWidget {
  @override
  courseFinderState createState() => new courseFinderState();
}

class courseFinderState extends State<courseFinder> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  List locations = [];
  String googleMapsApi = 'AIzaSyB21IMgcC5x-1OKPQRRigGgBegtXXBdcrs';

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  String error;
  bool currentWidget = true;
  Image image1;

  @override
  void initState() {
    super.initState();

    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged.listen((Map<String,double> result) {
          if(this.mounted){
            setState(() {
              _currentLocation = result;
              locations = [_currentLocation];
            });
          }
        });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }

    if(this.mounted){
      setState(() {
        _startLocation = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    if (_currentLocation == null) {
      widgets = [
        new LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = MediaQuery.of(context).size.height;
              return new Container(
                height: height*0.35,
                child: new Center(
                  child: new CircularProgressIndicator(),
                ),
              );
            }
        ),
      ];
    } else {
      widgets = [
        new LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = MediaQuery.of(context).size.height;
              double width = MediaQuery.of(context).size.width;
              return new Container(
                height: height*0.40,
                width: width,
                color: new Color(0xFF171717),
                child: new Container(
                  child: new StaticMap(googleMapsApi, locations: locations, zoom: 19),
                ),
              );
            }
        ),
      ];
    }

//    widgets.add(new Center(
//        child: new Text(_currentLocation != null
//            ? '${_currentLocation["latitude"]}, ${_currentLocation["longitude"]}'
//            : 'Error: $error\n')));

    widgets.add(new Divider());

    widgets.add(new Expanded(
      child: new CourseList(),
    ));


    return new Scaffold(
        body: new Column(
          children: widgets,
        )
    );
  }
}