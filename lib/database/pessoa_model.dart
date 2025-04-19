import 'package:hive/hive.dart';

part 'pessoa_model.g.dart';

@HiveType(typeId: 0)
class PessoaModel extends HiveObject {
  @HiveField(0)
  final String nome;

  @HiveField(1)
  final double peso;

  @HiveField(2)
  final double altura;

  @HiveField(3)
  double get imc => peso / (altura * altura);

  PessoaModel({required this.nome, required this.peso, required this.altura});
}
