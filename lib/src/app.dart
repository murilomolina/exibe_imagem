import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/image_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int numeroReq = 0;

  void obterImagem(String query) async {
    var url = Uri.https('api.pexels.com', '/v1/search', {'query': query, 'page': '1', 'per_page': '1'});
    var req = http.Request('get', url);
    req.headers.addAll({'Authorization': dotenv.env['API_PEXELS_KEY']!});
    // sem o uso do async/await
    // req.send().then((result){
    //   if (result.statusCode == 200) {
    //     http.Response.fromStream(result).then((response){
    //       var respostaJSON = json.decode(response.body);
    //       var imagem = ImageModel.fromJSON(respostaJSON);
    //       print(imagem);
    //     });        
    //   }
    // });
    final result = await req.send();
    if(result.statusCode == 200){
      final response = await http.Response.fromStream(result);
      var respostaJSON = json.decode(response.body);
      var imagem = ImageModel.fromJSON(respostaJSON);
      print(imagem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Exibe imagens"),
        actions: [
          Text("Ultima entrada: "), 
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300, 
                  height: 200, 
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Stack(
                    children: [
                      // Imagem
                      // Center(
                      //   child: Image.network(
                      //     'URL', 
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      // Campo de texto
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: TextField(
                          maxLength: 50,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Insira seu texto aqui (limite de 50 caracteres)',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Ajuste o padding se necessário
              child: FloatingActionButton(
                onPressed: () => obterImagem('carro'),
                backgroundColor: Colors.blue,
                hoverColor: const Color.fromARGB(255, 34, 46, 156),
                hoverElevation: 10.0,
                splashColor: Colors.lightBlue,
                child: const Icon(Icons.add_circle_outline_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
