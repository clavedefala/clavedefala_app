import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'motor.dart';

import 'package:flutter_tts/flutter_tts.dart';
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
            title: FittedBox(
              alignment: FractionalOffset(0.0, 0.5),
              fit: BoxFit.scaleDown,
              child: Text(
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

// Classe para criação de Widget que representa um widget.
class PhraseItem extends StatelessWidget {
  const PhraseItem(this.phrase, this.color, this.tagColumn);

  final String phrase;
  final int color;
  final _TagColumnState tagColumn;

  Widget _buildPhrase(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Center(
          child: Text(
            this.phrase,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontFamily: 'Catamaran',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Color(this.color),
      ),
      onTap: () {
        this.tagColumn._speak(this.phrase);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return _buildPhrase(context);
  }
}

// Classe para criação de Widget que representa um widget.
class SmallPhraseItem extends StatelessWidget {
  const SmallPhraseItem(this.phrase, this.color, this.tagColumn);

  final String phrase;
  final int color;
  final _TagColumnState tagColumn;

  Widget _buildPhrase(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: Center(
          child: Text(
            this.phrase,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'Catamaran',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Color(this.color),
      ),
      onTap: () {
        this.tagColumn._speak(this.phrase);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return _buildPhrase(context);
  }
}

class TagColumn extends StatefulWidget {
  @override
  _TagColumnState createState() => _TagColumnState();
}

enum TtsState { playing, stopped }

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
  bool speak = false;
  String chosenPhrase;

  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  initTts() async {
    flutterTts = new FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    await flutterTts.setLanguage("pt-BR");
  }

  initialize() {
    this.initTts();

    // TODO: Escrever aqui todas as tags existentes.
    this.tags = [
      Tag(
        "Saúde",
        Icons.local_hospital,
        0xFFC02F1D,
        [
          Tag("Hospital", Icons.local_hospital, 0xFF107896, null),
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
                  Tag("Hospital", Icons.local_hospital, 0xFF107896, null),
                  Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB,
                      null),
                  Tag("Clínica", Icons.local_hospital, 0xFFF26D21, null),
                  Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
                  Tag("Veterinário", Icons.pets, 0xFFC02F1D, null),
                ],
              ),
              Tag(
                "Compras",
                Icons.shopping_cart,
                0xFFA3B86C,
                [
                  Tag(
                    "Superfícies Comerciais",
                    Icons.local_mall,
                    0xFF107896,
                    [
                      Tag("Supermercado", Icons.shopping_cart, 0xFF1496BB,
                          null),
                      Tag("Mercado", Icons.shopping_cart, 0xFFA3B86C, null),
                      Tag("Minimercado", Icons.shopping_cart, 0xFFC02F1D, null)
                    ],
                  ),
                  Tag("Feira", Icons.local_activity, 0xFFC02F1D, null)
                ],
              ),
            ],
          ),
          Tag(
            "Táxi",
            Icons.local_taxi,
            0xFFEBC944,
            null,
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
        [
          Tag("Superfícies Comerciais", Icons.local_mall, 0xFF107896, null),
          Tag("Feira", Icons.local_activity, 0xFFC02F1D, null),
          Tag("Loja", Icons.shop, 0xFFA3B86C, null),
        ],
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
              Tag("Hospital", Icons.local_hospital, 0xFF107896, null),
              Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB, null),
              Tag("Clínica", Icons.local_hospital, 0xFFF26D21, null),
              Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
              Tag("Urgência", Icons.warning, 0xFFC02F1D, null),
              Tag("Veterinário", Icons.pets, 0xFFEBC944, null)
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
                      Tag("Hospital", Icons.local_hospital, 0xFF107896, null),
                      Tag("Centro de Saúde", Icons.local_hospital, 0xFF1496BB,
                          null),
                      Tag("Clínica", Icons.local_hospital, 0xFFF26D21, null),
                      Tag("Farmácia", Icons.local_pharmacy, 0xFFA3B86C, null),
                      Tag("Veterinário", Icons.pets, 0xFFC02F1D, null),
                    ],
                  ),
                ],
              ),
              Tag("Táxi", Icons.local_taxi, 0xFFEBC944, null),
            ],
          ),
          Tag(
            "Compras",
            Icons.shopping_cart,
            0xFFA3B86C,
            [
              Tag("Superfícies Comerciais", Icons.local_mall, 0xFF107896, null),
              Tag("Feira", Icons.local_activity, 0xFFC02F1D, null)
            ],
          ),
          Tag(
            "Viagem",
            Icons.directions,
            0xFFEBC944,
            [
              Tag("Minha Posição", Icons.person_pin_circle, 0xFF107896, null),
              Tag("Destino", Icons.pin_drop, 0xFFC02F1D, null)
            ],
          ),
          Tag(
            "Alimentação",
            Icons.fastfood,
            0xFF1496BB,
            [
              Tag("Café", Icons.local_cafe, 0xFFA3B86C, null),
              Tag(
                "Restauração",
                Icons.local_dining,
                0xFF107896,
                [
                  Tag("Alergia", Icons.check_box, 0xFFC02F1D, null),
                  Tag("Vegan", Icons.local_florist, 0xFF1496BB, null),
                ],
              ),
              Tag("Bar", Icons.local_bar, 0xFFC02F1D, null),
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
        this.motor.refresh(stringTags);
      });
    } else if (tags == null && tag != null) {
      setState(() {
        this.suggest = true;
        this.stringTags.add(tag.toString());
        this.motor.refresh(stringTags);
      });
    }
  }

  _goBack() {
    this._dontSpeak();
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
      this._dontSpeak();
      if (this.suggest == true) {
        this.suggest = false;
        this.stringTags.removeLast();
        setState(() {
          this.motor.refresh(this.stringTags);
        });
        return false;
      } else if (pastTags.isNotEmpty) {
        this.stringTags.removeLast();
        setState(() {
          this.tags = this.pastTags.last;
          this.motor.refresh(this.stringTags);
        });
        this.pastTags.removeLast();
        return false;
      }
      return true;
    } catch (e) {
      print("_goBack with error " + e.toString());
      return true;
    }
  }

  Future _speakTTS() async {
    var result = await flutterTts.speak(this.chosenPhrase);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stopTTS() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  _ttsSpeak() {
    print("TTS ON");
    this._speakTTS();
  }

  _ttsStop() {
    print("TTS STOPPED");
    this._stopTTS();
  }

  _speak(String phrase) {
    print(phrase);
    setState(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      this.chosenPhrase = phrase;
      this.speak = true;
    });
  }

  _dontSpeak() {
    print("dont");
    this._ttsStop();
    setState(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      this.chosenPhrase = null;
      this.speak = false;
    });
  }

  Widget _buildColumn() {
    if (speak == true) {
      return InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
          ),
          child: Center(
            child: Text(
              this.chosenPhrase,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontFamily: 'Catamaran',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () {
          this._ttsSpeak();
        },
      );
    } else if (suggest == true) {
      var phraseList = <Widget>[];
      int color = 0xFFFAFAFA;
      for (String phrase in this.motor.getPhrases()) {
        color = 0xFFFAFAFA;
        if (phraseList.length.isOdd) {
          color = 0xFFEEEEEE;
        }
        phraseList.add(PhraseItem(phrase, color, this));
      }
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
            child: Text(
              this
                  .stringTags
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", ""),
            ),
          ),
          Expanded(
            child: Dismissible(
              key: Key("suggest"),
              onDismissed: (direction) {
                setState(() {
                  this._goBack();
                });
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                key: Key("suggest"),
                children: phraseList,
              ),
            ),
          )
        ],
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
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
            child: Text(
              this
                  .stringTags
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", ""),
            ),
          ),
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
            child:
                SmallPhraseItem(this.motor.getPhrases()[0], 0xFFFAFAFA, this),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _buildColumn(),
        onWillPop: () =>
            _goBackButton().then((bool value) => Future<bool>.value(value)));
  }

  @override
  void initState() {
    super.initState();

    this.initialize();
  }
}
