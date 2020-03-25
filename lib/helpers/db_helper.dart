import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper{


  static Future<sql.Database> database() async{

    //get folder to store all databases
    final dbPath= await sql.getDatabasesPath();
    //open data base it creates database if now available else return existing
    return sql.openDatabase(
      path.join(dbPath,'places.db'),
      //when create database 
      //this method is called when sql open database and it does not find places.db
      //this is used to initialize database
      onCreate: (db,version){

        return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,loc_lati REAL,loc_long REAL,address TEXT)');
      },
      version: 1,
    );

    

  }

  static Future<void> insert(String table,Map<String,Object> data)async{

    final db=await DBHelper.database();
    db.insert(table, data,conflictAlgorithm:sql.ConflictAlgorithm.replace );

  }


  static Future<List< Map<String,dynamic> >> getData(String table)async{

    final db=await DBHelper.database();
    return db.query(table);

  }


}