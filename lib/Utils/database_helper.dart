import 'dart:io';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = Strings.dbFileName;
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 3;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    print('creating items table');
    await db.execute('''
              CREATE TABLE ${Strings.tableItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.itemColumnDate} TEXT NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL
              )
              ''');

    print('Creating reccurrent expenses table');
    await db.execute('''
              CREATE TABLE ${Strings.tableRecurrentItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.recurrentItemColumnDay} INTEGER NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL,
                ${Strings.recurrentItemColumnIsAdded} INTEGER NOT NULL
              )
              ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO: temp until expiry date
    try {
      //create temp table
      print('Creating temporary table');
      await db.execute('''
              CREATE TABLE temp (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.itemColumnDate} TEXT NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL
              )
              ''');

      print('copying data from old table to temporary table');
      List<Map> maps = await db.query(Strings.tableItems);
      List<Item> items = new List();
      // items contains fuked up items with numbers as categories
      if (maps.length > 0) {
        for (Map row in maps) {
          items.add(new Item.fromMapHasIntCat(row));
        }
      }
      for (var item in items) {
        String category;
        switch (item.category) {
          case '0':
            category = Strings.food;
            break;
          case '1':
            category = Strings.transportation;
            break;
          case '2':
            category = Strings.shopping;
            break;
          case '3':
            category = Strings.entertainment;
            break;
          case '4':
            category = Strings.activity;
            break;
          case '5':
            category = Strings.medical;
            break;
          case '6':
            category = Strings.home;
            break;
          case '7':
            category = Strings.travel;
            break;
          case '8':
            category = Strings.people;
            break;
          case '9':
            category = Strings.education;
            break;
          case '10':
            category = Strings.salary;
            break;
          case '11':
            category = Strings.gift;
            break;
          case '12':
            category = Strings.business;
            break;
          case '13':
            category = Strings.insurance;
            break;
          case '14':
            category = Strings.realEstate;
            break;
          case '15':
            category = Strings.investment;
            break;
          case '16':
            category = Strings.refund;
            break;
          case '17':
            if (item.type == ItemType.expense) {
              category = Strings.otherExpenses;
            }
            else {
              category = Strings.otherIncomes;
            }
            break;
        }

        item.category = category;

        await db.insert('temp', item.toMap());
      }

      // drop table
      print('dropping outdated items table');
      await db.rawQuery('DROP TABLE ${Strings.tableItems};');

      print('Creating up to date items table');
      await db.execute('''
              CREATE TABLE ${Strings.tableItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.itemColumnDate} TEXT NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL
              )
              ''');

      print('transfering rows in temp table to new items table');
      await db
          .rawQuery('INSERT INTO ${Strings.tableItems} SELECT * FROM temp;');

      print('drop temp table');
      await db.rawQuery('DROP TABLE temp;');

      print('Dropping outdated reccurent items table');
      await db.rawQuery('DROP TABLE ${Strings.tableRecurrentItems};');

      print('create new reccurent table');
      await db.execute('''
              CREATE TABLE ${Strings.tableRecurrentItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.recurrentItemColumnDay} INTEGER NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL,
                ${Strings.recurrentItemColumnIsAdded} INTEGER NOT NULL
              )
              ''');
    } catch (e) {
      print('Error migrating data to new db');
    }
  }

  Future<void> upgrade() async {
    // TODO: temp until expiry date
    Database db = await database;
    await _onUpgrade(db, 2, 3);
  }

  Future<int> insertItem(Item expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableItems, expense.toMap());
    return id;
  }

  Future<Item> queryItem(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(Strings.tableItems,
        columns: [
          Strings.itemColumnId,
          Strings.itemColumnName,
          Strings.itemColumnValue,
          Strings.itemColumnDate,
          Strings.itemColumnCategory,
          Strings.itemColumnType
        ],
        where: '${Strings.itemColumnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Item.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Item>> queryItemsInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];

    List<Map> maps = await db.query(Strings.tableItems,
        where: '${Strings.itemColumnDate} LIKE \'$dateStrToFind%\'');

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsInMonth(String yearMonth) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$yearMonth%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsInYear(String year) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$year%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryAllItems() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableItems);

    return convertMapsToItems(maps);
  }

  Future<int> updateItem(Item expense) async {
    Database db = await database;

    return await db.update(Strings.tableItems, expense.toMap(),
        where: '${Strings.itemColumnId} = ?', whereArgs: [expense.id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableItems,
        where: '${Strings.itemColumnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableItems}');
  }

  List<Item> convertMapsToItems(List<Map> maps) {
    List<Item> expenses = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        expenses.add(new Item.fromMap(row));
      }
    }

    return expenses;
  }
}
