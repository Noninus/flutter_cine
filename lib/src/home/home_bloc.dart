import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blocs_aula/src/shared/repositories/general_api.dart';
import 'package:blocs_aula/src/shared/models/movie.dart';

class HomeBloc implements BlocBase {
  final GenerealAPI api;

  HomeBloc(this.api);

  final BehaviorSubject _listController = BehaviorSubject.seeded(true);
  Sink get listIn => _listController.sink;
  Observable<List<Movie>> get listOut =>
      _listController.stream.asyncMap((v) => api.getMovies());

  @override
  void dispose() {
    _listController.close();
  }
}
