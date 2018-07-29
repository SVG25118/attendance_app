import 'package:flutter/material.dart';
import 'StudentAccount.dart' as _studentPage;
import 'StaffAccount.dart' as _staffPage;
import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;

final uid = TextEditingController();
final pwd = TextEditingController();

void main() => runApp(new MaterialApp(
  title: 'UoN Attendance',
  theme: new ThemeData(
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blueGrey, backgroundColor: Colors.white
  ),
  home: new MyApp(),
  onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
      case '/student': return new FromRightToLeft(
        builder: (_) => new _studentPage.Tabs(uid.text),
        settings: settings,
      );
      case '/staff': return new FromRightToLeft(
        builder: (_) => new _staffPage.Tabs(uid.text),
        settings: settings,
      );
      case '/about': return new FromRightToLeft(
        builder: (_) => new _aboutPage.About(),
        settings: settings,
      );
      case '/support': return new FromRightToLeft(
        builder: (_) => new _supportPage.Support(),
        settings: settings,
      );
    }
  },
  // routes: <String, WidgetBuilder> {
  //   '/about': (BuildContext context) => new _aboutPage.About(),
  // }
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0,
              )
            ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
          .animate(
          new CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class _MyAppState extends State<MyApp> {
  bool _enabled = false;

  void _updateText () {
    setState(() {
      uid.text.isEmpty
          ? _enabled = false
          : _enabled = true;
    });
  }

  Container _getBackground () {
    return new Container(
      child: new FadeInImage.assetNetwork(
        height: 600.0,
        fit: BoxFit.cover,
        placeholder: "assets/img/uon-logo-rect.png",
        image: "https://strabe.com.au/wp-content/uploads/2017/08/BPF0094.jpg",
      ),
      constraints: new BoxConstraints.expand(height: 600.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top:400.0),
      height: 200.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00000000),
            new Color(0xFF000000)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getLogin(BuildContext context) {
    return new Container(
      //margin: new EdgeInsets.only(top:450.0),
      alignment: Alignment.bottomCenter,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(bottom: 12.0),
            child: new Center(
              child: new Text(
                'LOGIN',
                style: new TextStyle(fontSize: 22.0,color: Colors.white),
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new OutlineButton(
                onPressed: () => null,
                color: Colors.blue,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                padding: new EdgeInsets.symmetric(vertical: 17.0),
                child: new Container(
                  width: 165.0,
                  child: new Text(
                    'Scan',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 22.0,color: Colors.white),
                  ),
                ),
              ),
              new OutlineButton(
                onPressed: () {
                  pwd.clear();
                  return showDialog(
                    context: context,
                    child: new AlertDialog(
                        content: new Container(
                          height: 125.0,
                          child: new Column(
                            children: <Widget>[
                              new TextFormField(
                                decoration: const InputDecoration(
                                  icon: const Icon(Icons.person),
                                  hintText: 'Please enter your Student Number',
                                  labelText: 'Username',
                                ),
                                autofocus: true,
                                controller: uid,
                                //onChanged: (text) => _updateText(),
                              ),
                              new TextFormField(
                                enabled: true,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  icon: const Icon(Icons.person),
                                  hintText: 'Please enter your Password',
                                  labelText: 'Password',
                                ),
                                autofocus: true,
                                controller: pwd,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          new FlatButton(
                            child: new Text(
                              'Cancel',
                              style: new TextStyle(fontSize: 22.0),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          new FlatButton(
                            child: new Text(
                              'Login',
                              style: new TextStyle(fontSize: 22.0),
                            ),
                            onPressed: () {
                              if(uid.text.startsWith('c')&&uid.text.length>=8&&pwd.text.isNotEmpty){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/student');
                              } else if (pwd.text.isNotEmpty&&pwd.text == '1123') { // UoN!p@ss
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/staff');
                              } else {
                                // Do Nothing
                              }
                            },
                          ),
                        ]
                    ),
                  );
                },
                color: Colors.blue,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                padding: new EdgeInsets.symmetric(vertical: 17.0),
                child: new Container(
                  width: 165.0,
                  child: new Text(
                    'Manual',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 22.0,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0,30.0,0.0,10.0),
            child: new Center(
              child: new Text(
                'Not sure what to do?',
                style: new TextStyle(fontSize: 18.0,color: Colors.white70),
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(bottom: 12.0),
            child: new Center(
              child: new InkWell(
                  child: new Text(
                    'HELP',
                    style: new TextStyle(fontSize: 22.0,color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/support');
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color(0x000000),
        body: new SafeArea(
          child: new Stack(
            children: <Widget>[
              _getBackground(),
              _getGradient(),
              _getLogin(context),
            ],
          ),
        )
    );
  }
}