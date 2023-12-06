import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:proyecto_final/src/widgets/input_text_widget.dart';

//para peticiones

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //metodo de obtencion de respuesta
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final url = Uri.parse('https://fakestoreapi.com/auth/login');

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  //widget error

  void _errordialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error inicio de secion"),
          content: const Text("Correo o contraseña incorrecto"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void saveUsuario() async {
    final header = {"Content-type": "application/json; charset=utf-8"};

    final usuario = {
      "username": _emailController.text,
      "password": _passwordController.text,
    };

    final respuesta =
        await http.post(url, headers: header, body: jsonEncode(usuario));

    if (respuesta.statusCode == 200) {
      final token = jsonDecode(respuesta.body)['token'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

//limpia controladores

      _emailController.clear();
      _passwordController.clear();

      //navega a la ruta home
      Navigator.pushNamed(context, '/home');
    } else {
      _errordialog("Correo o Contraseña incorrecto");
    } //fin else
  }

  //final future

  //estatus
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      // El usuario ya inició sesión, navegar a la ruta Home
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      "Bienvenido",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    //TextField Correo

                    SizedBox(
                      height: 70,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInput(
                            controller: _emailController,
                            hintText: "Correo",
                            icon: Icons.email),
                      ),
                    ),

                    //TextField Contraseña

                    SizedBox(
                      height: 70,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomInput(
                          controller: _passwordController,
                          hintText: 'Contraseña',
                          icon: Icons.lock,
                          obscure: true,
                        ),
                      ),
                    ),

                    //Boton SingIng

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                              onPressed: () {
                                //boton registrarse
                                //VERIFICO
                                if (_emailController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      action: SnackBarAction(
                                        label: 'Acción',
                                        onPressed: () {},
                                      ),
                                      showCloseIcon: true,
                                      duration: const Duration(seconds: 5),
                                      content: const Text(
                                          'El correo es obligatorio'),
                                    ),
                                  );

                                  return;
                                }
                                //navego a la ruta
                                saveUsuario();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  width: 250,
                                  child: const Text(
                                    "Iniciar Sesión",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.5,
                                    ),
                                  ),
                                ),
                              ))),
                    ),

                    //Botones "Olvide la contraseña y registrarme"

                    //Olivde la contrasñe

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Olvide la contraseña",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )),

                        //datos

                        //Boton Registraeme
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Registrarme ahora",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "O continuar con ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset('assets/facebook_logo.png'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset('assets/google_logo.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
