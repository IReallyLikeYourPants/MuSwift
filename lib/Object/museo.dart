class museo{
  String nome;
  int adulti;
  int bambini;
  String luogo;
  String orario;
  String numero;
  String sito;
  String storia;
  String immagine;
  double rate;
  var opere;

  museo({this.adulti, this.bambini, this.luogo, this.orario, this.numero, this.sito, this.storia, this.immagine, this.rate, this.opere});

  factory museo.fromJson(Map<String, dynamic> parsedJson, String nome){
    return museo(
        adulti: parsedJson[nome]['adulti'],
        bambini: parsedJson[nome]['bambini'],
        luogo: parsedJson[nome]['luogo'],
        orario: parsedJson[nome]['orario'],
        numero: parsedJson[nome]['numero'],
        sito: parsedJson[nome]['sito'],
        storia: parsedJson[nome]['storia'],
        immagine: parsedJson[nome]['immagine'],
        rate: parsedJson[nome]['rate'],
        opere: parsedJson[nome]['opere']
    );
  }
}