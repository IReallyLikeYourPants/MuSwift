class museo{
  String nome;
  int adulti;
  int bambini;
  String luogo;
  var orario;
  String numero;
  String sito;
  String storia;
  String immagine;
  String chiusura_biglietteria;
  String ultimo_ingresso;
  double rate;
  var opere;
  var note;
  var chiuso;

  museo({this.adulti, this.bambini, this.luogo, this.orario, this.numero, this.sito, this.storia, this.immagine, this.rate, this.opere, this.note, this.ultimo_ingresso, this.chiusura_biglietteria, this.chiuso});

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
        opere: parsedJson[nome]['opere'],
        note : parsedJson[nome]['note'],
        ultimo_ingresso : parsedJson[nome]['ultimo_ingresso'],
        chiusura_biglietteria: parsedJson[nome]['chiusura_biglietteria'],
        chiuso: parsedJson[nome]['chiuso']
    );
  }
}