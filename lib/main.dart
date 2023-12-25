import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/models/product_model.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
// import 'package:e_commerce_project/src/models/product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:e_commerce_project/src/api/product_api.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();

//   // await Firebase.initializeApp();
//   runApp(const MyApp());
// }
Future main() async {
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



// @RoutePage()
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
  // List<Product> productList = [];

  // Future<void> _getProducts() async {
  //   var url = Uri.parse(
  //       'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list?country=us&lang=en&currentpage=0&pagesize=30&categories=sportswear&concepts=H%26M%20MAN');

  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'X-RapidAPI-Key': 'c1c4c50604mshde0963d18280fdfp13a0d1jsneb65f17ad75d',
  //       'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     var responseBody = json.decode(response.body);

  //     productList = parseProducts(responseBody['results']);

  //     setState(() {});
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }

  // List<Product> parseProducts(dynamic collection) {
  //   List<Product> products = [];

  //   if (collection != null) {
  //     for (var product in collection) {
  //       products.add(Product.fromJson(product));
  //     }
  //   }

  //   return products;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Flutter Firebase',

  // routes: {
  //   '/': (context) => const SplashScreen(
  //         // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
  //         child: LoginPage(),
  //       ),
  //   '/login': (context) => const LoginPage(),
  //   '/signUp': (context) => SignUpPage(),
  //   '/home': (context) => const HomePage(),
  // },
  // AutoRouter ile navigation yapmak için
  // );
  // return Scaffold(
  //   appBar: AppBar(
  //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //     title: Text(widget.title),
  //   ),
  //   body: productList.isNotEmpty
  //       ? ListView.builder(
  //           itemCount: productList.length,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               title: Text(productList[index].name),
  //               subtitle: Text('Price: \$${productList[index].price.value}'),
  //               trailing: Image.network(productList[index].images.first.url),
  //               // Diğer ürün özellikleri burada gösterilebilir
  //             );
  //           },
  //         )
  //       : const Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //   floatingActionButton: FloatingActionButton(
  //     onPressed: _getProducts,
  //     tooltip: 'Increment',
  //     child: const Icon(Icons.add),
  //   ),
  // );
//   }
// }
