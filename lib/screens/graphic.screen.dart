import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repositories/moeda_repository.dart';

class GraphicScreen extends StatefulWidget {
  const GraphicScreen({Key? key}) : super(key: key);

  @override
  _GraphicScreenState createState() => _GraphicScreenState();
}

enum Periodo { hora, dia, semana, mes, ano, total }

class _GraphicScreenState extends State<GraphicScreen> {
  Periodo periodo = Periodo.hora;
  List<Map<String, dynamic>> historico = [];
  List dadosCompletos = [];
  List<FlSpot> dadosGrafico = [];
  double maxX = 0;
  double maxY = 0;
  double minY = 0;
  ValueNotifier<bool> loaded = ValueNotifier(false);
  late MoedaRepository repositorio = MoedaRepository();
  late Map<String, String> loc;
  late NumberFormat real;

  setDados() async {
    loaded.value = false;
    dadosGrafico = [];

    if (historico.isEmpty) {
      historico = await repositorio.getHistoricoMoeda();
    }

    dadosCompletos = historico[periodo.index]['prices'];
    dadosCompletos = dadosCompletos.reversed.map((item) {
      double preco = double.parse(item[0]);
      int time = int.parse(item[1].toString() + '000');
      return [preco, DateTime.fromMillisecondsSinceEpoch(time)];
    }).toList();

    maxX = dadosCompletos.length.toDouble();
    maxY = 0;
    minY = double.infinity;

    for (var item in dadosCompletos) {
      maxY = item[0] > maxY ? item[0] : maxY;
      minY = item[0] < minY ? item[0] : minY;
    }

    for (int i = 0; i < dadosCompletos.length; i++) {
      dadosGrafico.add(FlSpot(
        i.toDouble(),
        dadosCompletos[i][0],
      ));
    }
    loaded.value = true;
  }

  LineChartData getChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: dadosGrafico,
          isCurved: true,
          color: const Color(0xFF3F51B5) ,
          barWidth: 2,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: const Color(0xFF3F51B5).withOpacity(0.15),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Color(0xFF343434),
          getTooltipItems: (data) {
            return data.map((item) {
              final date = getDate(item.spotIndex);
              return LineTooltipItem(
                real.format(item.y),
                const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '\n $date',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }

  getDate(int index) {
    DateTime date = dadosCompletos[index][1];
    if (periodo != Periodo.ano && periodo != Periodo.total)
      return DateFormat('dd/MM - hh:mm').format(date);
    else
      return DateFormat('dd/MM/y').format(date);
  }

  chartButton(Periodo p, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () => setState(() => periodo = p),
        child: Text(label),
        style: (periodo != p)
            ? ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey))
            : ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo[50])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setDados();

    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                chartButton(Periodo.hora, '1H'),
                chartButton(Periodo.dia, '24H'),
                chartButton(Periodo.semana, '7D'),
                chartButton(Periodo.mes, 'Mês'),
                chartButton(Periodo.ano, 'Ano'),
                chartButton(Periodo.total, 'Tudo'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ValueListenableBuilder(
              valueListenable: loaded,
              builder: (context, bool isLoaded, _) {
                return (isLoaded)
                  ? LineChart(getChartData())
                  : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}