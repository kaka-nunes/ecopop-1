import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'ecopop');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(GrupoPesquisaDao.tableSql);
    },
    version: 1,
    //limpar o banco de dados - primeiro precisa alterar a versão
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

class GrupoPesquisaDao {
  static const String _tabela = 'grupopesquisa';
  static const String _id = 'id';
  static const String _nomegrupo = 'nomegrupo';

  static const String tableSql = 'CREATE TABLE $_tabela('
      '$_id INTEGER PRIMARY KEY,'
      '$_nomegrupo TEXT'
      ')';

  //salvar
  Future<int> save(GrupoPesquisa grupo) async {
    final Database db = await getDatabase();

    Map<String, dynamic> grupoMap = _toMap(grupo);
    return db.insert(_tabela, grupoMap);
  }

  Map<String, dynamic> _toMap(GrupoPesquisa grupo) {
    final Map<String, dynamic> grupoMap = Map();
    grupoMap[_nomegrupo] = grupo.nomegrupo;
    return grupoMap;
  }

  //gegar todos
  Future<List<GrupoPesquisa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> resultado = await db.query(_tabela);
    List<GrupoPesquisa> grupos = _toList(resultado);
    return grupos;
  }

  List<GrupoPesquisa> _toList(List<Map<String, dynamic>> resultado) {
    final List<GrupoPesquisa> grupos = [];
    for (Map<String, dynamic> row in resultado) {
      final GrupoPesquisa grupo = GrupoPesquisa(
        row[_id],
        row[_nomegrupo],
      );
      grupos.add(grupo);
    }
    return grupos;
  }

  //delete
  Future<int> delete(int id) async {
    final db = await getDatabase();

    int resultado = await db.delete(_tabela, //nome da tabela
        where: "$_id = ?",
        whereArgs: [id]);

    return resultado;
  }

  //atualizar
  Future<int> update(GrupoPesquisa grupo) async {
    final db = await getDatabase();
    final resultado = await db.update(_tabela, _toMap(grupo),
        where: '$_id = ?', whereArgs: [grupo.id]);
    return resultado;
  }
}

class GrupoPesquisa {
  final int id;
  final String nomegrupo;

  GrupoPesquisa(this.id, this.nomegrupo);

  @override
  String toString() {
    return 'GrupoPesquisa{id: $id, grupo: $nomegrupo}';
  }
}
