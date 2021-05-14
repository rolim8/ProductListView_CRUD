import 'package:flutter/material.dart';
import 'package:product_app/pages/produto_page.dart';
import 'produto.dart';

class ProdutoListViewPage extends StatefulWidget {
  @override
  _ProdutoListViewPageState createState() => _ProdutoListViewPageState();
}

class _ProdutoListViewPageState extends State<ProdutoListViewPage> {
  List<Produto> produtos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Center(
          child: Text("Lista de Produtos",
            style: TextStyle(color: Colors.yellow[400]),
          )
        ),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (produtos.isNotEmpty && produtos.length > 0) {
            return listViewLista(context);
          }
          return Center(
            child: Text("Lista Vazia",
              style: TextStyle(fontSize: 15.9, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add, color: Colors.yellowAccent),
        label: const Text('Adicionar'),
        foregroundColor: Colors.yellowAccent,
        backgroundColor: Colors.purple[900],
        onPressed: () {_novoProduto(context);},
      ),
    );
  }

  Widget listViewLista(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (BuildContext context, int i) {
        if (produtos.isNotEmpty && produtos.length > 0){
          return ListTile(
            title: Text(
              produtos[i].nome,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              produtos[i].marca,
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text("Preço: " + produtos[i].preco.toString()),
            onLongPress: () {
              String titulo = produtos[i].nome;
              _alertDialogExcluir(context, titulo, i);
            },
            onTap: () {
              String titulo = produtos[i].nome;
              _alertDialogEditar(context, titulo, i);
            },
          );
        }
        return Center(child: Text("Lista Vazia"),); 
      }
    );
  }

  Future <void> _novoProduto(BuildContext context) async {
    String envio = "Novo Produto";
    Produto product =
        await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => ProdutoPage(titulo: envio),
    ));
    
    setState(() {
      if(product != null){
        produtos.add(product);
        _snackBarNovoProduto();
      }
    });
  }

  Future<void> _alterarProduto(
      BuildContext context, Produto produto, int i) async {
    String envio = "Alterando Produto";
    Produto product =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProdutoPage(
        titulo: envio,
        product: produto,
      );
    }));
    setState(() {
      if(product != null){
        produtos.removeAt(i);
        produtos.add(product);
    
        _snackBarAlterarProduto();
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
      }
    });
    Navigator.pop(context);
  }

  _snackBarNovoProduto() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.save),
          SizedBox(
            width: 20,
          ),
          Text("Produto salvo com exito!"),
        ],
      ),
      backgroundColor: Colors.greenAccent,
      duration: Duration(seconds: 3),
    ));
  }

  _snackBarAlterarProduto() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.edit, color: Colors.black),
          SizedBox(
            width: 20,
          ),
          Text("Produto alterado com exito!"),
        ],
      ),
      backgroundColor: Colors.greenAccent,
      duration: Duration(seconds: 3),
    ));
  }

  _snackBarDeletarProduto() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(Icons.delete, color: Colors.black),
          SizedBox(
            width: 20,
          ),
          Text("Produto Excluido"),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }

  _alertDialogEditar(BuildContext context, String title, int i) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar"),
          content: Text("Deseja realmente alterar o produto, $title ?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Produto produto = produtos[i];
                  setState(() {
                    Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
                      return ProdutoPage(
                        product: produto,
                      );
                    }));
                  });
                  _alterarProduto(context, produto, i);
                },
                child: Text("Confirmar")),
            ElevatedButton(
              onPressed: () {Navigator.pop(context);},
              child: Text("Cancelar"),
            )
          ],
        );
      }
    );
  }

  _alertDialogExcluir(BuildContext context, String title, int i) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Deletar"),
          content: Text("Deseja realmente deletar o produto, $title ?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                produtos.removeAt(i);
                setState(() {
                  Navigator.pop(context);
                });
                _snackBarDeletarProduto();
              },
              child: Text("Confirmar")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            )
          ],
        );
      }
    );
  }
}