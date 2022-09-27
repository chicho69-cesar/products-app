// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  /* Creamos un key global para tener referencia con el widget que tendra acceso a esta key
  y de esta forma poder gestionar su estado en particular, en este caso hacer las validaciones del formulario */
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /* Variables para controlar el estado del formulario de login */
  String email = '';
  String password = '';

  /* Controlar el loading del inicio de sesion */
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /* Validar los campos del formulario en base a los validators que tengan los mismos */
  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }
}
