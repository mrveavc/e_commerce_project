import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/view_model/product_view_model.dart';
import 'package:e_commerce_project/firebase_options.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/ui/view/pages/home_page.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  configureDeps();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Kasva',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HomePage(),

      body: ChangeNotifierProvider(
        create: (BuildContext context) => ProductViewModel(),
        child: HomePage(),
      ),
    );
  }
}
