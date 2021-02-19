import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: LoveSales()));

class LoveSales extends StatefulWidget {
  @override
  _LoveSalesState createState() => _LoveSalesState();
}

int counter = 0;
int _selectedIndex = 0;

class _LoveSalesState extends State<LoveSales> {
  Widget getPage(int index) {
    if (index == 0) {
      return Shares();
    }
    if (index == 1) {
      return Favorite();
    }
    if (index == 2) {
      return SuperMarkets();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _counter() => {
        setState(() {
          counter++;
        })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Digri App'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Shares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Super Markets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: getPage(_selectedIndex),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _counter,
        label: Text('Add to cart'),
        icon: Icon(Icons.store_sharp),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}

class Shares extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/thumb.jpeg"),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text('NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )),
            SizedBox(height: 10),
            Text('DigriFine',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text('LEVEL',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )),
            SizedBox(height: 10),
            Text('$counter',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'FAVORITE PAGE',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuperMarkets extends StatefulWidget {
  @override
  _SuperMarketsState createState() => _SuperMarketsState();
}

class _SuperMarketsState extends State<SuperMarkets> {
  List<Liquid> parseLiquids(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Liquid>((json) => Liquid.fromJson(json)).toList();
  }

  Future<List<Liquid>> fetchPhotos(http.Client client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/photos');

    return parsePhotos(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'SUPER MARKET PAGE',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
              )
            ],
          )),
    );
  }
}

class Liquid {
  final String name;
  final String url;
  final String cost;
  final String photoUrl;

  Liquid({this.name, this.cost, this.photoUrl, this.url});

  factory Liquid.fromJson(Map<String, dynamic> json) {
    return Liquid(
      name: json['name'] as String,
      url: json['url'] as String,
      cost: json['cost'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}
