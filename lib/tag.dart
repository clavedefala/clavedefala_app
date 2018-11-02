import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

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

  initialize() {
    // TODO: Escrever aqui todas as tags existentes.
    this.tags = [
      Tag(
        "Saúde",
        Icons.local_hospital,
        0xFFC02F1D,
        [
          Tag(
            "Hospital",
            Icons.local_hospital,
            0xFF1287A8,
            null,
          ),
          Tag(
            "Centro de Saúde",
            Icons.local_hospital,
            0xFF1496BB,
            null,
          ),
          Tag(
            "Farmácia",
            Icons.local_pharmacy,
            0xFFA3B86C,
            [
              Tag(
                "Vamos mais fundo.",
                Icons.local_pharmacy,
                0xFFA3B86C,
                [
                  Tag(
                    "Vamos ainda mais fundo.",
                    Icons.local_pharmacy,
                    0xFFA3B86C,
                    [
                      Tag(
                        "Já chega. :)",
                        Icons.local_pharmacy,
                        0xFFA3B86C,
                        null,
                      ),
                    ],
                  ),
                  Tag(
                    "Aqui não há nada.",
                    Icons.local_pharmacy,
                    0xFFC02F1D,
                    null,
                  ),
                ],
              ),
              Tag(
                "Aqui não há nada.",
                Icons.local_pharmacy,
                0xFFC02F1D,
                null,
              ),
              Tag(
                "Nem aqui.",
                Icons.local_pharmacy,
                0xFF0D3D56,
                null,
              ),
            ],
          ),
          Tag(
            "Urgência",
            Icons.warning,
            0xFFC02F1D,
            null,
          )
        ],
      ),
      Tag(
        "Transportes",
        Icons.train,
        0xFF0D3D56,
        null,
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
        null,
      ),
    ];
    this.pastTags = [];
    this.stringTags = [];
  }

  void refresh(List<Tag> tags, Tag tag) {
    if (tags != null && tags != null) {
      setState(() {
        this.stringTags.add(tag.toString());
        this.pastTags.add(this.tags);
        this.tags = tags;
      });
    }
  }

  _goBack() {
    if (pastTags.isNotEmpty) {
      stringTags.removeLast();
      setState(() {
        this.tags = this.pastTags.last;
      });
      pastTags.removeLast();
    }

    print("_goBack");
  }

  Widget _buildColumn() {
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

    return Dismissible(
      key: Key(this.tags.last.toString()),
      onDismissed: (direction) {
        setState(() {
          this._goBack();
        });
      },
      child: column,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildColumn();
  }

  @override
  void initState() {
    super.initState();

    this.initialize();
  }
}
