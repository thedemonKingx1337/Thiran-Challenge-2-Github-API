import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../storage/sqfdatabase.dart';

class FavTile extends StatefulWidget {
  final List<Map<String, dynamic>> favData;

  FavTile(this.favData);

  @override
  State<FavTile> createState() => _FavTileState();
}

class _FavTileState extends State<FavTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.favData.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 5),
                        child: Text(
                          widget.favData[index]["repo_name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.favData[index]["repo_description"],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7, right: 10),
                            child: Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow,
                              size: 15,
                            ),
                          ),
                          Text(widget.favData[index]["rating"])
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.favData[index]["created"],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                        onPressed: () async {
                          await SQLHelper.Deleteuser(
                              widget.favData[index]["id"]);
                          setState(() {
                            widget.favData.removeAt(index);
                          });
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
