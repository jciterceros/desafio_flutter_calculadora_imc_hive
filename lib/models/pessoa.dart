class Pessoa {
  final String nome;
  final double peso;
  final double altura;

  Pessoa({required this.nome, required this.peso, required this.altura});

  double get imc => peso / (altura * altura);

  @override
  String toString() {
    return 'Nome: $nome, Peso: $peso, Altura: $altura, IMC: ${imc.toStringAsFixed(2)}';
  }
}
