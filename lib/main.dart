import 'package:exibe_imagem/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env"); // Carregando o arquivo .env
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: App()));
}
