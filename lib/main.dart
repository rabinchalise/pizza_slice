import 'package:flutter/material.dart';
import 'package:pizzaslice/ui/home/tabs/pizza/remix_pizza.dart';

void main() {
  runApp(const FastFoodApp());
}

class FastFoodApp extends StatelessWidget {
  const FastFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const RemixPizza(),
    );
  }
}
