import 'tag.dart';

// Classe que define uma Frase.
// São escolhidas com base nas tags escolhidas.
class Phrase {
  Phrase(this.phrase, this.tags);

  final String phrase;
  final List<String> tags;
  int timesUsed = 0;

  used() {
    this.timesUsed++;
  }

  int comp(List<String> tags) {
    int result = 0;
    for (String tag in tags) {
      if (this.tags.contains(tag)) {
        result++;
      }
    }
    return result;
  }

  @override
  String toString() {
    return this.phrase;
  }
}

// Criar uma frase.
final frase = Phrase("Onde é o Hospital mais próximo?", ["Localizações", "Saúde", "Hospital"]);