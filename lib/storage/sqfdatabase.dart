import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //create database
  static Future<sql.Database> OpenDb() async {
    return sql.openDatabase('datauser', version: 1,
        onCreate: (sql.Database db, int version) async {
      await createTable(db);
    });
  }

  //create Table
  static Future<void> createTable(sql.Database db) async {
    await db.execute("""CREATE TABLE user(
     id INTEGER PRIMARY KEY,
     repo_name TEXT,
     repo_description TEXT,
     rating TEXT,
     created TEXT
  )""");
  }

  //add fav
  static Future<int> AddNewUser(String proj_name, String proj_discription,
      String repo_rating, String repo_created) async {
    final db = await SQLHelper.OpenDb();
    final data = {
      'repo_name': proj_name,
      'repo_description': proj_discription,
      'rating': repo_rating,
      'created': repo_created
    };
    final id = db.insert('user', data);
    return id;
  }

  static Future<List<Map>> getAll() async {
    final db = await SQLHelper.OpenDb();
    final data = db.rawQuery("SELECT * FROM user");
    return data;
  }

//delete fav
  static Future<void> Deleteuser(int id) async {
    final db = await SQLHelper.OpenDb();
    db.delete('user', where: 'id = ?', whereArgs: [id]);
  }
}
