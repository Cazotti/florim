import 'dart:async';
import 'dart:convert';

import 'package:final_project/models/currency.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoedaRepository extends ChangeNotifier {
  List<Currency> _tabela = [];
  late Timer intervalo;

  List<Currency> get tabela => _tabela;

  MoedaRepository();

  getHistoricoMoeda() async {
    String baseId = '49cf5f4c-a714-5c20-9add-933194532e1a';
    final response = await http.get(Uri.parse('https://api.coinbase.com/v2/assets/prices/${baseId}?base=BRL'));
    List<Map<String, dynamic>> precos = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Map<String, dynamic> moeda = json['data']['prices'];

      precos.add(moeda['hour']);
      precos.add(moeda['day']);
      precos.add(moeda['week']);
      precos.add(moeda['month']);
      precos.add(moeda['year']);
      precos.add(moeda['all']);
    }

    return precos;
  }
}
