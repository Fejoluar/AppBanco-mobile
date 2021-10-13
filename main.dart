import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criando transferências'),) ,
        body: Column(
            children: <Widget> [
              Editor(
                  controlador: _controladorCampoNumeroConta,
                  rotulo: 'Numero da Conta',
                  dica: '0000'
              ),
              Editor(
                  controlador: _controladorCampoValor,
                  rotulo: 'Valor',
                  dica: '0.00',
                  icone: Icons.monetization_on
              ),
              ElevatedButton(
                  child: Text('Confirmar'),
                  onPressed: () => _criaTransferencia(),
              )
            ],
            )
    );
  }

  void _criaTransferencia() {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if(numeroConta != null && valor != null){
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;


  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
            fontSize: 24.0
        ),
        decoration: InputDecoration (
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}


class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencias(Transferencia(100.0, 1000)),
          ItemTransferencias(Transferencia(100.0, 1000)),
          ItemTransferencias(Transferencia(100.0, 1000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencias extends StatelessWidget {

  final Transferencia _transferencia;

  ItemTransferencias(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.agencia.toString()),
      ),
    );
  }
}

class Transferencia {

  final double valor;
  final int agencia;

  Transferencia(this.valor,this.agencia);

  @override
  String toString() {
    return 'Transferencia{agencia: $agencia, valor:$valor}';
  }
}