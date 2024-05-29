import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolControler = TextEditingController();
  TextEditingController gasolinaControler = TextEditingController();
  String _resultado = 'Informe os valores';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    alcoolControler.text = '';
    gasolinaControler.text = '';
    setState(() {
      _resultado = 'Informe os valores';
    });
    _formKey = GlobalKey<FormState>();
  }

  void _calculaCombustivelIdeal() {
    setState(() {
      double vAlcool = double.parse(alcoolControler.text.replaceAll(',', '.'));
      double vGasolina =
          double.parse(gasolinaControler.text.replaceAll(',', '.'));
      double proporcao = vAlcool / vGasolina;

      _resultado =
          (proporcao < 0.7) ? "Abasteça com Alcool" : "Abasteça com Gasolina";

      // if (proporcao < 0.7) {
      //   _resultado = 'Abasteça com Alcool';
      // } else {
      //   _resultado = 'Abasteça com gasolina';
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alcool ou gasolina? ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                _reset();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 140.0,
                color: Colors.blue[900],
              ),
              TextFormField(
                controller: alcoolControler,
                validator: (value) =>
                    value!.isEmpty ? "informe o valor do Alcool" : null,
                decoration: InputDecoration(
                    labelText: 'Valor do Alcool',
                    labelStyle: TextStyle(color: Colors.blue[900])),
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 26.0,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: gasolinaControler,
                validator: (value) =>
                    value!.isEmpty ? 'digite o valor da Gasolina' : null,
                decoration: InputDecoration(
                    labelText: 'Valor da gasolina',
                    labelStyle: TextStyle(color: Colors.blue[900])),
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 26.0,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                        _calculaCombustivelIdeal();
                    },
                    child: Text(
                      "verificar",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue[900], fontSize: 26.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
