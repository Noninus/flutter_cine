import 'package:blocs_aula/src/shared/constrants.dart';
import 'package:dio/dio.dart';
import 'package:blocs_aula/src/shared/models/movie.dart';

class GenerealAPI {
  Dio dio;

  GenerealAPI() {
    dio = Dio();
    dio.options.baseUrl = URL_API;
  }

  Future<List<Movie>> getMovies() async {
    Response response =
        await dio.get("/movie/now_playing?language=pt-BR&api_key=" + KEY_API);
    return (response.data["results"] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }
}
