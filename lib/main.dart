import 'package:flutter/material.dart';

// Import de ficheiros nossos.
import 'tag.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Clave de Fala',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Color(0xFFFAFAFA),
        accentColor: Colors.blue[900],
        backgroundColor: Color(0xFFFAFAFA),
        fontFamily: 'Montserrat',
        primaryTextTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
            fontSize: 32.0,
          ),
        ),
      ),
      home: new MyHomePage(title: 'Clave de Fala'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TagColumn tagColumn = TagColumn();

  var drawerButtonTextStyle = TextStyle(
    fontFamily: "Catamaran",
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: this.tagColumn,
    );
  }
}
