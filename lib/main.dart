import 'package:desafio_flutter_calculadora_imc_hive/app_widget.dart';
import 'package:desafio_flutter_calculadora_imc_hive/database/pessoa_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(PessoaModelAdapter().typeId)) {
    Hive.registerAdapter(PessoaModelAdapter());
  }

  runApp(const AppWidget());
}
