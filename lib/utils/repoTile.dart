import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../storage/sqfdatabase.dart';

class RepoTile extends StatelessWidget {
  final List<Map<String, dynamic>> userData;

  RepoTile(this.userData);

/////////////////////////////////////////////////////////////////////////////////////

//30day Filteration Line

// List<Map<String, dynamic>> filteredData = [];

// List<Map<String, dynamic>> filterUserData() {
//   final DateTime thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
//   List<Map<String, dynamic>> filteredData = [];

//   for (var repo in userData) {
//     DateTime createdAt = DateTime.parse(repo["created_at"]);
//     if (createdAt.isAfter(thirtyDaysAgo)) {
//       filteredData.add(repo);
//     }
//   }

//   filteredData.sort(
//       (a, b) => b["stargazers_count"].compareTo(a["stargazers_count"]) as int);

//   return filteredData;
// }

/////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    userData.sort((a, b) =>
        b["stargazers_count"].compareTo(a["stargazers_count"]) as int);
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            userData[index]["owner"]["avatar_url"]),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 5),
                        child: Text(
                          userData[index]["name"].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description: ${userData[index]["description"].toString()}',
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
                          Text(userData[index]["stargazers_count"].toString())
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Created at ${DateFormat("dd/MM/yy").format(
                          DateTime.parse(userData[index]["created_at"]),
                        )}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                        onPressed: () async {
                          final id = await SQLHelper.AddNewUser(
                            userData[index]["name"],
                            userData[index]["description"],
                            userData[index]["stargazers_count"].toString(),
                            userData[index]["created_at"],
                          );

                          if (id != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to favorites')),
                            );
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.redAccent,
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
