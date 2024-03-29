import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_cine/src/shared/repositories/general_api.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';

class HomeBloc implements BlocBase {
  final GenerealAPI api;

  HomeBloc(this.api);

  final BehaviorSubject filmesController = BehaviorSubject.seeded(true);
  Sink get listIn => filmesController.sink;
  Observable<List<Filme>> get filmesStream =>
      filmesController.stream.asyncMap((v) => api.getMovies());

  @override
  void dispose() {
    filmesController.close();
  }
}
