import 'package:flutter_cine/src/home/home_bloc.dart';
import 'package:flutter_cine/src/shared/models/movie.dart';
import 'package:flutter_cine/src/shared/repositories/general_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilmePage extends StatefulWidget {
  final Movie filme;

  FilmePage({Key key, this.filme}) : super(key: key);

  @override
  _FilmePageState createState() => _FilmePageState();
}

class _FilmePageState extends State<FilmePage> {
  HomeBloc bloc;
  DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  TextStyle tituloStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white);
  TextStyle cabecalhoStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white);
  TextStyle bodyStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white70);

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc(GenerealAPI());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  quantidadeEstrela(var quantidadeEstrelas) {
    double iconSize = 20;
    return Row(
      children: <Widget>[
        Icon(
          quantidadeEstrelas > 1
              ? Icons.star
              : quantidadeEstrelas > 0.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: iconSize,
        ),
        Icon(
          quantidadeEstrelas > 2
              ? Icons.star
              : quantidadeEstrelas > 1.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: iconSize,
        ),
        Icon(
          quantidadeEstrelas > 3
              ? Icons.star
              : quantidadeEstrelas > 2.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: iconSize,
        ),
        Icon(
          quantidadeEstrelas > 4
              ? Icons.star
              : quantidadeEstrelas > 3.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: iconSize,
        ),
        Icon(
          quantidadeEstrelas > 5
              ? Icons.star
              : quantidadeEstrelas > 4.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: iconSize,
        ),
      ],
    );
  }

  criarCardFilmes(Movie filme) {
    var quantidadeEstrelas = filme.voteAverage / 2;
    DateTime dateTimeFilmeLancamento =
        new DateFormat("yyyy-MM-dd").parse(filme.releaseDate);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Text(
                  "Lançamento em " + dateFormat.format(dateTimeFilmeLancamento),
                  style: cabecalhoStyle),
              Spacer(
                flex: 4,
              ),
              quantidadeEstrela(quantidadeEstrelas),
              Spacer(
                flex: 3,
              ),
            ],
          ),
          Container(
            child: Text(
              filme.overview,
              style: bodyStyle,
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF3a4256),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200), // here the desired height
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(6),
              child: RaisedButton(
                  padding: EdgeInsets.all(6),
                  color: Colors.black,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30))),
            ),
            flexibleSpace: Image.network(
                "https://image.tmdb.org/t/p/w500/" + widget.filme.backdropPath,
                fit: BoxFit.cover),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  )),
              width: double.infinity,
              child: Text(
                widget.filme.title,
                textAlign: TextAlign.center,
                style: tituloStyle,
              ),
            ),
            criarCardFilmes(widget.filme)
          ],
        ));
  }
}
