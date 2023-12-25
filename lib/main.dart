import 'package:e_commerce_project/src/models/product_model.dart';
import 'package:flutter/material.dart';
// import 'package:e_commerce_project/src/api/product_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Product> productList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getProducts();
  // }

  // Future<void> getProducts() async {
  //   productList = await ProductApi.getProducts();
  // }

  List<Product> productList = [];

  Future<void> _getProducts() async {
    var url = Uri.parse(
        'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list?country=us&lang=en&currentpage=0&pagesize=30&categories=sportswear&concepts=H%26M%20MAN');

    var response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': 'c1c4c50604mshde0963d18280fdfp13a0d1jsneb65f17ad75d',
        'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      productList = parseProducts(responseBody['results']);

      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List<Product> parseProducts(dynamic collection) {
    List<Product> products = [];

    if (collection != null) {
      for (var product in collection) {
        products.add(Product.fromJson(product));
      }
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: productList.isNotEmpty
          ? ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productList[index].name),
                  subtitle: Text('Price: \$${productList[index].price.value}'),
                  trailing: Image.network(productList[index].images.first.url),
                  // Diğer ürün özellikleri burada gösterilebilir
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getProducts,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
