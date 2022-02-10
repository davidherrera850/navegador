import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Navegador());
}
class Navegador extends StatefulWidget {
  const Navegador({ Key? key }) : super(key: key);

  @override
  _NavegadorState createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
        url: principal,
        withJavascript: true,
        withLocalStorage: true,
        withZoom: false,
        enableAppScheme: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.red,),
          actions:<Widget>[
            IconButton(onPressed: ()=>navegador.goBack(),
             icon: Icon(Icons.arrow_back)
            ),
            IconButton(onPressed: ()=>webviewProcess(),
             icon: Icon(Icons.search),
            ),
            IconButton(onPressed: ()=>navegador.goForward(),
            icon: Icon(Icons.arrow_forward)
            ),
          ],
           title: Padding(
             padding: const EdgeInsets.all(5.0),
             child: Container(
               height: 40,
               width: 800,
              decoration: 
              BoxDecoration (
                color: Colors.white,
              ),
              padding: EdgeInsets.all(2.0),
              child: TextField(
                textInputAction: TextInputAction.go,
                controller: busqueda,
                onSubmitted: (url)=>webviewProcess(),
                decoration: 
                  InputDecoration(
                    border: InputBorder.none,
                    hintText: "Escribe aqui",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
              ),
          ),
          ),  
        ),
      ),
      
    );
  }
  FlutterWebviewPlugin navegador = new FlutterWebviewPlugin();
  var busqueda = TextEditingController();
  var principal="https://www.google.es/";
  void webviewProcess(){
    setState(() {
      if (busqueda.text.contains('.')){
        principal="https://"+busqueda.text;
        FocusScope.of(context).unfocus();
      }
      else{
        principal="https://www.google.com/search?q="+busqueda.text;
        FocusScope.of(context).unfocus();
      }
      navegador.reloadUrl(principal);
    });
  }
}