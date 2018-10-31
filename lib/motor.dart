import 'phrase.dart';

// Classe que define uma Frase.
// São escolhidas com base nas tags escolhidas.
class Motor {
  Motor();

  // As frases são criadas aqui.
  // TODO: Criar frases.
  List<Phrase> phrases = [
    Phrase("Primeiro", ["Localizações", "Saúde", "Hospital"]),
    Phrase("Segundo", ["Saúde", "Hospital"]),
    Phrase("Terceiro", ["Hospital"]),
    Phrase("Te?", ["Saúde", "Hostal"]),

  ];

  refresh(List<String> tags) {
    this.phrases.sort((phrase1, phrase2) => phrase1.comp(tags) - phrase2.comp(tags));
    return;
  }

  List<String> getPhrases() {
    List<String> result = [];
    int len = 20;

    if (this.phrases.length < 20) {
      len = this.phrases.length;
    }

    for (var i = 0; i < len; i++) {
      result.insert(0, this.phrases[i].toString());
    }

    return result;
  }
}
