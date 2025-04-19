class ClassificacaoSaude {
  static const double limiteMagrezaGrave = 16.0;
  static const double limiteMagrezaModerada = 17.0;
  static const double limiteMagrezaLeve = 18.5;
  static const double limiteSaudavel = 25.0;
  static const double limiteSobrepeso = 30.0;
  static const double limiteObesidadeI = 35.0;
  static const double limiteObesidadeII = 40.0;

  static String classificar(double imc) {
    if (imc < limiteMagrezaGrave) return 'Magreza grave';
    if (imc < limiteMagrezaModerada) return 'Magreza moderada';
    if (imc < limiteMagrezaLeve) return 'Magreza leve';
    if (imc < limiteSaudavel) return 'Saudável';
    if (imc < limiteSobrepeso) return 'Sobrepeso';
    if (imc < limiteObesidadeI) return 'Obesidade Grau I';
    if (imc < limiteObesidadeII) return 'Obesidade Grau II (severa)';
    return 'Obesidade Grau III (mórbida)';
  }
}
