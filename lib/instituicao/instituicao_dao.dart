import 'package:eco_pop/database/connection.dart';
import 'package:eco_pop/instituicao/instituicao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'ecopop');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(InstituicaoDao.tableSql);
    },
    version: 1,
    //limpar o banco de dados - primeiro precisa alterar a versão
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}*/

class InstituicaoDao {
  Database? _db;

  static const String _tabela = 'instituicao';
  static const String _id = 'id';
  static const String _descricao = 'descricao';
  static const String _sigla = 'sigla';

  static const String tableSql = 'CREATE TABLE $_tabela('
      '$_id INTEGER PRIMARY KEY,'
      '$_descricao TEXT,'
      '$_sigla TEXT'
      ')';

  //salvar instituicao
  Future<int> save(Instituicao instituicao) async {
    //final Database db = await getDatabase();
    _db = await Connection.getDatabase();

    Map<String, dynamic> instiMap = _toMap(instituicao);
    return _db!.insert(_tabela, instiMap);
  }

  Map<String, dynamic> _toMap(Instituicao instituicao) {
    final Map<String, dynamic> instiMap = Map();
    instiMap[_descricao] = instituicao.descricao;
    instiMap[_sigla] = instituicao.sigla;

    return instiMap;
  }

  //gegar todas as instituições
  Future<List<Instituicao>> findAll() async {
    //final Database db = await getDatabase();
    _db = await Connection.getDatabase();
    final List<Map<String, dynamic>> resultado = await _db!.query(_tabela);
    List<Instituicao> instituicoes = _toList(resultado);
    return instituicoes;
  }

  List<Instituicao> _toList(List<Map<String, dynamic>> resultado) {
    final List<Instituicao> instituicoes = [];
    for (Map<String, dynamic> row in resultado) {
      final Instituicao instituicao = Instituicao(
          id: row[_id], descricao: row[_descricao], sigla: row[_sigla]);
      instituicoes.add(instituicao);
    }
    return instituicoes;
  }

  //delete
  Future<int> delete(int id) async {
    //final db = await getDatabase();
    _db = await Connection.getDatabase();
    int resultado = await _db!.delete(_tabela, //nome da tabela
        where: "$_id = ?",
        whereArgs: [id]);

    return resultado;
  }

  //atualizar
  Future<int> update(Instituicao instituicao) async {
    //final db = await getDatabase();
    _db = await Connection.getDatabase();
    final resultado = await _db!.update(_tabela, _toMap(instituicao),
        where: '$_id = ?', whereArgs: [instituicao.id]);
    return resultado;
  }
}
