

String validateEmail( String email ) {

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(email) ? null : 'Ingresa un correo válido';
}

String validateUserName( String username ) {
  return username.length < 5 ? 'Mínimo 5 caracteres' : null;
}

String validatePassword( String password ) {

  return password.length < 6 ? 'Mínimo 6 caracteres' : null;
}

String validateName( String name ) {
  return name.length>0 ? null : 'El campo no debe estar vacio';
}

String validateBothPassword ( String psw1, String psw2 ) {
  return psw1 == psw2 && psw2.length != 0 ? null : 'Las contraseñas no coinciden';
}