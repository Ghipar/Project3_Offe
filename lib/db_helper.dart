import 'package:project_3/cart_model.dart';
import 'package:project_3/menu.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
// import 'package:shopping_cart_app/model/cart_model.dart';
import 'cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'keran.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE keran(id VARCHAR PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, image TEXT)');
  }

// inserting data into the table
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('keran', cart.toMap());
    return cart;
  }

// getting all the items in the list from the database
  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('keran');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  // Future<List<Map<String, dynamic>>> getproduct() async {
  //   var dbClient = await database;
  //   final data = await dbClient!.query('keran', columns: ['productName']);
  //   List<Cart> result = data.map((e) => cart.from)

  // }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!
        .update('keran', cart.toMap(), where: "id = ?", whereArgs: [cart.id]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(String id) async {
    var dbClient = await database;
    return await dbClient!.delete('keran', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearCartItem() async {
    var dbClient = await database;
    return await dbClient!.delete('keran');
  }
}
