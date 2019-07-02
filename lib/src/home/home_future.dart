import 'dart:convert';

import 'package:flutter_cine/src/shared/constrants.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';
import 'package:http/http.dart' as http;

Future<List<Filme>> fetchFilmes() async {
  final response = await http
      .get(URL_API + "/movie/now_playing?language=pt-BR&api_key=" + KEY_API);

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    // If the call to the server was successful, parse the JSON.
    return (json.decode(response.body)['results'] as List)
        .map((movie) => Filme.fromJson(movie))
        .toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Falha ao carregar os filmes');
  }
}
