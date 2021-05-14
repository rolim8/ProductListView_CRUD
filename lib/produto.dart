class Produto{
  String marca;
  String nome;
  double preco;
  int quantidade;

  Produto(
    this.marca, 
    this.nome, 
    this.preco, 
    this.quantidade
  );

  bool get isNotNull => null;

  @override
  String toString() {
    return "Produto [Marca: $marca, Nome: $nome, Preço: $preco, Quantidade: $quantidade]";
  }
}