import 'package:flutter/material.dart';
import 'package:flutter_app_api/classes/api_controller.dart';
import 'package:flutter_app_api/model/empresa_model.dart';
import 'package:flutter_app_api/ui/empresa_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

ApiController api = ApiController();

class _HomePageState extends State<HomePage> {
  List<Usuario> empresas = <Usuario>[];

  @override
  void initState() {
    super.initState();
    _getAllUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange[400],
          title: Text('Lista de usuário'),
        ),
        bottomSheet: Container(
          color: Colors.deepOrange[400],
          height: 60,
          child: InkWell(
            onTap: () {
              _getAllUsuarios();
            },
            child: Center(
              child: Text('Recarregar'),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showEmpresa();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: empresas.length,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Usuario emp = empresas[index];
                    return InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                        _showEmpresa(empresa: emp);
                      },
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Codigo: ${emp.codUsuario}"),
                              Text("Nome: ${emp.nomeUsuario}"),
                              Text("CPF: ${emp.cpfUsuario}"),
                              Text("Telefone: ${emp.telefoneUsuario}"),
                              Text("Email: ${emp.emailUsuario}"),
                              Text("Senha: ${emp.senhaUsuario}"),
                                
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      api.excluirUsuario(emp) != null
                                          ? _getAllUsuarios()
                                          : AlertDialog(
                                              title: Text('ERRO'),
                                              content: Text('Ocorreu um problema ao excluir!'),
                                            );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      color: Colors.amber[700],
                                      height: 40,
                                      width: 120,
                                      child: Card(
                                        child: Center(child: Text("Excluir")),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _showEmpresa({Usuario empresa}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EmpresaPage(emp: empresa)));
  }

  void _getAllUsuarios() {
    api.getUsuarios().then((list) {
      setState(() {
        empresas = list;
      });
    });
  }
}
