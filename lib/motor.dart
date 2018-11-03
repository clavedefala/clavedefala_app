import 'phrase.dart';

// Classe que define uma Frase.
// São escolhidas com base nas tags escolhidas.
class Motor {
  Motor();

  // As frases são criadas aqui.
  // TODO: Criar frases.
  List<Phrase> phrases = [
    // Transportes.
    Phrase("Há autocarros?", ["Transportes", "Autocarro"]),
    Phrase("Qual é o Autocarro que vai para o Hospital?", ["Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Qual é o Autocarro que vai para o Centro de Saúde?", ["Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Qual é o Autocarro que vai para a Farmácia?", ["Transportes", "Autocarro", "Saúde", "Farmácia"]),
    // Direções.
    Phrase("Onde é o Hospital mais próximo?", ["Direções", "Saúde", "Hospital"]),
    Phrase("Onde é o Centro de Saúde mais próximo?", ["Direções", "Saúde", "Centro de Saúde"]),
    Phrase("Onde é a Farmácia mais próxima?", ["Direções", "Saúde", "Farmácia"]),
    Phrase("Onde são as Urgências mais próximas?", ["Direções", "Saúde", "Urgência"]),
    Phrase("Onde é a paragem de Autocarro mais próxima?", ["Direções", "Transportes", "Autocarro"]),
    Phrase("Onde apanho o Autocarro para o Hospital?", ["Direções", "Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Onde apanho o Autocarro para o Centro de Saúde?", ["Direções", "Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Onde apanho o Autocarro para a Farmácia?", ["Direções", "Transportes", "Autocarro", "Saúde", "Farmácia"]),
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
      result.add(this.phrases[i].toString());
    }

    return result;
  }
}
