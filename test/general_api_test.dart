import 'package:flutter_cine/src/shared/repositories/general_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';

main() {
  var api = GenerealAPI();

  test('get filmes', () async {
    List<Filme> data = await api.getMovies();
    expect(data[0].id, 299534);
  });
}
