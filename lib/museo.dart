import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> getJson() {
  return rootBundle.loadString('assets/loadjson/infomusei.json');
}

Container infoRow(IconData icon, String label){
  return Container(
    margin: EdgeInsets.only(top: 15),
    child: Row(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 20
            ),
          ),
        )
      ],
    ),
  );
}
Container noteRow(IconData icon, String label){
  return Container(
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 20
            ),
          ),
        )
      ],
    ),
  );
}

class InsideTabBar extends StatefulWidget {
  @override
  _InsideTabBarState createState() => _InsideTabBarState();
}

class _InsideTabBarState  extends State<InsideTabBar> with TickerProviderStateMixin{

  TabController _insideTabController;

  void initState() {
    super.initState();

    _insideTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _insideTabController.dispose();
  }

  Widget opereTab = Container(
    child: Text("Pagina delle opere"),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _insideTabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          tabs: <Widget>[
            Tab(
              child: Text(
                "INFORMAZIONI",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Tab(
              child: Text(
                "OPERE",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ],
        ),
        Container(
          //SISTEMARE ALTEZZA
          height: MediaQuery. of(context). size. height - 454,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TabBarView(
            controller: _insideTabController,
            children: [
              Container(
                child: ListView(
                  children: [
                    infoRow(Icons.confirmation_num, "Prezzo biglietto 17€"),
                    infoRow(Icons.map, "Città del Vaticano"),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => schedulePage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 30,
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Lunedì 08-18",
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  )
                              ),
                              Icon(
                                Icons.navigate_next_sharp,
                                size: 30,
                              )
                            ],
                          ),
                        )
                    ),
                    infoRow(Icons.call, "+06 12345678"),
                    infoRow(Icons.web, "www.musei.it"),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black),
                    SizedBox(height: 10,),
                    Text("I Musei Vaticani sono il polo museale della Città del Vaticano a Roma.Fondati da papa Giulio II nel XVI secolo, occupano gran parte del vasto cortile del Belvedere e sono una delle raccolte d'arte più grandi del mondo, dal momento che espongono l'enorme collezione di opere d'arte accumulata nei secoli dai papi: la Cappella Sistina e ...Leggi di più ",
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20
                        )
                    ),
                    SizedBox(height: 5,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => storyPage()),
                                );
                              },
                              child: Text(
                                "...leggi di più",
                                style: TextStyle(
                                    fontSize: 20
                                ) ,
                              )
                          )
                        ]
                    ),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                          "MAPPA",
                                          textAlign: TextAlign.center
                                      ),
                                    )
                                )
                            )
                        ),
                        Expanded(
                            flex: 5,
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "PRENOTA",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                )
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Note aggiuntive: ",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 10,),
                    noteRow(Icons.check, "Adibito per disabili"),
                    noteRow(Icons.check, "Visita interattiva"),
                    noteRow(Icons.check, "Percheggio a pagamento"),
                    noteRow(Icons.check, "Presenza guida"),
                  ],
                ),
              ), // INFORMAZIONI
              Container(
                child: GridView.count(
                  padding: const EdgeInsets.only(top: 10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container( // primo elemento della prima lista di opere
                          margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                          width: 145,
                          decoration: BoxDecoration(
                            color: Colors.purple[600],
                            borderRadius: new BorderRadius.all( // per i bordi arrotondati
                              new Radius.circular(5.0)
                            ),
                            image: new DecorationImage( // per metterci l'immagine dentro
                              image: new ExactAssetImage("assets/images/deposizione.jpg"),
                              fit: BoxFit.cover, // per adattarla al container
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              )
                            ],
                        ),
                        child: Align( // per allineare la scritta in una posizione specifica
                          alignment: Alignment(-0.40, 0.90),
                          child: Text("Deposizione", style: TextStyle(fontSize: 18, color: Colors.white),)
                        ),
                      ),
                    ),
                  ],
                ),
              ), // OPERE
            ],
          ),
        )
      ],
    );
  }
}

class Museo extends StatelessWidget {
  //DA IMPLEMENTARE
  //var my_data = json.decode(await getJson());
  final String title;

  //DetailScreen({Key key, @required this.todo}) : super(key: key);
  Museo({Key key, @required this.title}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Widget topPage = Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/museovaticano.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 35
              ),
            ),
            Expanded(child: Container()),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 30,),
                          Icon(Icons.star, color: Colors.white, size: 30,),
                          Icon(Icons.star, color: Colors.white, size: 30,),
                          Icon(Icons.star, color: Colors.white, size: 30,),
                          Icon(Icons.star, color: Colors.white, size: 30,),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        )
    );

    return SafeArea(
        child:
        Scaffold(
          body: Column(
            children: [
              topPage,
              InsideTabBar(),
            ],
          ),
        )
    );
  }
}

class storyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('TORNIAMO INDIETRO'),
        ),
      ),
    );
  }
}

class schedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('TORNIAMO INDIETRO'),
        ),
      ),
    );
  }
}