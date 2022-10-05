class Currency {
  String baseId;
  String icon;
  String name;
  String initials;
  double value;
  DateTime timestamp;
  double mudancaHora;
  double mudancaDia;
  double mudancaSemana;
  double mudancaMes;
  double mudancaAno;
  double mudancaPeriodoTotal;

  Currency({
    required this.baseId,
    required this.icon,
    required this.name,
    required this.initials,
    required this.value,
    required this.timestamp,
    required this.mudancaHora,
    required this.mudancaDia,
    required this.mudancaSemana,
    required this.mudancaMes,
    required this.mudancaAno,
    required this.mudancaPeriodoTotal,
  });
}
