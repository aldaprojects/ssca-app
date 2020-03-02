

String validateEmail( String email ) {

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(email) || email.length == 0 ? null : 'Ingresa un correo válido';
}

String validatePassword( String password ) {

  return password.length > 0 && password.length < 6 ? 'Mínimo 6 caracteres' : null;
}

String validateName( String name ) {
  return name.length>0 ? null : 'El campo no debe estar vacio';
}

String validateBothPassword ( String psw1, String psw2 ) {
  return psw1 == psw2 ? null : 'Las contraseñas no coinciden';
}