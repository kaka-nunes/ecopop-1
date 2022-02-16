import 'package:eco_pop/main.dart';
import 'package:eco_pop/screens/grupo-pesquisa/grupo_dao.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListarGruposPesquisa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListarGruposPesquisaState();
  }
}

class ListarGruposPesquisaState extends State<ListarGruposPesquisa> {
  //final List _grupos = [];
  final GrupoPesquisaDao _gruposDao = GrupoPesquisaDao();

  @override
  Widget build(BuildContext context) {
    //_grupos.add(GrupoPesquisa('Informática'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Grupo de pesquisa'),
      ),
      body: FutureBuilder<List<GrupoPesquisa>>(
        initialData: [],
        //future: Future.delayed(Duration(seconds: 5))
        //.then((value) => _gruposDao.findAll()),
        future: _gruposDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando!')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<GrupoPesquisa> grupos = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final GrupoPesquisa grupo = grupos[index];
                  return ItensGruposPesquisa(grupo);
                },
                itemCount: grupos.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        /*onPressed: () {
          //criar uma navegação para o formulário de cadastro
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioGrupoPesquisa(); //FormularioTransferencia();
          }));
          future.then((descricaoRecebida) {
            setState(() {
              if (descricaoRecebida != null && descricaoRecebida != '') {
                _grupos.add(descricaoRecebida);
              }
            });
          });
        },*/
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => FormularioGrupoPesquisa(),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FormularioGrupoPesquisa extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioGrupoPesquisaState();
  }
}

class FormularioGrupoPesquisaState extends State<FormularioGrupoPesquisa> {
  final TextEditingController _controladorCampoNome = TextEditingController();

  final GrupoPesquisaDao _grupoDao = GrupoPesquisaDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Grupo de Pesquisa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 20.0),
          child: Column(
            children: [
              TextField(
                controller: _controladorCampoNome,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Descrição do grupo',
                  contentPadding: const EdgeInsets.all(8.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    //_criaGrupoPesquisa(context);
                    final String nomegrupo = _controladorCampoNome.text;

                    final GrupoPesquisa newGrupoPesquisa =
                        GrupoPesquisa(0, nomegrupo);
                    //Salvar
                    _grupoDao
                        .save(newGrupoPesquisa)
                        .then((id) => Navigator.pop(context));
                  },
                  child: Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*void _criaGrupoPesquisa(BuildContext context) {
    //receber o valor do formulario
    final String descricao = _controladorCampoDescricao.text;
    if (descricao != '') {
      final descricaoGrupo = GrupoPesquisa(nomegrupo);
      Navigator.pop(context, descricaoGrupo); //retornar para a tela anterior
    }
  }*/
}

class ItensGruposPesquisa extends StatelessWidget {
  final GrupoPesquisa _grupo_pesquisa;

  const ItensGruposPesquisa(this._grupo_pesquisa);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        /*final Future future =
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Detalhe();
              }));
              future.then((grupo) {
                //teste
              }); */
      },
      child: Card(
        child: ListTile(
          title: Text(_grupo_pesquisa.nomegrupo),
          subtitle: Text(_grupo_pesquisa.id.toString()),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    color: Colors.orange[300]),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  color: Colors.red[900],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class Connection {
  static Database? _db;

  static Future<Database?> get() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'ecopop');
      //deleteDatabase(path);
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          db.execute(createTable);
          db.execute(insert1);
          //db.execute(insert2);
          //db.execute(insert3);
        },
      );
    }
    return _db;
  }
}

final createTable = '''
  CREATE TABLE grupo(
    id INTEGER NOT NULL PRIMARY KEY
    ,grupo VARCHAR(200) NOT NULL
  )
''';

final insert1 = '''
  INSERT INTO grupo (grupo)
  VALUES ('anatormia dos vegetais')
''';*/
