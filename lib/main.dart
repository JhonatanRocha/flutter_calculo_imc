import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _infoText = 'Informe seu Dados';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    pesoController.text = '';
    alturaController.text = '';

    setState(() {
      _formKey = GlobalKey<FormState>();
      _infoText = 'Informe seus Dados';
    });
  }

  void _calculateIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            'Levemente Acima do Peso (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (IMC: ${imc.toStringAsPrecision(4)})';
      } else {
        _infoText = 'Obesidade Grau III (IMC: ${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline,
                    size: 120, color: Colors.amberAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  }
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          _calculateIMC();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
