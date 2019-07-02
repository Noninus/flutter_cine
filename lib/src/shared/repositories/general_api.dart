import 'package:flutter_cine/src/shared/constrants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';

class GenerealAPI {
  Dio dio;

  GenerealAPI() {
    dio = Dio();
    dio.options.baseUrl = URL_API;
  }

  Future<List<Filme>> getMovies() async {
    Response response =
        await dio.get("/movie/now_playing?language=pt-BR&api_key=" + KEY_API);
    return (response.data["results"] as List)
        .map((movie) => Filme.fromJson(movie))
        .toList();
  }
}
