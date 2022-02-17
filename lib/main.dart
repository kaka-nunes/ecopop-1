import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eco_pop/page_inicial.dart';

void main() {
  runApp(
    MaterialApp(
      home: Splash(),
    ),
  );
}

class MeusDados extends StatelessWidget {
  final TextEditingController _email_c = TextEditingController();
  final TextEditingController _nome_c = TextEditingController();
  final TextEditingController _data_nascimento_c = TextEditingController();
  final TextEditingController _instituicao_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Dados'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email_c,
            decoration: InputDecoration(
              labelText: 'email',
              hintText: '@@@',
            ),
          ),
          TextField(
            controller: _nome_c,
            decoration: InputDecoration(
              labelText: 'Nome',
              hintText: 'seu nome',
            ),
          ),
          TextField(
            controller: _data_nascimento_c,
            decoration: InputDecoration(
              labelText: 'Data de Nascimento',
              hintText: 'data',
            ),
          ),
          TextField(
            controller: _instituicao_c,
            decoration: InputDecoration(
              labelText: 'Instituição',
              hintText: 'instituição',
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

class MenuInicial extends StatelessWidget {
  const MenuInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ecoPop'),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              final Future future =
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MeusDados();
              }));
              future.then((usuario) {
                //teste
              });
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text("Meus Dados"),
              ),
            ),
          ),
          MaterialButton(
            onPressed: null,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.restore_page_outlined),
                title: Text("Projetos"),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              trailing: FlutterLogo(),
              title: Text('to fill the available space.'),
            ),
          ),
        ],
      ),
    );
  }
}

class Usuario {
  final String email;
  final String nome;
  final DateTime data_nascimento;
  final String instituicao;

  Usuario(this.email, this.nome, this.data_nascimento, this.instituicao);

  @override
  String toString() {
    return 'Usuario{nome: $nome}';
  }
}

class Instituicao {}
