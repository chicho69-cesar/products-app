import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = 'login';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),

              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    
                    const SizedBox(height: 30),
                    
                    /* Cuando envolvermos un formulario en un ChangeNotifierProvider lo que hacemos es que 
                    el formulario tendra acceso a todo lo que nos provea el provider, esto con el fin de gestionar
                    el estado global del formulario a traves de un provider */
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, RegisterScreen.routeName), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text(
                  'Crear una nueva cuenta',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Creamos la instacia del provider */
    final loginForm = Provider.of<LoginFormProvider>(context);

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Form(
        /* Hacemos bind del key del formulario con el key del provider */
        key: loginForm.formKey,

        /* Validaciones de los campos en base a la interaccion del usuario */
        autovalidateMode: AutovalidateMode.onUserInteraction,
        
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'jhon.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '') 
                  ? null 
                  : 'Escribe un correo valido';
              },
            ),

            const SizedBox(height: 30),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6) 
                  ? null 
                  : 'La contraseña no es valida';
              },
            ),

            const SizedBox(height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,

              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                
                if (!loginForm.isValidForm()) return;
                
                loginForm.isLoading = true;
                
                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
                
                if (errorMessage == null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                } else {
                  NotificationsService.showSnackBar('Error. Datos incorrectos');
                  loginForm.isLoading = false;
                }
              },

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                    ? 'Espere ...'
                    : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
