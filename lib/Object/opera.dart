class opera{
  String nome;
  String autore;
  String tipo;
  String anno;
  String nav;


  opera({this.autore, this.tipo, this.anno, this.nav});

  factory opera.fromJson(Map<String, dynamic> parsedJson, String nome){
    return opera(
      autore: parsedJson[nome]['autore'],
      tipo: parsedJson[nome]['tipo'],
      anno: parsedJson[nome]['anno'],
      nav: parsedJson[nome]['nav'],
    );
  }
}