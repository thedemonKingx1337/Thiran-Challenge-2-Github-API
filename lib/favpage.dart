import 'package:flutter/material.dart';
import 'package:flutter_application_001/main.dart';
import 'package:flutter_application_001/utils/favTile.dart';

import 'storage/sqfdatabase.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  int currentIndex = 1;
  List<Map<String, dynamic>> favorites = [];

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Fet(),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromDb();
  }

  void fetchDataFromDb() async {
    final fetchData_dumb = await SQLHelper.getAll();
    setState(() {
      favorites = List<Map<String, dynamic>>.from(fetchData_dumb);
    });
  }

  @override
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
      body: FavTile(favorites),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
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
