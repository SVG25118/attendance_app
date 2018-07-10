import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:attendance_app/tabs/course/announcements.dart' as _firstTab;
import 'package:attendance_app/tabs/course/courseMaterial.dart' as _secondTab;
import 'package:attendance_app/tabs/course/questions.dart' as _thirdTab;

Future<http.Response> doPost(String name) async {
  return http.get(
      'https://svg25118.herokuapp.com/API?command=checkin&course=$name&uid=test&key=(key%20field%20information)');
}

String courseName = "";

class CoursePage extends StatelessWidget {
  String name;

  CoursePage(String name, String desc) {
    this.name = name;
    courseName = name;
  }

  @override
  Widget build (BuildContext context) {
    doPost(name);
    return new Scaffold(
      //App Bar
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: new Text(
          name,
          style: new TextStyle(
            fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),

      //Content of tabs
      body: new PageView(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new Tabs(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  PageController _tabController;

  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(
      //Content of tabs
      body: new SafeArea(
        child: new PageView(
          controller: _tabController,
          onPageChanged: onTabChanged,
          children: <Widget>[
            new _firstTab.Announcements(courseName),
            new _secondTab.CourseMaterial(),
            new _thirdTab.Questions()
          ],
        ),
      ),

      //Tabs
      bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title,style: new TextStyle(color: Colors.blueGrey),),
            icon: new Icon(TabItem.icon,color: Colors.blueGrey),
          );
        }).toList(),
      ),
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Announcements', icon: Icons.description),
  const TabItem(title: 'Material', icon: Icons.file_download),
  const TabItem(title: 'Questions', icon: Icons.import_export),
];