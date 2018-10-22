import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Clave de Fala',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Esboço Clave de Fala'),
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
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Entry> data = <Entry>[
    Entry(
      'Saúde',
      <Entry>[
        Entry(
          'Farmácia',
          <Entry>[
            Entry('Quero levantar esta receita, por favor.'),
            Entry('Tem aspirina?'),
            Entry('Tem algum medicamento para a tosse?'),
          ],
        ),
        Entry('Hospital'),
        Entry('Médico'),
      ],
    ),
    Entry(
      'Compras',
      <Entry>[
        Entry('Quero fatura com NIF, por favor.'),
        Entry('O meu NIF é 121291991.'),
      ],
    ),
    Entry(
      'Localizações',
      <Entry>[
        Entry('Onde estou?'),
        Entry(
          'Onde é...',
          <Entry>[
            Entry('Onde é a Associação Portuguesa de Limitados de Voz?'),
            Entry('Onde é a Biblioteca mais próxima?'),
            Entry('Onde é o Multibanco mais próximo?'),
            Entry('Onde é a Farmácia mais próxima?'),
          ],
        ),
      ],
    ),
    Entry(
      'Entre outros...',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
