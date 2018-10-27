import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          ))),
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

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final int color;
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTile(Entry root) {
    return Container(
      child: Center(
        child: ListTile(
          leading: Icon(
            root.icon,
            color: Colors.white,
          ),
          title: Text(
            root.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Catamaran',
            ),
          ),
        ),
      ),
      color: Color(root.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTile(this.entry);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Entry> data = <Entry>[
    Entry(
      'Transportes',
      Icons.directions_bus,
      0xff9c27b0,
    ),
    Entry(
      'Compras',
      Icons.shopping_cart,
      0xff2196f3,
    ),
    Entry(
      'Localizações',
      Icons.map,
      0xff4caf50,
    ),
    Entry(
      'Saúde',
      Icons.local_hospital,
      0xfff44336,
    ),
    Entry(
      'Direitos',
      Icons.contact_mail,
      0xff009688,
    ),
    Entry(
      'Bolo de chocolate',
      Icons.cake,
      0xff795548,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: EntryItem(data[0])),
                Expanded(child: EntryItem(data[1])),
                Expanded(child: EntryItem(data[2])),
                Expanded(child: EntryItem(data[3])),
                Expanded(child: EntryItem(data[4])),
                Expanded(child: EntryItem(data[5])),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Uma frase sugerida é mostrada aqui e pode ser aceite com um clique!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
