import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  String? id;
  String? symbol;
  String? name;
  String? hashingalgorithm;

  Post({this.id, this.symbol, this.name});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    name = json['hashing_algorithm'];
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  Future<Post> fetchAlbum(id) async {
    final response =
        await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/$id'));

    if (response.statusCode == 200) {
      //List body = json.decode(response.body);
      //List<Post> posts = body.map((e) => Post.fromJson(e)).toList();
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la moneda'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          // Wait for the futureAlbum to complete and rebuild the UI accordingly
          future: fetchAlbum(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //
              // Todo devolver mas data en un formato
              return Text('Nombre: ${snapshot.data!.symbol}');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),

      /*
      funciona :-)

      const Center(
          child: ListTile(
        leading: Icon(Icons.money),
        title: Text('Jane Doe'),
        subtitle: Text('janedoe@example.com'),
        trailing: Icon(Icons.arrow_forward),
      )
      ),*/
    );
  }
}
