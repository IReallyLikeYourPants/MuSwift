class opera{
  String nome;
  String autore;
  String tipo;
  String anno;
  String nav;
  String nav_real;
  String stile;
  String storia;
  String autore_storia;
  String immagine;

  opera({this.autore, this.tipo, this.anno, this.nav, this.nav_real, this.stile, this.storia, this.autore_storia, this.immagine});

  factory opera.fromJson(Map<String, dynamic> parsedJson, String nome){
    return opera(
        autore: parsedJson[nome]['autore'],
        tipo: parsedJson[nome]['tipo'],
        anno: parsedJson[nome]['anno'],
        nav: parsedJson[nome]['nav'],
        nav_real: parsedJson[nome]['nav_real'],
        stile: parsedJson[nome]['stile'],
        storia: parsedJson[nome]['storia'],
        autore_storia: parsedJson[nome]['autore_storia'],
        immagine: parsedJson[nome]['img']
    );
  }
}