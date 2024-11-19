import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/team_model.dart';

class DatabaseController extends GetxController {
  static Database? _db;
  final data = <TeamModel>[].obs;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'teams_database.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE teams(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            strTeam TEXT,
            strBadge TEXT,
            strDescriptionEN TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
    );
    return db;
  }

  Future<void> toggleFavorite(TeamModel team) async {
    var dbClient = await db;
    team.isFavorite = team.isFavorite == 1 ? 0 : 1;

    var exists = await dbClient.query(
      'teams',
      where: 'strTeam = ?',
      whereArgs: [team.strTeam],
    );

    if (exists.isEmpty) {
      await dbClient.insert('teams', team.toMap());
    } else {
      await dbClient.update(
        'teams',
        {'isFavorite': team.isFavorite},
        where: 'strTeam = ?',
        whereArgs: [team.strTeam],
      );
    }
    await loadFavorites();
  }

  Future<void> loadFavorites() async {
    var dbClient = await db;
    var result = await dbClient.query('teams');
    data.value = result.map((item) => TeamModel.fromJson(item)).toList();
  }

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }
}
