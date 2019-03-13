import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
  title: "THE RICK AND MORTY CATALOG",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url = "https://rickandmortyapi.com/api/character/";
  CharacterHub characterHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    characterHub = CharacterHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: Center(
            child: Text("THE RICK AND MORTY",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.black87
      ),
      body: characterHub == null?Center(child: CircularProgressIndicator(),):
      GridView.count(
        crossAxisCount: 2,
        children: characterHub.characters.map((char)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            color: Colors.black38,
            elevation: 2.0,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:NetworkImage(char.image) )
                  ),
                ),
                Text(

                    char.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,

                    ),
                  textAlign: TextAlign.center,
                ),
                Text(
                    "Status:  ${char.status}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ) ),
                Text(
                    "Especie:  ${char.species}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ) ),
                Text(
                    "Genero  : ${char.gender}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ) )
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}