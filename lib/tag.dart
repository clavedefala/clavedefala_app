import 'package:flutter/material.dart';
import 'motor.dart';
import 'dart:async';

// Classe que define uma tag.
class Tag {
  Tag(this.title, this.icon, this.color, this.subtags);

  final String title;
  final IconData icon;
  final int color;
  final List<Tag> subtags;

  @override
  String toString() {
    return this.title;
  }
}

// Classe para criação de Widget que representa uma tag.
class TagItem extends StatelessWidget {
  const TagItem(this.tag, this.tagColumn);

  final Tag tag;
  final _TagColumnState tagColumn;

  Widget _buildTag(BuildContext context) {
    return InkWell(
      child: Container(
        child: Center(
          child: ListTile(
            leading: Icon(
              this.tag.icon,
              color: Colors.white,
              size: 50.0,
            ),
            title: Text(
              this.tag.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontFamily: 'Catamaran',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        color: Color(this.tag.color),
      ),
      onTap: () {
        this.tagColumn.refresh(this.tag.subtags, this.tag);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return _buildTag(context);
  }
}

class TagColumn extends StatefulWidget {
  @override
  _TagColumnState createState() => _TagColumnState();
}

// Classe que representa a coluna que mostra as tags atuais.
class _TagColumnState extends State<TagColumn> {
  // Lista atual de tags.
  List<Tag> tags;

  // Histórico de tags.
  List<List<Tag>> pastTags = [];

  // Strings das tags escolhidas so far.
  List<String> stringTags = [];

  Motor motor;

  bool suggest = false;

  initialize() {
    // TODO: Escrever aqui todas as tags existentes.
    this.tags = [
      Tag(
        "Saúde",
        Icons.local_hospital,
        0xFFC02F1D,
        [
          Tag("Hospital", Icons.local_hospital, 0xFF1287A8, null),
          Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB, null),
          Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
          Tag("Urgência", Icons.warning, 0xFFC02F1D, null)
        ],
      ),
      Tag(
        "Transportes",
        Icons.train,
        0xFF0D3D56,
        [
          Tag(
            "Autocarro",
            Icons.directions_bus,
            0xFF1496BB,
            [
              Tag(
                "Saúde",
                Icons.local_hospital,
                0xFFC02F1D,
                [
                  Tag("Hospital", Icons.local_hospital, 0xFF1287A8, null),
                  Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB,
                      null),
                  Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
                ],
              ),
            ],
          ),
        ],
      ),
      Tag(
        "Direitos",
        Icons.feedback,
        0xFFF26D21,
        null,
      ),
      Tag(
        "Alimentação",
        Icons.fastfood,
        0xFF1496BB,
        null,
      ),
      Tag(
        "Compras",
        Icons.shopping_cart,
        0xFFA3B86C,
        null,
      ),
      Tag(
        "Direções",
        Icons.directions,
        0xFFEBC944,
        [
          Tag(
            "Saúde",
            Icons.local_hospital,
            0xFFC02F1D,
            [
              Tag("Hospital", Icons.local_hospital, 0xFF1287A8, null),
              Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB, null),
              Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
              Tag("Urgência", Icons.warning, 0xFFC02F1D, null)
            ],
          ),
          Tag(
            "Transportes",
            Icons.train,
            0xFF0D3D56,
            [
              Tag(
                "Autocarro",
                Icons.directions_bus,
                0xFF1496BB,
                [
                  Tag(
                    "Saúde",
                    Icons.local_hospital,
                    0xFFC02F1D,
                    [
                      Tag("Hospital", Icons.local_hospital, 0xFF1287A8, null),
                      Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB,
                          null),
                      Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
    this.pastTags = [];
    this.stringTags = [];
    this.motor = Motor();
  }

  void refresh(List<Tag> tags, Tag tag) {
    if (tags != null && tag != null) {
      setState(() {
        this.stringTags.add(tag.toString());
        this.pastTags.add(this.tags);
        this.tags = tags;
      });
    } else if (tags == null && tag != null) {
      setState(() {
        this.suggest = true;
        this.stringTags.add(tag.toString());
      });
    }
    this.motor.refresh(stringTags);
  }

  _goBack() {
    if (this.suggest == true) {
      this.suggest = false;
      this.stringTags.removeLast();
      setState(() {
        this.motor.refresh(this.stringTags);
      });
    } else if (pastTags.isNotEmpty) {
      this.stringTags.removeLast();
      setState(() {
        this.tags = this.pastTags.last;
        this.motor.refresh(this.stringTags);
      });
      this.pastTags.removeLast();
    }

    print("_goBack");
  }

  Future<bool> _goBackButton() async {
    try {
      if (this.suggest == true) {
        this.suggest = false;
        this.stringTags.removeLast();
        setState(() {
          this.motor.refresh(this.stringTags);
        });
      } else if (pastTags.isNotEmpty) {
        this.stringTags.removeLast();
        setState(() {
          this.tags = this.pastTags.last;
          this.motor.refresh(this.stringTags);
        });
        this.pastTags.removeLast();
      }
      print("_goBack successful");
      return false;
    } catch (e) {
      print("_goBack with error " + e.toString());
      return false;
    }
  }

  Widget _buildColumn() {
    if (suggest == true) {
      var phraseList = <Widget>[];
      int color = 0xFFFAFAFA;
      for (String phrase in this.motor.getPhrases()) {
        color = 0xFFFAFAFA;
        if (phraseList.length.isOdd) {
          color = 0xFFEEEEEE;
        }
        phraseList.add(
          Container(
            padding: EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 8.0),
            color: Color(color),
            child: Center(
              child: Text(
                phrase,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        );
      }
      return Dismissible(
        key: Key("suggest"),
        onDismissed: (direction) {
          setState(() {
            this._goBack();
          });
        },
        child: ListView(key: Key("suggest"), children: phraseList),
      );
    } else {
      var tagItems = <Widget>[];

      for (Tag tag in this.tags) {
        tagItems.add(Expanded(
          child: TagItem(tag, this),
        ));
      }

      Widget column = Column(
        key: Key(this.tags.last.toString()),
        children: tagItems,
      );

      if (this.pastTags.isEmpty) {
        return column;
      }

      return Column(
        children: <Widget>[
          Expanded(
            child: Dismissible(
              key: Key(this.tags.last.toString()),
              onDismissed: (direction) {
                setState(() {
                  this._goBack();
                });
              },
              child: column,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Text(
              this.motor.getPhrases()[0],
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: _buildColumn(), onWillPop: () => _goBackButton().then((bool value) => Future<bool>.value(value)));
  }

  @override
  void initState() {
    super.initState();

    this.initialize();
  }
}
