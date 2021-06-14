class Usuario {
  String codUsuario;
  String nomeUsuario;
  String cpfUsuario;
  String telefoneUsuario;
  String emailUsuario;
  String senhaUsuario;

  Usuario({this.codUsuario, this.nomeUsuario, this.cpfUsuario, this.telefoneUsuario, this.emailUsuario, this.senhaUsuario});

  static List<Usuario> fromJsonList(List list) {
    if (list == null) return null;
    return list.map<Usuario>((item) => Usuario.fromJson(item)).toList();
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    json['usu_codigo'] != null ? codUsuario = json['usu_codigo'] : codUsuario = "";
    json['usu_nome'] != null ? nomeUsuario = json['usu_nome'] : nomeUsuario = "";
    json['usu_cpf'] != null ? cpfUsuario = json['usu_cpf'] : cpfUsuario = "";
    json['usu_email'] != null ? telefoneUsuario = json['usu_email'] : telefoneUsuario = "";
    json['usu_telefone'] != null ? emailUsuario = json['usu_telefone'] : emailUsuario = "";
    json['usu_senha'] != null ? senhaUsuario = json['usu_senha'] : senhaUsuario = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usu_codigo'] = this.codUsuario ?? "";
    data['usu_nome'] = this.nomeUsuario ?? "";
    data['usu_cpf'] = this.cpfUsuario ?? "";
    data['usu_email'] = this.telefoneUsuario ?? "";
    data['usu_telefone'] = this.emailUsuario ?? "";
    data['usu_senha'] = this.senhaUsuario ?? "";
    return data;
  }
}
