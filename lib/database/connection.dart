import 'package:eco_pop/grupo-pesquisa/grupo_dao.dart';
import 'package:eco_pop/instituicao/instituicao_dao.dart';
import 'package:eco_pop/user/usuario_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db == null) {
      final path = join(await getDatabasesPath(), 'ecopop');
      //deleteDatabase(path);
      _db = await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) {
          return {
            db.execute(GrupoPesquisaDao.tableSql),
            db.execute(InstituicaoDao.tableSql),
            db.execute(UsuarioDao.tableSql),
          };
        },
        onDowngrade: onDatabaseDowngradeDelete,
      );
    }
    return _db!;
  }
}
