import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper{

  static Future<void> insert(String table,Map<String,Object> data)async{

    //get folder to store all databases
    final dbPath= await sql.getDatabasesPath();
    //open data base it creates database if now available else return existing
    final sqlDb = await sql.openDatabase(
      path.join(dbPath,'places.db'),
      //when create database 
      //this method is called when sql open database and it does not find places.db
      //this is used to initialize database
      onCreate: (db,version){

        return db.execute('CREATE TABEL user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
      },
      version: 1,
    );

    await sqlDb.insert(table, data,conflictAlgorithm:sql.ConflictAlgorithm.replace );

  }


}