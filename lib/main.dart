import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'favpage.dart';
import 'utils/repoTile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Fet(),
  ));
}

class Fet extends StatefulWidget {
  const Fet({Key? key}) : super(key: key);

  @override
  State<Fet> createState() => _FetState();
}

class _FetState extends State<Fet> {
  List<Map<String, dynamic>> userData = [];
  int _currentIndex = 0;

  Future<void> getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.github.com/search/repositories?q=created:%3E2022-04-29&sort=stars&order=desc"));
    Map<String, dynamic> data = json.decode(response.body);
    setState(() {
      userData = (data["items"] as List).cast<Map<String, dynamic>>();
    });
    debugPrint(json.encode(userData));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FavPage(),
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top Repository Stars",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0B0525),
      ),
      body: RepoTile(userData),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
