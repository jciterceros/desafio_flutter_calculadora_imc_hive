import 'package:desafio_flutter_calculadora_imc_hive/models/pessoa.dart';
import 'package:desafio_flutter_calculadora_imc_hive/services/classificacao_service.dart';

class InputValidator {
  static double parseAndValidate(String value, String fieldName) {
    final double parsedValue = double.parse(value);
    if (parsedValue <= 0) {
      throw Exception('$fieldName deve ser maior que zero.');
    }
    return parsedValue;
  }
}

class PessoaController {
  final ClassificacaoSaude classificacaoService;

  PessoaController(this.classificacaoService);

  Pessoa criarPessoa(String nome, double peso, double altura) {
    return Pessoa(nome: nome, peso: peso, altura: altura);
  }

  String obterClassificacao(Pessoa pessoa) {
    return ClassificacaoSaude.classificar(pessoa.imc);
  }

  Map<String, dynamic> calcularIMC(
    String nome,
    String pesoStr,
    String alturaStr,
  ) {
    try {
      final double peso = InputValidator.parseAndValidate(pesoStr, 'Peso');
      final double altura =
          InputValidator.parseAndValidate(alturaStr, 'Altura') / 100;

      final Pessoa pessoa = criarPessoa(nome, peso, altura);
      final String classificacao = obterClassificacao(pessoa);

      return {'pessoa': pessoa, 'classificacao': classificacao};
    } catch (e) {
      throw Exception('Erro ao calcular IMC: ${e.toString()}');
    }
  }
}
