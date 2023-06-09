import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cadastro.dart';
import 'cadastro1.dart';
import 'classes/usuario.dart';
import 'telaInicial.dart';
import 'telaLogin.dart';
import 'package:http/http.dart' as http;

class TelaCadastro1 extends StatefulWidget {
  @override
  _TelaCadastro1State createState() => _TelaCadastro1State();
}

class _TelaCadastro1State extends State<TelaCadastro1> {
  Usuario? _usuario;
  bool _cadastrarPressed =
      false; // Variável de controle para verificar se o botão foi pressionado
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Recupere os dados passados pela rota
    final routeArgs = ModalRoute.of(context)!.settings.arguments;
    _usuario = routeArgs as Usuario;
  }

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaNovamenteController =
      TextEditingController();
  Widget buildCpf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CPF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(132, 109, 109, 109),
                Color.fromARGB(10, 0, 0, 0)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: TextField(
            controller: _cpfController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              hintText: 'Ex: 000.000.00-00',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CEP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(132, 109, 109, 109),
                Color.fromARGB(10, 0, 0, 0)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: TextField(
            controller: _cepController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              hintText: 'Ex: 45190-000',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSenha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(132, 109, 109, 109),
                Color.fromARGB(10, 0, 0, 0)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: TextField(
            controller: _senhaController,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              hintText: '********',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSenhaNovamente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha Novamente',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(132, 109, 109, 109),
                Color.fromARGB(10, 0, 0, 0)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: TextField(
            controller: _senhaNovamenteController,
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              hintText: '********',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCadastrarBtn() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: Color(0xcc1FF5BE),
            onPrimary: Colors.white,
          ),
          onPressed: _cadastrarPressed
              ? null
              : () {
                  setState(() {
                    _cadastrarPressed =
                        true; // Desativar o botão após o primeiro clique
                  });

                  _usuario?.cep = _cepController.text;
                  _usuario?.cpf = _cpfController.text;
                  _usuario?.senha = _senhaController.text;
                  _makeCadastroUsuario(_usuario!);
                },
          child: Text(
            'Cadastrar',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _makeCadastroUsuario(Usuario _usuario) async {
    print(_usuario);
    final String url =
        'https://mapcidade-api.ryan-araujoara1.repl.co/mapcidade/v1/usuarios'; // Substitua pela sua URL

    try {
      final Dio dio = Dio();
      final response = await dio.post(url, data: _usuario);

      // Acesso aos dados retornados pela API
      if (response.statusCode == 201) {
        Navigator.of(context).pushReplacementNamed('/cadastradoSucesso');
      } else {
        print('Erro durante a requisição: Algum erro com o servidor');
      }
      // Faça algo com os dados aqui
    } catch (error) {
      // Trate os erros de requisição
      print('Erro durante a requisição: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 32, 32, 32),
                      Color.fromARGB(255, 32, 32, 32),
                      Color.fromARGB(255, 32, 32, 32),
                      Color.fromARGB(255, 32, 32, 32),
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 110),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Quase lá...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25),
                      buildCpf(),
                      SizedBox(height: 15),
                      buildCep(),
                      SizedBox(height: 15),
                      buildSenha(),
                      SizedBox(height: 15),
                      buildSenhaNovamente(),
                      SizedBox(height: 15),
                      buildCadastrarBtn(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
