import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager_clone/bottomNav/bottomNav.dart';
import 'package:moneymanager_clone/controller/auth_controller.dart';
import 'package:moneymanager_clone/controller/transactions_controller.dart';
import 'package:moneymanager_clone/services/shared_preferences/user_creds.dart';
import 'package:moneymanager_clone/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(
    () => AuthController(),
  );
  Get.lazyPut(
    () => TransactionsController(),
  );
  token = await UserCredintailStore().getJwt();
  // var directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // Hive.registerAdapter(IncomeModelAdapter());
  // await Hive.openBox<IncomeModel>(income);
  // Hive.registerAdapter(SetLimitModelAdapter());
  // await Hive.openBox<SetLimitModel>(setlimit);
  runApp(MyApp());
}

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
String? token;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      title: 'Money Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token == null ? LoginPage() : MyBottomNavBar(),
    );
  }
}
