import 'package:flutter/material.dart';
import 'produto.dart';

class ProdutoPage extends StatefulWidget {
  final String titulo;
  final Produto product;

  const ProdutoPage({this.titulo, this.product});
  
  @override
  _ProdutoPageState createState() => _ProdutoPageState(titulo, product);
}

class _ProdutoPageState extends State<ProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  String _marca = '';
  String _nome = '';
  double _preco = 0.0;
  int _quantidade = 0;

  String titulo;
  Produto product;

  _ProdutoPageState(String titulo, Produto product)
    : this.titulo=titulo, 
      this.product=product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Center(
          child: Text(
            widget.titulo,
            style: TextStyle(color: Colors.yellowAccent[400]),
          )
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            TextFormField(
              initialValue: product == null ? null : product.marca,
              decoration: InputDecoration(labelText: 'Marca'),
              keyboardType: TextInputType.name,
              onSaved: (marca) {_marca = marca;},
              validator: validateMarca, 
              textAlign: TextAlign.left
            ),
            
            TextFormField(
              initialValue: product == null ? null : product.nome,
              decoration: InputDecoration(labelText: 'Nome'),
              keyboardType: TextInputType.name,
              onSaved: (nome) {_nome = nome;},
              validator: validateNome, 
              textAlign: TextAlign.left
            ),
            
            TextFormField(
              initialValue: product == null ? null : '${product.preco}',
              decoration: InputDecoration(labelText: 'Preco'),
              keyboardType: TextInputType.number, 
              onSaved: (preco) {_preco = double.parse(preco);},
              validator: validatePreco, 
              textAlign: TextAlign.left
            ),
            
            TextFormField(
              initialValue: product == null ? null : '${product.quantidade}',
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number, 
              onSaved: (quantidade) {_quantidade = int.parse(quantidade);},
              validator: validateQtd, 
              textAlign: TextAlign.left
            ),

            Container(
              margin: EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text('Confirmar'),

                style: ElevatedButton.styleFrom(
                  primary: Colors.purple[900],
                  onPrimary: Colors.yellow,
                ),

                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();

                    Navigator.pop(
                      context, Produto(_marca, _nome, _preco, _quantidade)
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateMarca(String marca){
    if(marca.isEmpty){
      return ("campo não pode ser vazio");
    }else if(marca.length < 3){
      return ("Marca deve ter 3 ou mais caracteres");
    }
    return null; 
  }

  String validateNome(String nome){
    if(nome.isEmpty){
      return ("campo não pode ser vazio");
    }else if(nome.length < 3){
      return ("Nome deve ter acima de 3 caracteres");
    }
    return null; 
  }

  String validatePreco(String preco){
    String pattern = ('([]+(\[]+)?)');
    
    if(preco.isEmpty){
      return ("campo não pode ser vazio");
    }else if (double.parse(preco) < 0) {
      return "campo inválido, tente um valor positivo";
    }RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(preco)) {
      return "$preco não é um preço válido";
    }
    return null;
  }

  String validateQtd(String quantidade){
    String pattern = (r'[+-]?([0-9]*[,.])?[0-9]+');
    
    if(quantidade.isEmpty){
      return ("campo não pode ser vazio");
    }else if (int.parse(quantidade) < 0) {
      return "Quantidade Invalida, tente um valor positivo";
    }RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(quantidade)) {
      return "$quantidade não é uma quantidade válido";
    }
    return null;
  }
}