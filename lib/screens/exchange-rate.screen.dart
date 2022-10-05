import 'package:flutter/material.dart';

import 'graphic.screen.dart';

class ExchangeRateScreen extends StatelessWidget {
  static String routeName = '/home-page';
  const ExchangeRateScreen({Key? key}) : super(key: key);

// https://www.youtube.com/watch?v=SPojE9pwy6A

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        }
      ),
    );
  }
}
