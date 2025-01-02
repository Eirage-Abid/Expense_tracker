import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_expense_tracker/expense_provider.dart';

//import 'expense_provider.dart';
import 'home_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('expenses'); // Open a Hive box for expenses
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
