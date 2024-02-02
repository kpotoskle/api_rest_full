import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  dynamic dynamicUserData ;
  String data = "";

  void _getGithubUser() {
    String url =
        "https://api.github.com/search/users?q=kader&page=2&per_page=5";
    http.get(Uri.parse(url)).then((reponse) {
      setState(() {
        data = reponse.body;
        dynamicUserData = json.decode(data);
      });
    }).catchError((error){
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api"),
        leading: Icon(Icons.menu),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    _getGithubUser();
                  },
                  child: Text("Afficher"))),
          Expanded(
              child: ListView.builder(
            itemCount:
                dynamicUserData == null ? 0 : dynamicUserData['items'].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        dynamicUserData['items'][index]['avatar_url'],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        dynamicUserData["items"][index]['login'].toUpperCase()),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
