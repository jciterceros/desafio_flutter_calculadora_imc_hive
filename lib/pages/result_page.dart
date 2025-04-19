import 'package:desafio_flutter_calculadora_imc_hive/database/pessoa_model.dart';
import 'package:desafio_flutter_calculadora_imc_hive/models/pessoa.dart';
import 'package:desafio_flutter_calculadora_imc_hive/services/classificacao_service.dart';
import 'package:flutter/material.dart';

class ResultadosPage extends StatelessWidget {
  final List<PessoaModel> pessoas;
  const ResultadosPage({super.key, required this.pessoas});

  String obterClassificacao(Pessoa pessoa) {
    return ClassificacaoSaude.classificar(pessoa.imc);
  }

  Pessoa converterParaPessoa(PessoaModel pessoaModel) {
    return Pessoa(
      nome: pessoaModel.nome,
      peso: pessoaModel.peso,
      altura: pessoaModel.altura,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Nome')),
              DataColumn(label: Text('Peso (kg)')),
              DataColumn(label: Text('Altura (m)')),
              DataColumn(label: Text('IMC')),
              DataColumn(label: Text('Classificação')),
            ],
            rows:
                pessoas.map((pessoa) {
                  return DataRow(
                    cells: [
                      DataCell(Text(pessoa.nome)),
                      DataCell(Text(pessoa.peso.toStringAsFixed(2))),
                      DataCell(Text(pessoa.altura.toStringAsFixed(2))),
                      DataCell(Text(pessoa.imc.toStringAsFixed(2))),
                      DataCell(
                        Text(obterClassificacao(converterParaPessoa(pessoa))),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
