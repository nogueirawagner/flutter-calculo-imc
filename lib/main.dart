import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _info = "Informe seus dados";
    });
  }

  void _calcular() {
    setState(() {
      if (_formKey.currentState.validate()) {
        double peso = double.parse(weightController.text);
        double altura = double.parse(heightController.text) / 100;

        double imc = (peso / (altura * altura));
        if (imc < 18.6)
          _info = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
        else if (imc >= 18.6 && imc < 24.9)
          _info = "Peso ideal (${imc.toStringAsPrecision(3)})";
        else if (imc >= 24.9 && imc < 29.9)
          _info = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
        else if (imc >= 29.9 && imc < 34.9)
          _info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
        else if (imc >= 34.9 && imc < 39.9)
          _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
        else if (imc >= 40)
          _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline,
                        size: 120.0, color: Colors.green),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira seu Peso";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso em kg",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        controller: weightController),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua altura";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura cm",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        controller: heightController),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: _calcular,
                              child: Text("Calcular",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0)),
                              color: Colors.green)),
                    ),
                    Text(_info,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0))
                  ]),
            )),
      ),
    );
  }
}
