import 'package:flutter_cine/src/filme/arcBannerImage.dart';
import 'package:flutter_cine/src/filme/poster.dart';
import 'package:flutter_cine/src/home/home_bloc.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';
import 'package:flutter_cine/src/shared/repositories/general_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cine/src/shared/constrants.dart';

class FilmePage extends StatefulWidget {
  final Filme filme;

  FilmePage({Key key, this.filme}) : super(key: key);

  @override
  _FilmePageState createState() => _FilmePageState();
}

class _FilmePageState extends State<FilmePage> {
  HomeBloc bloc;
  DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  TextStyle tituloStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white);
  TextStyle cabecalhoStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white);
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

  movieInformation(Filme filme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filme.title,
            style: tituloStyle,
          ),
          SizedBox(height: 8.0),
          quantidadeEstrela(filme.voteAverage / 2),
          SizedBox(height: 10),
          Text(
            "Lançamento em\n" +
                dateFormat
                    .format(DateFormat("yyyy-MM-dd").parse(filme.releaseDate)),
            style: cabecalhoStyle,
          ),
          SizedBox(
            height: 20,
          )
        ],
      );

  overviewText(Filme filme) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              filme.overview,
              style: bodyStyle,
            ),
          ],
        ),
      );

  headerWidget(Filme filme) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: ArcBannerImage(
                "https://image.tmdb.org/t/p/w500" + filme.backdropPath),
          ),
          Positioned(
            top: 32,
            left: 16.0,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF3a4256),
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Poster(
                  URL_IMAGE + widget.filme.posterPath,
                  height: 180.0,
                ),
                SizedBox(width: 16.0),
                Expanded(child: movieInformation(filme)),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3a4256),
      body: SingleChildScrollView(
        child: Column(
          children: [headerWidget(widget.filme), overviewText(widget.filme)],
        ),
      ),
    );
  }
}
