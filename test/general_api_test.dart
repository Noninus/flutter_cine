import 'package:blocs_aula/src/shared/repositories/general_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blocs_aula/src/shared/models/movie.dart';

main() {
  var api = GenerealAPI();

  test('get now playing', () async {
    List<Movie> data = await api.getMovies();
    expect(data[0].id, 299534);
  });
}
