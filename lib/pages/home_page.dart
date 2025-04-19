import 'package:desafio_flutter_calculadora_imc_hive/controllers/pessoa_controller.dart';
import 'package:desafio_flutter_calculadora_imc_hive/database/pessoa_model.dart';
import 'package:desafio_flutter_calculadora_imc_hive/models/pessoa.dart';
import 'package:desafio_flutter_calculadora_imc_hive/pages/result_page.dart';
import 'package:desafio_flutter_calculadora_imc_hive/services/classificacao_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final PessoaController pessoaController = PessoaController(
    ClassificacaoSaude(),
  );

  static const Color primaryColor = Color(0xFF6200EE);

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<Box<PessoaModel>> _getHiveBox() async {
    if (!Hive.isBoxOpen('pessoas')) {
      return await Hive.openBox<PessoaModel>('pessoas');
    }
    return Hive.box<PessoaModel>('pessoas');
  }

  Future<void> _carregarDados() async {
    try {
      final box = await _getHiveBox();
      print('Caixa aberta: ${box.name}, Total de itens: ${box.length}');
      if (box.isNotEmpty) {
        for (var pessoa in box.values) {
          print('Nome: ${pessoa.nome}');
          print('Peso: ${pessoa.peso}');
          print('Altura: ${pessoa.altura}');
          print('IMC: ${pessoa.imc.toStringAsFixed(2)}');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados carregados com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum dado encontrado no Hive.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Erro ao carregar os dados: $e');
    }
  }

  Future<List<PessoaModel>> _enviarDados() async {
    try {
      final box = await _getHiveBox();
      print('Caixa aberta: ${box.name}, Total de itens: ${box.length}');
      if (box.isNotEmpty) {
        return box.values.toList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum dado encontrado no Hive.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Erro ao carregar os dados: $e');
    }
    return [];
  }

  Future<void> _salvarDados() async {
    try {
      final String nome = nomeController.text;
      final double peso = double.parse(pesoController.text);
      final double altura = double.parse(alturaController.text) / 100;

      final pessoa = PessoaModel(nome: nome, peso: peso, altura: altura);

      final box = await _getHiveBox();
      await box.add(pessoa);

      print(
        'Dados salvos: Nome=${pessoa.nome}, Peso=${pessoa.peso}, Altura=${pessoa.altura}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados salvos com sucesso!'),
          duration: Duration(seconds: 3),
        ),
      );
      _carregarDados();
    } catch (e) {
      _mostrarDialogo('Erro', 'Erro ao salvar os dados: $e');
    }
  }

  void _mostrarDialogo(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                controller: nomeController,
                label: 'Digite seu Nome',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: pesoController,
                label: 'Digite seu Peso (kg)',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: alturaController,
                label: 'Digite sua Altura (cm)',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        _salvarDados();
                        _calcularIMC();
                        _limparCampos();
                      },
                      child: const Text('Adiciona IMC'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        final dados = await _enviarDados();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => ResultadosPage(pessoas: dados),
                          ),
                        );
                      },
                      child: const Text('Ver Resultados'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        keyboardType: keyboardType,
        controller: controller,
      ),
    );
  }

  void _limparCampos() {
    nomeController.clear();
    pesoController.clear();
    alturaController.clear();
  }

  void _calcularIMC() {
    try {
      final String nome = nomeController.text;
      final String peso = pesoController.text;
      final String altura = alturaController.text;

      final resultado = pessoaController.calcularIMC(nome, peso, altura);
      final Pessoa pessoa = resultado['pessoa'];
      final String classificacao = resultado['classificacao'];

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '${pessoa.nome}, seu IMC = ${pessoa.imc.toStringAsFixed(2)}',
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _buildIMCTable(),
                  const SizedBox(height: 16),
                  Text(
                    'Classificação atual: $classificacao',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _mostrarDialogo('Erro', e.toString());
    }
  }

  Widget _buildIMCTable() {
    final classificacoes = [
      {'range': '< 16', 'label': 'Magreza grave'},
      {'range': '16 a < 17', 'label': 'Magreza moderada'},
      {'range': '17 a < 18,5', 'label': 'Magreza leve'},
      {'range': '18,5 a < 25', 'label': 'Saudável'},
      {'range': '25 a < 30', 'label': 'Sobrepeso'},
      {'range': '30 a < 35', 'label': 'Obesidade Grau I'},
      {'range': '35 a < 40', 'label': 'Obesidade Grau II (severa)'},
      {'range': '>= 40', 'label': 'Obesidade Grau III (mórbida)'},
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'IMC',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Classificação',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ...classificacoes.map((item) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item['range']!, textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item['label']!, textAlign: TextAlign.center),
              ),
            ],
          );
        }),
      ],
    );
  }
}
