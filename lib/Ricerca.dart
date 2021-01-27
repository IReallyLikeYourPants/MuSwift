import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class Ricerca extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Ricerca> {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Post>(
            onSearch: search,
            searchBarStyle: SearchBarStyle(
              backgroundColor: Colors.black54,
              padding: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(10),
            ),
            loader: Center(
              child: Text("loading..."),
            ),
            placeHolder: Center(
              child: Text("Placeholder"),
            ),
            onError: (error) {
              return Center(
                child: Text("Error occurred : $error"),
              );
            },
            header: Row(
              children: <Widget>[
                Spacer(),
                const SizedBox(height: 20,width: 3,),
                ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)),
                    child: Text("Tutto",style: TextStyle(fontSize: 20))),

                const SizedBox(height: 20,width: 3,),
                ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)),
                    child: Text("Musei",style: TextStyle(fontSize: 20))),

                const SizedBox(height: 20,width: 3,),
                ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)),
                    child: Text("Opere",style: TextStyle(fontSize: 20))),
                Spacer(),
              ],
            ),
            emptyWidget: Center(
              child: Text("Empty"),
            ),
            crossAxisCount: 1,
            //indexedScaledTileBuilder: (int index) => ScaledTile.count(1, 1),
            hintText: "Search hint text",
            hintStyle: TextStyle(
              color: Colors.grey[100],
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            mainAxisSpacing: 15,

            onItemFound: (Post post, int index) {
              return Container(
                //color : Colors.black54,
                height: 125,
                decoration: BoxDecoration(
                    color:Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child : ListTile(
                    leading: FlutterLogo(size: 100.0),
                    title: Text(post.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    subtitle: Text(post.description,style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
              ),
              );
            },
          ),
        ),
      ),
    );
  }

}
