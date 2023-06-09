import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cadastro.dart';
import 'cadastro1.dart';
import 'telaInicial.dart';
import 'telaLogin.dart';
import 'chamados.dart';
import 'package:http/http.dart' as http;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool isRememberMe = false;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
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
          child: Center(
            child: TextField(
              controller: _loginController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.email,
                  color: Color.fromARGB(255, 245, 245, 245),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
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
          alignment: Alignment.center,
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
          child: Center(
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Senha',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLembrarAsenha() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Lembrar a senha',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: Color(0xcc2727F2),
            onPrimary: Colors.white,
          ),
          onPressed: () {
            print('Entrar Pressionado');
            _submitLogin();
          },
          child: Text(
            'Entrar',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildNovoBtn() {
    return GestureDetector(
      onTap: () {
        print("Sing up Pressed");
        Navigator.of(context).pushNamed('/cadastro');
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Novo?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  void _submitLogin() {
    final String login = _loginController.text;
    final String password = _passwordController.text;

    _makeLoginRequest(login, password);
  }

  Future<void> _makeLoginRequest(String login, String password) async {
    print(login);
    print(password);
    final String url =
        'https://mapcidade-api.ryan-araujoara1.repl.co/mapcidade/v1/usuarios?email=$login&senha=$password'; // Substitua pela sua URL

    try {
      final Dio dio = Dio();
      final response = await dio.get(url);

      // Acesso aos dados retornados pela API
      if (response.statusCode == 200) {
        // Salvar o email no SharedPreferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('email', login);

        Navigator.of(context).pushReplacementNamed('/telaInicial');
      } else {
        print('Erro durante a requisição: senha/email incorreta');
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MapCidade',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Uma cidade sem buracos, um futuro melhor.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      buildEmail(),
                      SizedBox(height: 20),
                      buildSenha(),
                      SizedBox(height: 20),
                      buildLembrarAsenha(),
                      SizedBox(height: 40),
                      buildLoginBtn(),
                      SizedBox(height: 60),
                      buildNovoBtn(),
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
