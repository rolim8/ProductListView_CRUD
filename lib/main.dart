import 'package:flutter/material.dart';
import 'package:product_app/pages/ProdutoListViewPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProdutoListViewPage(),
    );
  }
}
