import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './tabs/home.dart' as _firstTab;
import './tabs/courseFinder.dart' as _secondTab;
import './tabs/stats.dart' as _thirdTab;
//import './tabs/settings.dart' as _fourthTab;

class Tabs extends StatefulWidget {
  String uid;
  Tabs(String _uid){
    uid = _uid;
  }

  @override
  TabsState createState() => new TabsState(uid);
}

class TabsState extends State<Tabs> {
  String uid;
  TabsState(String _uid){
    uid = _uid;
  }

  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: new Text(
          _title_app,
          style: new TextStyle(
            fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),

      //Content of tabs
      body: new SafeArea(
        child: new PageView(
          controller: _tabController,
          onPageChanged: onTabChanged,
          children: <Widget>[
            new _firstTab.Home(),
            new _secondTab.courseFinder(),
            new _thirdTab.Stats(),
            //new _fourthTab.Settings()
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

      //Drawer
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new Container(
                height: 120.0,
                child: new DrawerHeader(
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: new Color(0x000000),
                  ),
                  child: new Center(
                    child: new Image.asset("assets/img/uon-logo-transparent.png"),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0,5.0,0.0,25.0),
                child: new Text(
                  uid,
                  style: new TextStyle(fontSize: 32.0,color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              new ListTile(
                  leading: new Icon(Icons.chat),
                  title: new Text('Support'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/support');
                  }
              ),
              new ListTile(
                  leading: new Icon(Icons.info),
                  title: new Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/about');
                  }
              ),
              new Divider(),
              new ListTile(
                  leading: new Icon(Icons.exit_to_app),
                  title: new Text('Sign Out'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
              ),
            ],
          )
      )
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    this._title_app = TabItems[tab].title;
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Announcements', icon: Icons.school),
  const TabItem(title: 'Course Finder', icon: Icons.location_on),
  const TabItem(title: 'Stats', icon: Icons.dashboard),
  //const TabItem(title: 'Settings', icon: Icons.settings),
];