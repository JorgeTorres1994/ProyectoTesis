/*import 'package:app_web_proyecto_final/inner_screens/LoginScreen.dart';
import 'package:app_web_proyecto_final/widgets/firebase_contss.dart';
import 'package:app_web_proyecto_final/widgets/primary_button.dart';
import 'package:app_web_proyecto_final/widgets/textos_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../widgets/login_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Textos a ingresar (correo y contraseña)
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final celularController = TextEditingController();
  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Método para validar si todos los campos están completos
  bool validarCampos() {
    if (nombreController.text.trim().isEmpty ||
        apellidosController.text.trim().isEmpty ||
        celularController.text.trim().isEmpty ||
        correoController.text.trim().isEmpty ||
        usuarioController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      showErrorMessage("Por favor, completa todos los campos.");
      return false;
    }
    return true;
  }

  //REGISTRAR USUARIO

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //CREAR USUARIO
  Future<void> registrarUsuario() async {
    try {
      if (validarCampos()) {
        if (passwordConfirmed()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: correoController.text.trim(),
            password: passwordController.text.trim(),
          );

          final User? user = authInstance.currentUser;

          if (user != null) {
            addUserDetails(
              user.uid,
              nombreController.text.trim(),
              apellidosController.text.trim(),
              celularController.text.trim(),
              correoController.text.trim(),
              usuarioController.text.trim(),
              passwordController.text.trim(),
            );

            // Mostrar mensaje de éxito sin redirigir automáticamente
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registro Exitoso'),
                  content: Text(
                      '¡Usuario registrado exitosamente! - Ingresando al Dashboard de Usuarios'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            showErrorMessage("Hubo un problema al registrar el usuario.");
          }
        } else {
          showErrorMessage("La contraseña no es igual, intentalo otra vez");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage("La contraseña proporcionada es demasiado débil");
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage("La cuenta ya existe para ese correo electrónico");
      }
    } catch (e) {
      print(e);
    }
  }

  Future addUserDetails(String userId, String nombres, String apellidos,
      String celular, String correo, String usuario, String password) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'userId': userId, // Agregar el ID del usuario
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'correo': correo,
      'usuario': usuario,
      'contraseña': password,
      'fecha_registro': FieldValue.serverTimestamp(),
      'isAdmin': false,
    });
  }

  void errorEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Correo incorrecto'),
          );
        });
  }

  void errorPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Contraseña incorrecta'),
          );
        });
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              //buildIndicator(),
              Center(
                child: Text(
                  'Registra tus Datos',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/OIP.gZ77IHu7QXxorpEpxYLVAQHaKC?rs=1&pid=ImgDetMain'),
                      radius: 70,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),

              LogInForm(
                controller: nombreController,
                hintText: 'Nombre',
                obscureText: false,
              ),

              SizedBox(
                height: 20,
              ),

              LogInForm(
                controller: apellidosController,
                hintText: 'Apellidos',
                obscureText: false,
              ),

              SizedBox(
                height: 20,
              ),

              IntlPhoneField(
                controller: celularController,
                decoration: InputDecoration(
                  labelText: 'Celular',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'AR',
                onChanged: (phone) {
                  TextosWidget(
                    text: phone.completeNumber,
                    color: Colors.white,
                    textSize: 20,
                    isTitle: true,
                  );
                },
              ),

              LogInForm(
                controller: correoController,
                hintText: 'Correo',
                obscureText: false,
              ),

              SizedBox(
                height: 15,
              ),

              LogInForm(
                controller: usuarioController,
                hintText: 'Usuario',
                obscureText: false,
              ),

              SizedBox(
                height: 20,
              ),

              LogInForm(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              SizedBox(
                height: 20,
              ),

              LogInForm(
                controller: confirmPasswordController,
                hintText: 'Confirmar Contraseña',
                obscureText: true,
              ),

              SizedBox(
                height: 40,
              ),

              PrimaryButton(
                text: 'Registrar',
                onTap: () {
                  registrarUsuario();
                },
              ),

              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Ya tienes cuenta?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: const Text(
                      '¡Ingresa ahora!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

*/

import 'package:app_web_proyecto_final/inner_screens/LoginScreen.dart';
import 'package:app_web_proyecto_final/widgets/primary_button.dart';
import 'package:app_web_proyecto_final/widgets/textos_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final celularController = TextEditingController();
  final correoController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;

  bool validarCampos() {
    if (nombreController.text.trim().isEmpty ||
        apellidosController.text.trim().isEmpty ||
        celularController.text.trim().isEmpty ||
        correoController.text.trim().isEmpty ||
        usuarioController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      showErrorMessage("Por favor, completa todos los campos.");
      return false;
    }
    return true;
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  Future<void> registrarUsuario() async {
    try {
      if (validarCampos()) {
        if (passwordConfirmed()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: correoController.text.trim(),
            password: passwordController.text.trim(),
          );

          final User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            addUserDetails(
              user.uid,
              nombreController.text.trim(),
              apellidosController.text.trim(),
              celularController.text.trim(),
              correoController.text.trim(),
              usuarioController.text.trim(),
              passwordController.text.trim(),
            );

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registro Exitoso'),
                  content: Text(
                      '¡Usuario registrado exitosamente! - Ingresando al Dashboard de Usuarios'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            showErrorMessage("Hubo un problema al registrar el usuario.");
          }
        } else {
          showErrorMessage("La contraseña no es igual, inténtalo de nuevo");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage("La contraseña proporcionada es demasiado débil");
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage("La cuenta ya existe para ese correo electrónico");
      }
    } catch (e) {
      print(e);
    }
  }

  Future addUserDetails(String userId, String nombres, String apellidos,
      String celular, String correo, String usuario, String password) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'userId': userId,
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'correo': correo,
      'usuario': usuario,
      'contraseña': password,
      'fecha_registro': FieldValue.serverTimestamp(),
      'isAdmin': false,
    });
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Registra tus Datos',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://th.bing.com/th/id/OIP.gZ77IHu7QXxorpEpxYLVAQHaKC?rs=1&pid=ImgDetMain'),
                        radius: 70,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                buildTextField(nombreController, 'Nombre'),
                SizedBox(height: 20),
                buildTextField(apellidosController, 'Apellidos'),
                SizedBox(height: 20),
                buildPhoneField(),
                buildTextField(correoController, 'Correo'),
                SizedBox(height: 15),
                buildTextField(usuarioController, 'Usuario'),
                SizedBox(height: 20),
                buildPasswordField(passwordController, 'Contraseña'),
                SizedBox(height: 20),
                buildPasswordField(
                    confirmPasswordController, 'Confirmar Contraseña'),
                SizedBox(height: 40),
                PrimaryButton(
                  text: 'Registrar',
                  onTap: () {
                    registrarUsuario();
                  },
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: const Text(
                        '¡Ingresa ahora!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey[800],
        ),
      ),
    );
  }

  Widget buildPasswordField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        obscureText: obscurePassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            child: Icon(
              obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: IntlPhoneField(
        controller: celularController,
        decoration: InputDecoration(
          labelText: 'Celular',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey[800],
          filled: true,
        ),
        initialCountryCode: 'AR',
        onChanged: (phone) {
          TextosWidget(
            text: phone.completeNumber,
            color: Colors.white,
            textSize: 20,
            isTitle: true,
          );
        },
      ),
    );
  }
}
