import 'package:flutter/material.dart';
import 'clave_text_field.dart';
import 'motor.dart';

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
  static Motor motor = new Motor();
  String _nome = "";

  TagColumn tagColumn = TagColumn(motor);

  _MyHomePageState() {
    motor.urgentReadValue("{nome}").then((val) => setState(() {
          _nome = val ?? "Clica para adicionar o teu nome";
        }));
  }

  var drawerButtonTextStyle = TextStyle(
    fontFamily: "Catamaran",
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  var drawerHeaderTextStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  void _showDialog(String key, String title) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(
              title,
              textAlign: TextAlign.center,
              style: drawerButtonTextStyle,
            ),
            content: Text(
              key.replaceAllMapped(new RegExp(r'{\w+}', caseSensitive: false),
                  (Match m) {
                print("match:" + m.group(0));
                String value = this.tagColumn.motor.readValue(m.group(0));
                print("value:" + value);
                return value;
              }),
              style: drawerButtonTextStyle,
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FloatingActionButton(
                    elevation: 0.0,
                    onPressed: () {
                      Navigator.pop(context);
                      _editDialog(key, title);
                    },
                    backgroundColor: Color(0xFFF50057),
                    child: Icon(Icons.edit),
                  ),
                  FloatingActionButton(
                    elevation: 0.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.blue[900],
                    child: Icon(Icons.close),
                  ),
                ],
              )
            ],
          ),
    );
  }

  void _editDialog(String key, String title) {
    String initialValue = motor.readValue(key);
    String newValue = initialValue;
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(
              title,
              textAlign: TextAlign.center,
              style: drawerButtonTextStyle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClaveTextField(
                  initialValue: initialValue,
                  autofocus: true,
                  onChanged: (String newVal) {
                    if (newVal != null) {
                      newValue = newVal;
                    }
                  },
                )
              ],
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FloatingActionButton(
                    elevation: 0.0,
                    onPressed: () {
                      print("key:" + key);
                      print("initial:" + initialValue);
                      motor.addNewItem(key, initialValue);
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.red,
                    child: Icon(Icons.restore),
                  ),
                  FloatingActionButton(
                    elevation: 0.0,
                    onPressed: () {
                      print("key:" + key);
                      print("new:" + newValue);
                      if (newValue != null) {
                        motor.addNewItem(key, newValue);
                        if (key == "{nome}") {
                          this._nome = newValue;
                          print("nome alterado pra " + newValue);
                        }
                      }
                      setState(() {});
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.green,
                    child: Icon(Icons.save),
                  ),
                ],
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: this.tagColumn,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
                child: DrawerHeader(
                  child: Text(_nome, style: drawerHeaderTextStyle),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                  ),
                ),
                onTap: () => _showDialog("{nome}", "Nome"),
                onLongPress: () {
                  _editDialog("{nome}", "Nome");
                }),
            ListTile(
                title: Text("Número de Identificação Fiscal",
                    style: drawerButtonTextStyle),
                onTap: () => _showDialog("{NIF}", "Número de Identificação Fiscal"),
                onLongPress: () {
                  _editDialog("{NIF}", "Número de Identificação Fiscal");
                }),
            ListTile(
                title: Text("Idade", style: drawerButtonTextStyle),
                onTap: () => _showDialog("{idade}", "Idade"),
                onLongPress: () {
                  _editDialog("{idade}", "Idade");
                }),
            ListTile(
                title:
                    Text("Número de Telemóvel", style: drawerButtonTextStyle),
                onTap: () => _showDialog("{telemovel}", "Número de Telemóvel"),
                onLongPress: () {
                  _editDialog("{telemovel}", "Número de Telemóvel");
                }),
            ListTile(
                title: Text("Alergias", style: drawerButtonTextStyle),
                onTap: () => _showDialog("{alergias}", "Alergias"),
                onLongPress: () {
                  _editDialog("{alergias}", "Alergias");
                }),
            ListTile(
                title: Text("Morada", style: drawerButtonTextStyle),
                onTap: () => _showDialog("{morada}", "Morada"),
                onLongPress: () {
                  _editDialog("{morada}", "Morada");
                }),
            ListTile(
                title: Text("Email", style: drawerButtonTextStyle),
                onTap: () => _showDialog("{email}", "Email"),
                onLongPress: () {
                  _editDialog("{email}", "Email");
                }),
          ],
        ),
      ),
    );
  }
}
