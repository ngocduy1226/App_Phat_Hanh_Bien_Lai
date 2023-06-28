import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLdb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialisation();
      return _db;
    } else {
      return _db;
    }
  }

  //---------------------------------------------------------
  Future<Database> initialisation() async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, "Receipt");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }

  //---------------------------------------------------------
  _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "brands" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "content" TEXT NOT NULL,
    "denominations" DOUBLE NOT NULL
    )
    ''');


    await db.execute('''
    CREATE TABLE "configs" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "urlservice" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "pass" TEXT NOT NULL,
    "acacount" TEXT NOT NULL,
    "acpass" TEXT NOT NULL,
    "pattern" TEXT NOT NULL,
    "serial" TEXT NOT NULL
    )
    '''); 
 
     await db.execute('''
    CREATE TABLE "receipts" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "brand" INTEGER NOT NULL,
    "quantity" DOUBLE NOT NULL,
    "total" DOUBLE NOT NULL
    )
    ''');

    // await db.execute(bản moi)
    print("==============Database created!============");
  }

  //-------------------------CRUID---------------------------
  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;
  }

  //-------------------------lecture-----------------------
  Future<List<Map>> getData(String sql) async {
    Database? mydb = await db;
    List<Map> rep = await mydb!.rawQuery(sql);
    return rep;
  }
  //-------------------------update-----------------------
  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int reponse = await mydb!.rawUpdate(sql);
    return reponse;
  }
  //-------------------------delete-----------------------
  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int reponse = await mydb!.rawDelete(sql);
    return reponse;
  }

//-----------------------------------------------------
}
