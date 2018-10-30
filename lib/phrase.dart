import 'tag.dart';

// Classe que define uma Frase.
// São escolhidas com base nas tags escolhidas.
class Phrase {
  Phrase(this.start, this.end, this.tags, this.words);

  final String start;
  final String end;
  final List<String> tags;
  final List<String> words;
  int timesUsed = 0;

  used() {
    this.timesUsed++;
  }
}

// Criar uma frase.
final frase = Phrase("Onde é", "mais próximo?", ["Localizações", "Saúde"], ["Hospital", "Centro de Saúde", "Médico"]);