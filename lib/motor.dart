import 'phrase.dart';

// Classe que define uma Frase.
// São escolhidas com base nas tags escolhidas.
class Motor {
  Motor();

  // As frases são criadas aqui.
  // TODO: Criar frases.
  List<Phrase> phrases = [
    // Transportes.
    Phrase("Pode me dizer se há autocarros?", ["Transportes", "Autocarro"]),
    Phrase("Qual é o Autocarro que vai para o Hospital?", ["Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Qual é o Autocarro que vai para o Centro de Saúde mais próximo?", ["Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Qual é o Autocarro que vai para a Farmácia mais próxima?", ["Transportes", "Autocarro", "Saúde", "Farmácia"]),
    Phrase("Qual é o Autocarro que vai para a Clínica mais próxima?", ["Transportes", "Autocarro", "Saúde", "Clínica"]),
    Phrase("Qual é o Autocarro que vai para o Veterinário mais próximo?", ["Transportes", "Autocarro", "Saúde", "Veterinário"]),
    Phrase("Qual é o Autocarro que vai para o Supermercado mais próximo?", ["Transportes", "Autocarro", "Compras", "Superfícies Comerciais", "Supermercado"]),
    Phrase("Qual é o Autocarro que vai para o Mercado mais próximo?", ["Transportes", "Autocarro", "Compras", "Superfícies Comerciais", "Mercado"]),
    Phrase("Qual é o Autocarro que vai para o Minimercado mais próximo?", ["Transportes", "Autocarro", "Compras", "Superfícies Comerciais", "Minimercado"]),
    Phrase("Qual é o Autocarro que vai para a Feira mais próxima?", ["Transportes", "Autocarro", "Compras", "Feira"]),
    // Direções.
    Phrase("Onde é o Hospital mais próximo?", ["Direções", "Saúde", "Hospital"]),
    Phrase("Onde é o Centro de Saúde mais próximo?", ["Direções", "Saúde", "Centro de Saúde"]),
    Phrase("Onde é a Farmácia mais próxima?", ["Direções", "Saúde", "Farmácia"]),
    Phrase("Onde é a Clínica mais próxima?", ["Direções", "Saúde", "Clínica"]),
    Phrase("Onde é o Veterinário mais próximo?", ["Direções", "Saúde", "Veterinário"]),
    Phrase("Onde são as Urgências mais próximas?", ["Direções", "Saúde", "Urgência"]),
    Phrase("Onde é a paragem de Autocarro mais próxima?", ["Direções", "Transportes", "Autocarro"]),
    Phrase("Onde apanho o Autocarro para o Hospital?", ["Direções", "Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Onde apanho o Autocarro para o Centro de Saúde?", ["Direções", "Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Onde apanho o Autocarro para a Farmácia?", ["Direções", "Transportes", "Autocarro", "Saúde", "Farmácia"]),
    Phrase("Onde apanho o Autocarro para a Clínica?", ["Direções", "Transportes", "Autocarro", "Saúde", "Clínica"]),
    Phrase("Onde apanho o Autocarro para o Veterinário?", ["Direções", "Transportes", "Autocarro", "Saúde", "Veterinário"]),
    Phrase("Onde é a praça de Táxis mais próxima?", ["Direções", "Transportes", "Táxi"]),
    Phrase("Pode me dizer se existem táxis por perto?", ["Direções", "Transportes", "Táxi"]),
    Phrase("Onde é a Superfície Comercial mais próxima?", ["Direções", "Compras", "Superfícies Comerciais"]),
    Phrase("Onde é a Feira Local?", ["Direções", "Compras", "Feira"]),
    Phrase("Onde é que eu estou?", ["Direções", "Viagem", "Minha Posição"]),
    Phrase("Pode me dizer como chego a este sítio?", ["Direções", "Viagem", "Destino"]), // TODO: Estudar possibilidade de integrar com perfil.
    Phrase("Onde é o Café mais próximo?", ["Direções", "Alimentação", "Café"]),
    Phrase("Onde é o Restaurante mais próximo?", ["Direções", "Alimentação", "Restauração"]),
    Phrase("Onde é o Bar mais próximo?", ["Direções", "Alimentação", "Bar"]),
    // Alimentação.
    Phrase("Isto contém estes alergéneos?", ["Alimentação", "Restauração", "Alergia"]), // TODO: Integrar com Alergias do perfil.
    Phrase("Sou vegan, posso consumir este prato?", ["Alimentação", "Restauração", "Vegan"]),
    Phrase("Sou vegetariano, posso consumir este prato?", ["Alimentação", "Restauração", "Vegan"]),
    Phrase("O que é que me recomenda?", ["Alimentação", "Restauração"]),
    Phrase("Existem mesas disponíveis?", ["Alimentação", "Restauração"]),
    Phrase("Gostava de marcar uma reserva.", ["Alimentação", "Restauração"]),
    // Compras.
    Phrase("Qual é o preço deste produto?", ["Compras", "Superfícies Comerciais"]),
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
