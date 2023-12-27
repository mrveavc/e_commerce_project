import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/models/product_model.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future main() async {
  configureDeps();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAAyLaJ3tbB1NynmYyKZKPDEnS5y2XUkgs",
        appId: "1:259113100780:android:3bd18e7265e2ec817c4cc9",
        messagingSenderId: "",
        projectId: "e-commerce-dc3cb",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router.config(), // AutoRouter ile navigation yapmak için
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> productList = [];
  @override
  void initState() {
    setState(() {
      _getProducts();
    });
  }

  Future<void> _getProducts() async {
    var url = Uri.parse(
        'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list?country=us&lang=en&currentpage=0&pagesize=30&categories=men_all&concepts=H%26M%20MAN');

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
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productList[index].name),
            subtitle: Text('Price: \$${productList[index].price.value}'),
            trailing: Image.network(productList[index].images.first.url),
            onTap: () => {
              // {productList[index].code},
              print("product-code: ${productList[index].code}")
            },

            // Diğer ürün özellikleri burada gösterilebilir
          );
        },
      ),
    );
  }
}
