import 'package:eco_pop/database/connection.dart';
import 'package:eco_pop/pop/pop.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref();

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'ecopop');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(PopDao.tableSql);
      db.execute(PopDao.tableDadosSql);
    },
    version: 1,
    //limpar o banco de dados - primeiro precisa alterar a versão
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

class PopDao {
  Database? _db;

  static const String _tabela = 'pop';
  static const String _id = 'id';
  static const String _descricao = 'descricao';
  static const String _conceito = 'conceito';
  static const String _fonte = 'fonte';
  static const String _formula = 'formula';
  static const String _experimento = 'experimento';
  static const String _padrao = 'padrao';

  static const String tableSql = 'CREATE TABLE $_tabela('
      '$_id INTEGER PRIMARY KEY,'
      '$_descricao TEXT,'
      '$_conceito TEXT,'
      '$_fonte TEXT,'
      '$_formula TEXT,'
      '$_experimento TEXT,'
      '$_padrao BOOLEAN'
      ')';

  static const String _tabelaDados = 'dados_pop';
  static const String _idPop = 'id_pop';
  static const String _quantidade = 'quantidade';
  static const String _tempo = 'tempo';

  static const String tableDadosSql = 'CREATE TABLE $_tabelaDados('
      '$_id INTEGER PRIMARY KEY,'
      '$_idPop INTEGER,'
      '$_quantidade FLOAT,'
      '$_tempo FLOAT'
      ')';

  List<Pop> _pops = [];
  //salvar
  Future<int> save(Pop pop) async {
    //final Database db = await getDatabase();
    _db = await Connection.getDatabase();

    Map<String, dynamic> popMap = _toMap(pop);
    return _db!.insert(_tabela, popMap);
  }

  Map<String, dynamic> _toMap(Pop pop) {
    final Map<String, dynamic> popMap = Map();
    popMap[_descricao] = pop.descricao;
    popMap[_conceito] = pop.conceito;
    popMap[_fonte] = pop.fonte;
    popMap[_formula] = pop.formula;
    popMap[_experimento] = pop.experimento;
    popMap[_padrao] = pop.padrao;
    return popMap;
  }

  //gegar todos
  Future<List<Pop>> findAll() async {
    //final Database db = await getDatabase();
    _db = await Connection.getDatabase();
    final List<Map<String, dynamic>> resultado = await _db!.query(_tabela);
    List<Pop> pops = _toList(resultado);
    return pops;
  }

  List<Pop> _toList(List<Map<String, dynamic>> resultado) {
    final List<Pop> pops = [];
    for (Map<String, dynamic> row in resultado) {
      final Pop pop = Pop(
        row[_id],
        row[_descricao],
        conceito: row[_conceito],
        fonte: row[_fonte],
        formula: row[_formula],
        experimento: row[_experimento],
        padrao: row[_padrao],
      );
      pops.add(pop);
    }
    return pops;
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
  Future<int> update(Pop pop) async {
    //final db = await getDatabase();
    _db = await Connection.getDatabase();
    final resultado = await _db!.update(_tabela, _toMap(pop),
        where: '$_id = ?', whereArgs: [pop.id]);
    return resultado;
  }

  //##########FIREBASE
  Future<List<Pop>> findAllFB(String url) async {
    //Exemplo: url = 'projetos_padrao/EXPO'
    final snapshot = (await ref.child(url).get());
    final List<Pop> pops = [];
    var i=0;
    while ( i < snapshot.children.length ){
      DataSnapshot data = snapshot.children.elementAt(i);
      final Pop pop = Pop(
          int.parse(data.child("id").value.toString()),
          data.child("descricao").value.toString(),
          conceito: data.child("conceito").value.toString(),
          experimento: data.child("experimento").value.toString(),
          fonte: data.child("fonte").value.toString(),
          formula: data.child("formula").value.toString(),
          padrao: data.child("padrao").value == 'true'
      );
      pops.add(pop);
      i = i +1;
    }
    _pops = pops;
    return pops;
  }

  Future<List<Map<String, dynamic>>> findDadosFB(String url) async {
    //Exemplo: url = 'projetos_padrao/EXPO'
    final snapshot = (await ref.child(url).get());
    final List<Map<String, dynamic>> dados = [];
    var i=0;
    while ( i < snapshot.children.length ){
      DataSnapshot data = snapshot.children.elementAt(i);
      final Map<String, dynamic> dadosMap = Map();
      dadosMap['tempo'] = data.child("tempo").value.toString();
      dadosMap['estoque'] = data.child("estoque").value.toString();
      dados.add(dadosMap);
      i = i +1;
    }
    return dados;
  }

  Future<Pop> findPopFB(String url) async {
    //Exemplo: url = 'projetos_padrao/EXPO'
    final snapshot = (await ref.child(url).get());
    DataSnapshot data = snapshot;
    final Pop pop = Pop(
        int.parse(data.child("id").value.toString()),
        data.child("descricao").value.toString(),
        conceito: data.child("conceito").value.toString(),
        experimento: data.child("experimento").value.toString(),
        fonte: data.child("fonte").value.toString(),
        formula: data.child("formula").value.toString(),
        padrao: data.child("padrao").value == 'true'
    );
    print(pop);
    return pop;
  }



}