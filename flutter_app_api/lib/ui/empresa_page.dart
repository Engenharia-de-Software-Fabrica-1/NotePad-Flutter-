import 'package:flutter/material.dart';
import 'package:flutter_app_api/model/empresa_model.dart';
import 'package:flutter_app_api/ui/home_page.dart';

class EmpresaPage extends StatefulWidget {
  final Usuario emp;
  EmpresaPage({this.emp});

  @override
  _EmpresaPageState createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  final _codUsuario = TextEditingController();
  final _nomeUsuario = TextEditingController();
  final _cpfUsuario = TextEditingController();
  final _emailUsuario = TextEditingController();
  final _senhaUsuario = TextEditingController();
  final _telefoneUsuario = TextEditingController();

  Usuario _editedEmp;

  @override
  void initState() {
    super.initState();

    if (widget.emp == null) {
      _editedEmp = Usuario();
    } else {
      _editedEmp = widget.emp;
    }
    _codUsuario.text = _editedEmp.codUsuario;
    _nomeUsuario.text = _editedEmp.nomeUsuario;
    _cpfUsuario.text = _editedEmp.cpfUsuario;
    _emailUsuario.text = _editedEmp.emailUsuario;
    _senhaUsuario.text = _editedEmp.senhaUsuario;
    _telefoneUsuario.text = _editedEmp.telefoneUsuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Cadastro de Empresa'),
      backgroundColor: Colors.deepOrange[400]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _codUsuario,
              decoration: InputDecoration(labelText: "Codigo"),
              enabled: false,
              onChanged: (text) {
                _editedEmp.codUsuario = text ?? "";
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _nomeUsuario,
              decoration: InputDecoration(labelText: "Nome usuario"),
              onChanged: (text) {
                _editedEmp.nomeUsuario = text;
              },
              keyboardType: TextInputType.text,
            ),
             TextField(
              controller: _cpfUsuario,
              decoration: InputDecoration(labelText: "CPF"),
              onChanged: (text) {
                _editedEmp.cpfUsuario = text;
              },
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _telefoneUsuario,
              decoration: InputDecoration(labelText: "Telefone"),
              onChanged: (text) {
                _editedEmp.telefoneUsuario = text;
              },
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _emailUsuario,
              decoration: InputDecoration(labelText: "E-mail"),
              onChanged: (text) {
                setState(() {
                  _editedEmp.emailUsuario = text;
                });
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaUsuario,
              decoration: InputDecoration(labelText: "Senha"),
              onChanged: (text) {
                _editedEmp.senhaUsuario = text;
              },
              keyboardType: TextInputType.text,
            ),
           
            Divider(),
            InkWell(
              onTap: () {
                if (_editedEmp.codUsuario == null) {
                  if (api.inserirUsuario(_editedEmp) != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Dialog(child: Text('Erro ao inserir usuário.'));
                  }
                } else {
                  if (api.alterarUsuario(_editedEmp) != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Dialog(child: Text('Erro ao alterar o usuário.'));
                  }
                }
              },
              child: Container(
                width: 200,
                height: 60,
                color: Colors.deepOrange[400],
                child: Center(child: Text('Gravar')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
