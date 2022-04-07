import 'package:eco_pop/instituicao/cadastro_instituicao.dart';
import 'package:eco_pop/instituicao/instituicao.dart';
import 'package:eco_pop/instituicao/instituicao_dao.dart';
import 'package:flutter/material.dart';

class ListarInstituicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListarInstituicaoState();
  }
}

class ListarInstituicaoState extends State<ListarInstituicao> {
  final InstituicaoDao _instituicaoDao = InstituicaoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Instituição'),
      ),
      body: FutureBuilder<List<Instituicao>>(
        initialData: [],
        //future: Future.delayed(Duration(seconds: 5))
        //.then((value) => _gruposDao.findAll()),
        future: _instituicaoDao.findAll(),
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
              final List<Instituicao> instituicoes = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Instituicao instituicao = instituicoes[index];
                  //return ItensGruposPesquisa(grupo);
                  return MaterialButton(
                    onPressed: () {},
                    child: Card(
                      child: ListTile(
                        title: Text(instituicao.descricao),
                        subtitle: Text(instituicao.sigla.toString()),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FormularioInstituicao(),
                                            settings: RouteSettings(
                                                arguments: instituicao),
                                          ),
                                        )
                                        .then(
                                          (value) => setState(() {}),
                                        );
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Colors.orange[300]),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _instituicaoDao.delete(instituicao.id!);
                                  });
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red[900],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: instituicoes.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => FormularioInstituicao(),
                  settings: RouteSettings(arguments: null),
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
