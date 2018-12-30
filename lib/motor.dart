import 'phrase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Motor é responsável por sortear as frases em tempo real.
// Deve devolver as 20 frases mais prováveis sempre que pedido.
class Motor {
  Motor() {
    _readAll();
  }

  final _storage = new FlutterSecureStorage();
  Map<String, String> _items = new Map();

  // As frases são colocadas aqui.
  List<Phrase> phrases = [
    //Saúde
    Phrase("Chamo-me {nome}.", ["Saúde", "Hospital"]),
    Phrase("Chamo-me {nome}.", ["Saúde", "Clínica"]),
    Phrase("Chamo-me {nome}.", ["Saúde", "Dentista"]),
    Phrase("Chamo-me {nome}.", ["Saúde", "Centro de Saúde"]),
    Phrase("Chamo-me {nome}.", ["Saúde", "Urgências"]),
    Phrase("Tem parceria com ADSE?", ["Saúde", "Hospital"]),
    Phrase("Tem parceria com ADSE?", ["Saúde", "Clínica"]),
    Phrase("Tem parceria com ADSE?", ["Saúde", "Dentista"]),
    Phrase("Quanto custa uma consulta?", ["Saúde", "Hospital"]),
    Phrase("Quanto custa uma consulta?", ["Saúde", "Centro de Saúde"]),
    Phrase("Quanto custa uma consulta?", ["Saúde", "Clínica"]),
    Phrase("Quanto custa uma consulta?", ["Saúde", "Dentista"]),
    Phrase("Quanto custa uma consulta?", ["Saúde", "Veterinário"]),
    Phrase("Gostaria de marcar uma consulta.", ["Saúde", "Hospital"]),
    Phrase("Gostaria de marcar uma consulta.", ["Saúde", "Clínica"]),
    Phrase("Gostaria de marcar uma consulta.", ["Saúde", "Centro de Saúde"]),
    Phrase("Gostaria de marcar uma consulta.", ["Saúde", "Veterinário"]),
    Phrase("Gostaria de marcar uma consulta.", ["Saúde", "Dentista"]),
    Phrase("Estou com dores na zona X.", ["Saúde", "Urgências"]),
    Phrase("Estou com dores na zona X.", ["Saúde", "Hospital"]),
    Phrase("Estou com dores na zona X.", ["Saúde", "Centro de Saúde"]),
    Phrase("Estou com dores na zona X.", ["Saúde", "Dentista"]),
    Phrase("Estou com dores na zona X.", ["Saúde", "Clínica"]),
    Phrase("O animal está com dores na zona X.", ["Saúde", "Veterinário"]),
    Phrase("Tem parceria com o Seguro de Saúde X?", ["Saúde", "Hospital"]),
    Phrase("Tem parceria com o Seguro de Saúde X?", ["Saúde", "Clínica"]),
    Phrase(
        "Tem parceria com o Seguro de Saúde X?", ["Saúde", "Centro de Saúde"]),
    Phrase("Tem parceria com o Seguro de Saúde X?", ["Saúde", "Dentista"]),
    Phrase("Tem parceria com o Seguro de Saúde X?", ["Saúde", "Veterinário"]),
    Phrase("Tenho consulta marcada.", ["Saúde", "Hospital"]),
    Phrase("Tenho consulta marcada.", ["Saúde", "Clínica"]),
    Phrase("Tenho consulta marcada.", ["Saúde", "Centro de Saúde"]),
    Phrase("Tenho consulta marcada.", ["Saúde", "Dentista"]),
    Phrase("Tenho consulta marcada.", ["Saúde", "Veterinário"]),
    Phrase("Estou isento de taxas moderadoras.", ["Saúde", "Hospital"]),
    Phrase("Estou isento de taxas moderadoras.", ["Saúde", "Centro de Saúde"]),
    Phrase("Estou isento de taxas moderadoras.", ["Saúde", "Urgência"]),

    // Transportes.
    Phrase("Pode me dizer se há autocarros?", ["Transportes", "Autocarro"]),
    Phrase("Qual é o Autocarro que vai para o Hospital?",
        ["Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Qual é o Autocarro que vai para o Centro de Saúde mais próximo?",
        ["Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Qual é o Autocarro que vai para a Farmácia mais próxima?",
        ["Transportes", "Autocarro", "Saúde", "Farmácia"]),
    Phrase("Qual é o Autocarro que vai para a Clínica mais próxima?",
        ["Transportes", "Autocarro", "Saúde", "Clínica"]),
    Phrase("Qual é o Autocarro que vai para o Veterinário mais próximo?",
        ["Transportes", "Autocarro", "Saúde", "Veterinário"]),
    Phrase("Qual é o Autocarro que vai para o Centro Comercial mais próximo?",
        ["Transportes", "Autocarro", "Compras", "Superfícies Comerciais"]),
    Phrase("Qual é o Autocarro que vai para o Hipermercado mais próximo?", [
      "Transportes",
      "Autocarro",
      "Compras",
      "Superfícies Comerciais",
      "Mercado"
    ]),
    Phrase("Qual é o Autocarro que vai para o Supermercado mais próximo?", [
      "Transportes",
      "Autocarro",
      "Compras",
      "Superfícies Comerciais",
      "Mercado"
    ]),
    Phrase("Qual é o Autocarro que vai para o Mercado mais próximo?", [
      "Transportes",
      "Autocarro",
      "Compras",
      "Superfícies Comerciais",
      "Mercado"
    ]),
    Phrase("Qual é o Autocarro que vai para o Minimercado mais próximo?", [
      "Transportes",
      "Autocarro",
      "Compras",
      "Superfícies Comerciais",
      "Mercado"
    ]),
    Phrase("Qual é o Autocarro que vai para a Feira mais próxima?",
        ["Transportes", "Autocarro", "Compras", "Feira"]),

    // Direitos.
    Phrase("Tenho atendimento prioritário.", ["Direitos"]),
    Phrase("Sou isento de taxas moderadoras.", ["Direitos"]),
    Phrase("Tenho direito a desconto por deficiência.", ["Direitos"]),

    // Alimentação.
    Phrase("Pode tirar {alergias} do prato?", ["Alimentação", "Restauração", "Alergia"]),
    Phrase("Pode tirar {alergias} do prato?",
        ["Alimentação", "Restauração", "Informações"]),
    Phrase("Isto contém um dos seguintes: {alergias}?",
        ["Alimentação", "Restauração", "Alergia"]),
    Phrase("Sou intolerante a {alergias}.",
        ["Alimentação", "Restauração", "Alergia"]),
    Phrase("Sou vegan, posso consumir este prato?",
        ["Alimentação", "Restauração", "Vegan"]),
    Phrase("Sou vegetariano, posso consumir este prato?",
        ["Alimentação", "Restauração", "Vegan"]),
    Phrase("Qual é o prato do dia?",
        ["Alimentação", "Restauração", "Informações"]),
    Phrase("O que é que me recomenda?",
        ["Alimentação", "Restauração", "Informações"]),
    Phrase("Existem mesas disponíveis?",
        ["Alimentação", "Restauração", "Informações"]),
    Phrase("Gostava de marcar uma reserva.", ["Alimentação", "Restauração"]),
    Phrase("Gostava de marcar uma reserva.",
        ["Alimentação", "Restauração", "Informações"]),
    Phrase("Quero a conta, se faz favor.",
        ["Alimentação", "Restauração", "Pagamento"]),
    Phrase("Aceitam Multibanco?", ["Alimentação", "Restauração", "Pagamento"]),
    Phrase("Aceitam Cartão de Alimentação?",
        ["Alimentação", "Restauração", "Pagamento"]),

    // Compras.
    Phrase("Aceitam Multibanco?", ["Compras", "Pagamento"]),
    Phrase("Aceitam Cartão de Alimentação?", ["Compras", "Pagamento"]),
    Phrase("Quero fatura com Número de Identificação Fiscal (NIF).",
        ["Compras", "Pagamento"]),
    Phrase("Este produto tem desconto?", ["Compras", "Informações", "Preço"]),
    Phrase(
        "Qual é o preço deste produto?", ["Compras", "Informações", "Preço"]),
    Phrase("Tem este produto em vermelho?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em azul?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em verde?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em amarelo?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em branco?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em preto?", ["Compras", "Informações", "Cor"]),
    Phrase(
        "Tem este produto em cor-de-rosa?", ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em cor-de-laranja?",
        ["Compras", "Informações", "Cor"]),
    Phrase("Tem este produto em roxo?", ["Compras", "Informações", "Cor"]),
    Phrase("Quero trocar este produto.",
        ["Compras", "Informações", "Trocas e Devoluções"]),
    Phrase("Quero devolver este produto.",
        ["Compras", "Informações", "Trocas e Devoluções"]),
    Phrase(
        "O produto X está disponível?", ["Compras", "Informações", "Produto"]),
    Phrase("Gostava de encomendar o produto X.",
        ["Compras", "Informações", "Produto"]),
    Phrase("O meu produto está avariado. Queria pôr a arranjar.",
        ["Compras", "Informações", "Produto"]),

    // Direções.
    Phrase(
        "Onde é o Hospital mais próximo?", ["Direções", "Saúde", "Hospital"]),
    Phrase("Onde é o Hospital Pediátrico mais próximo?",
        ["Direções", "Saúde", "Hospital"]),
    Phrase("Onde é o Centro de Saúde mais próximo?",
        ["Direções", "Saúde", "Centro de Saúde"]),
    Phrase(
        "Onde é a Farmácia mais próxima?", ["Direções", "Saúde", "Farmácia"]),
    Phrase("Onde é a Clínica mais próxima?", ["Direções", "Saúde", "Clínica"]),
    Phrase("Onde é o Veterinário mais próximo?",
        ["Direções", "Saúde", "Veterinário"]),
    Phrase("Onde são as Urgências mais próximas?",
        ["Direções", "Saúde", "Urgência"]),
    Phrase("Onde é a paragem de Autocarro mais próxima?",
        ["Direções", "Transportes", "Autocarro"]),
    Phrase("Onde apanho o Autocarro para o Hospital?",
        ["Direções", "Transportes", "Autocarro", "Saúde", "Hospital"]),
    Phrase("Onde apanho o Autocarro para o Centro de Saúde?",
        ["Direções", "Transportes", "Autocarro", "Saúde", "Centro de Saúde"]),
    Phrase("Onde apanho o Autocarro para a Farmácia?",
        ["Direções", "Transportes", "Autocarro", "Saúde", "Farmácia"]),
    Phrase("Onde apanho o Autocarro para a Clínica?",
        ["Direções", "Transportes", "Autocarro", "Saúde", "Clínica"]),
    Phrase("Onde apanho o Autocarro para o Veterinário?",
        ["Direções", "Transportes", "Autocarro", "Saúde", "Veterinário"]),
    Phrase("Onde é a praça de Táxis mais próxima?",
        ["Direções", "Transportes", "Táxi"]),
    Phrase("Pode me dizer se existem táxis por perto?",
        ["Direções", "Transportes", "Táxi"]),
    Phrase("Onde é a Superfície Comercial mais próxima?",
        ["Direções", "Compras", "Superfícies Comerciais"]),
    Phrase("Onde é a Loja mais próxima?",
        ["Direções", "Compras", "Superfícies Comerciais"]),
    Phrase("Onde é a Feira Local?", ["Direções", "Compras", "Feira"]),
    Phrase("Onde é que eu estou?", ["Direções", "Viagem", "Minha Posição"]),
    Phrase("Pode me dizer como chego a este sítio?",
        ["Direções", "Viagem", "Destino"]),
    Phrase("Onde é o Café mais próximo?", ["Direções", "Alimentação", "Café"]),
    Phrase("Onde é o Restaurante mais próximo?",
        ["Direções", "Alimentação", "Restauração"]),
    Phrase("Onde é o Bar mais próximo?", ["Direções", "Alimentação", "Bar"]),
    Phrase("Onde é a casa de banho mais próxima?", ["Direções", "Higiene"]),
  ];

  refresh(List<String> tags) {
    this
        .phrases
        .sort((phrase1, phrase2) => phrase1.comp(tags) - phrase2.comp(tags));
    return;
  }

  List<String> getPhrases() {
    List<String> result = [];
    int len = 20;

    if (this.phrases.length < 20) {
      len = this.phrases.length;
    }

    for (var i = 0; i < len && i < this.phrases.length; i++) {
      if (result.contains(this.phrases[i].toString())) {
        len++;
      } else {
        result.add(this.phrases[i].toString());
      }
    }

    return result;
  }

  // Valores do Perfil
  Future<Null> _readAll() async {
    final all = await _storage.readAll();
    _items.addAll(all);
    return _readPhrases();
  }

  void _deleteAll() async {
    await _storage.deleteAll();
    _readAll();
  }

  void addNewItem(String key, String value) async {
    await _storage.write(key: key, value: value);
    _items[key] = value;
    _readAll();
  }

  Future<String> urgentReadValue(String key) async {
    return await _storage.read(key: key);
  }

  String readValue(String key) {
    return this._items[key] ?? key; // FIXME: O que fazer quando o utilizador nunca chegou a inserir este valor?
  }

  // Frases Personalizadas
  void _readPhrases() {
    String value = this._items["{phrases}"] ?? "";

    print("Foi lido de _items[{phrases}]:" + value);

    RegExp expPhrases = new RegExp(r"{.*?}");
    Iterable<Match> phrases = expPhrases.allMatches(value);

    List<String> tmp;
    Phrase newPhrase;

    for (Match phrase in phrases) {
      tmp = phrase.group(0).split("|");
      newPhrase = Phrase(tmp[0].replaceFirst("{", ""), tmp[1].replaceAll("}", "").split(","));
      if (!this.phrases.contains(newPhrase) && newPhrase.phrase.isNotEmpty) {
        this.phrases.add(newPhrase);
        print("Carregada frase:" + tmp[0] + " com Tags: " + tmp[1]);
      }
    }
  }

  void addNewPhrase(String phrase, String tags) {
    this._items["{phrases}"] = (this._items["{phrases}"] ?? "") + "{" + phrase + "|" + tags.replaceAll(", ", ",") + "}";
    this.addNewItem("{phrases}", this._items["{phrases}"]);
    this.phrases.add(Phrase(phrase, tags.replaceAll(", ", ",").split(",")));
  }
}
