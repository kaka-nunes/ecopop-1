import 'package:eco_pop/instituicao/cadastro_instituicao.dart';
import 'package:eco_pop/instituicao/instituicao.dart';
import 'package:eco_pop/instituicao/instituicao_dao.dart';
import 'package:eco_pop/utils/network_status_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class ListarInstituicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListarInstituicaoState();
  }
}

class ListarInstituicaoState extends State<ListarInstituicao> {
  final InstituicaoDao _instituicaoDao = InstituicaoDao();
  @override
  Scaffold build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Instituição'),
      ),
      body: FutureBuilder<List<Instituicao>>(
          initialData: [],
          future: _instituicaoDao.findAll(),
          builder: (context, snapshot) {
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
                                  setState(()  {
                                    _instituicaoDao.delete(instituicao);
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
          }
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
