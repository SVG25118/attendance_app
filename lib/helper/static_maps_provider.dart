import 'package:flutter/material.dart';

class StaticMap extends StatefulWidget {
  final List locations;
  final String googleMapsApiKey;
  final int width;
  final int height;
  final int zoom;

  StaticMap(this.googleMapsApiKey,
      {this.width, this.height, this.locations, this.zoom});
  @override
  _StaticMapState createState() => new _StaticMapState();
}

class _StaticMapState extends State<StaticMap> {
  String startUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2000px-Solid_white.svg.png';
  String nextUrl;
  static const int defaultWidth = 600;
  static const int defaultHeight = 400;
  Map<String, String> defaultLocation = {
    "latitude": '-32.892569',
    "longitude": '151.704177'
  };

  _buildUrl(List locations, int width, int height) {
    var finalUri;
    var baseUri = new Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {});

    finalUri = baseUri.replace(queryParameters: {
      'markers': 'color:blue|${locations[0]['latitude']},${locations[0]['longitude']}',
      'center': '${locations[0]['latitude']},${locations[0]['longitude']}',
      'zoom': widget.zoom.toString(),
      'size': '${width ?? defaultWidth}x${height ?? defaultHeight}',
      '${widget.googleMapsApiKey}': ''
    });
    setState(() {
      startUrl = nextUrl ?? startUrl;
      nextUrl = finalUri.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locations.length == 0) {
      widget.locations.add(defaultLocation);
    }
    _buildUrl(widget.locations, widget.width ?? defaultWidth,
        widget.height ?? defaultHeight);
    return new Container(
        child: new FadeInImage(
          fit: BoxFit.cover,
          placeholder: new AssetImage("assets/img/transparent.png"),
          image: new NetworkImage(nextUrl),
        ));
  }
}