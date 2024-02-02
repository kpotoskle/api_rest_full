import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
  
}


class _homeState extends State<home> {
  String userData="";
  void _getGithubUser(){
    String url = "https://api.github.com/search/users?q=kader&page=2&per_page=5";
    http.get(Uri.parse(url)).then((reponse) {
    setState(() {
      userData = reponse.body;
    });
    print(userData);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor:Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Center(child: ElevatedButton(onPressed: (){}, child: Text("Afficher"))),
          Text(userData)
        ],
      ),
    );
  }
}




