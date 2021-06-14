import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_api/model/empresa_model.dart';

class ApiController {
  final linkGet = 'https://notepadeng.herokuapp.com/view/usuario/listar.php';
  final linkInserir = 'https://notepadeng.herokuapp.com/view/usuario/inserir.php';
  final linkAlterar = 'https://notepadeng.herokuapp.com/view/usuario/editar.php';
  final linkExcluir = 'https://notepadeng.herokuapp.com/view/usuario/excluir.php';

  var dio = new Dio();

  Future<List<Usuario>> getUsuarios() async {
    try {
      var response = await dio.post(linkGet);
      List<Usuario> listEmp = <Usuario>[];
      listEmp = Usuario.fromJsonList(response.data);
      return listEmp;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Usuario>> inserirUsuario(Usuario emp) async {
    var insEmp = emp.toJson();

    var response = await dio
        .post(linkInserir,
            data: insEmp,
            options: Options(
                contentType: "application/json",
                headers: {"Accept": "application/json"},
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }))
        .catchError((err) {
      print(err.toString());
    });

    // Não deve-se redirecionar no BackEnd apos uma requisição. [Gambiarra]
    if (response.statusCode == 302) {
      return getUsuarios();
    }
  }

  Future<List<Usuario>> alterarUsuario(Usuario emp) async {
    var altEmp = emp.toJson();
    var response = await dio
        .post(linkAlterar,
            data: altEmp,
            options: Options(
                contentType: "application/json",
                headers: {"Accept": "application/json"},
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }))
        .catchError((err) {
      print(err.toString());
    });

    // Não deve-se redirecionar no BackEnd apos uma requisição. [Gambiarra]
    if (response.statusCode == 302) {
      return getUsuarios();
    }
  }

  Future<List<Usuario>> excluirUsuario(Usuario emp) async {
    var excEmp = emp.toJson();

    var response = await dio
        .post(linkExcluir,
            data: excEmp,
            options: Options(
                contentType: "application/json",
                headers: {"Accept": "application/json"},
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }))
        .catchError((err) {
      print(err.toString());
    });

    // Não deve-se redirecionar no BackEnd apos uma requisição. [Gambiarra]
    if (response.statusCode == 302) {
      return getUsuarios();
    }
  }
}
