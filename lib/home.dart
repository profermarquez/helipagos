import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detalle.dart';

Future<List<Post>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/list'));

  if (response.statusCode == 200) {
    List body = json.decode(response.body);
    List<Post> posts = body.map((e) => Post.fromJson(e)).toList();
    return posts;
  } else {
    throw Exception('Failed to load album');
  }
}

class Post {
  String? id;
  String? symbol;
  String? name;

  Post({this.id, this.symbol, this.name});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
  }
}

class HomePageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<Post> posts) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondScreen(id: post.id!)),
            );
          },
          child: Container(
            color: Color.fromRGBO(29, 67, 138, 2),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            child: Card(
              elevation: 4, // Define la elevación de la tarjeta
              color: Color.fromRGBO(29, 67, 138, 2), // Color de fondo
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Espaciado interior
                child: Container(
                  color: Color.fromRGBO(29, 67, 150, 2),
                  // Color de fondo del contenido
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          post.symbol!,
                          style:
                              TextStyle(color: Colors.white), // Letras blancas
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Text(
                          post.name!,
                          style:
                              TextStyle(color: Colors.white), // Letras blancas
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
