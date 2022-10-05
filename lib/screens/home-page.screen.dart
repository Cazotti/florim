import 'package:flutter/material.dart';

import 'exchange-rate.screen.dart';
import 'graphic.screen.dart';

class HomePageScreen extends StatelessWidget {
  static String routeName = '/home-page';
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.compare_arrows_outlined)),
            Tab(icon: Icon(Icons.list_alt_outlined)),
            Tab(icon: Icon(Icons.graphic_eq_rounded)),
          ]),
          title: const Text('Conversor'),
        ),
        body: TabBarView(
          children: [
            const Text(''),
            const ExchangeRateScreen(),
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    GraphicScreen(),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
