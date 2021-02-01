import 'package:flutter/material.dart';

const double bottomHeightPercentage = 0.2;

class operaDetails extends StatelessWidget {

  String img;

  operaDetails(String immagine){
    this.img = immagine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Expanded(child: GestureDetector(
                child: Center(
                  child: Hero(
                      tag: 'imageHero',
                      child: Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage( // per metterci l'immagine dentro
                            image: new AssetImage(img),
                            fit: BoxFit.cover, // per adattarla al container
                          ),
                        ),
                      )
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
              Container(
                height: MediaQuery. of(context). size. height * bottomHeightPercentage,
                decoration: BoxDecoration(
                    color: Colors.green
                ),
                child: Text("Ciao mondo"),
              )
            ]
        )
    );
  }
}