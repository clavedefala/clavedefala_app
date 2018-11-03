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
    int result = tags.length;
    if (result < this.tags.length) {
      result = this.tags.length;
    }
    int length = result;

    for (String tag in tags) {
      if (this.tags.contains(tag)) {
        result--;
      }
    }
    return (result/length * 100000).round();
  }

  @override
  String toString() {
    return this.phrase;
  }
}