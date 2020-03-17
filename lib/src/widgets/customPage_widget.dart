import 'package:flutter/material.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import '../widgets/dialog_widget.dart';

class CustomWidgetPage extends StatefulWidget {

  final Widget body;
  final Image image;
  final String tittle;
  final String subtittle;
  final String buttonText;
  final Function pullFunction;
  final String aditionalText;
  final Color aditionalTextColor;
  final Function backButtonFunction;
  final Function whenIsValid;
  final Function onPressedButton;
  final Widget footerWidget;
  final bool disableBackButton;

  CustomWidgetPage({
    @required this.body,
    @required this.image,
    @required this.tittle,
    @required this.subtittle,
    @required this.buttonText,
    this.pullFunction,
    this.backButtonFunction,
    this.aditionalText,
    this.aditionalTextColor,
    this.whenIsValid,
    this.onPressedButton,
    this.footerWidget,
    this.disableBackButton = false
  });

  @override
  _CustomWidgetPageState createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage> {

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.disableBackButton
      ? null
      : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: widget.backButtonFunction == null
                     ? () => Navigator.pop(context)
                     : widget.backButtonFunction
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _loginHeader(),
            _loginBody(),
            _loginFooter(context)
          ],
        ),
      ),
    );
  }

  Widget _loginHeader() {
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          child: widget.image
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                widget.tittle,
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 10.0),
              Text(
                  widget.subtittle,
                  style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  textAlign: TextAlign.center,
              ),
              widget.aditionalText != null 
              ?
              Text(widget.aditionalText,
                style: TextStyle(
                  color: widget.aditionalTextColor,
                  fontSize: 20.0
                )
              )
              : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _loginBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        child: widget.body
      ),
    );
  }

  Widget _loginFooter( BuildContext context ) {
    return  Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                widget.buttonText,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: widget.onPressedButton == null
            ? () async {

              bool isValid = false;
            
              if ( formKey.currentState.validate() ) isValid = true;

              if ( widget.whenIsValid != null && isValid ) {
                widget.whenIsValid();
              }

              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.all(0),
                    content: !isValid
                    ? 
                    CustomAlertDialog(
                      title: 'OH NO!',
                      text: 'Revisa bien los campos.',
                      image: Image.asset('assets/ohno.png'),
                      primaryColor: Color(0xffE05A61),
                      buttonText: 'OK',
                    )
                    :
                    widget.pullFunction()
                  );
                }
              );
            }
            :
            widget.onPressedButton
          ),
          widget.footerWidget != null
          ? widget.footerWidget
          : Container()
        ],
      ),
    );
  }
}
