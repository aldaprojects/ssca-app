import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/group_model.dart';
import 'package:sockets2/src/providers/grupo_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as resetValidator;
import 'package:sockets2/src/widgets/customPage_widget.dart';
import '../widgets/pull_widget.dart';


class CrearGrupoPage extends StatelessWidget {

  final TextEditingController _grupoController  = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();
  
  @override
  Widget build(BuildContext context) {

    final grupoProvider = Provider.of<GrupoProvider>(context);
    Group grupo;

    return CustomWidgetPage(
      image: Image.asset('assets/grupo.png'),
      tittle: 'Crear Grupo',
      subtittle: 'Después podrás invitar a personas',
      body: Column(
        children: <Widget>[
            TextFormField(
            controller: _grupoController,
            decoration: InputDecoration(
              labelText: 'Nombre del grupo',
              suffixIcon: Icon(FontAwesomeIcons.users)
            ),
            validator: resetValidator.validateName,
            autovalidate: true,
          ),
          SizedBox(height: 50.0)
        ],
      ),
      buttonText: 'Continuar',
      whenIsValid: () {
        grupo = new Group(
          name: _grupoController.text,
          fechaCreacion: DateTime.now()
        );
      },
      pullFunction: () {
        return Pull(
          future: grupoProvider.crearGrupo(grupo, prefs.token),
          navigator: () => Navigator.pop(context),
        );
      },
    );
  }
}
