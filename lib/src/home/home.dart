import 'package:flutter_cine/src/filme/filme.dart';
import 'package:flutter_cine/src/home/home_bloc.dart';
import 'package:flutter_cine/src/shared/constrants.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';
import 'package:flutter_cine/src/shared/repositories/general_api.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc bloc;

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
    return Row(
      children: <Widget>[
        Icon(
          quantidadeEstrelas > 1
              ? Icons.star
              : quantidadeEstrelas > 0.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: 15,
        ),
        Icon(
          quantidadeEstrelas > 2
              ? Icons.star
              : quantidadeEstrelas > 1.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: 15,
        ),
        Icon(
          quantidadeEstrelas > 3
              ? Icons.star
              : quantidadeEstrelas > 2.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: 15,
        ),
        Icon(
          quantidadeEstrelas > 4
              ? Icons.star
              : quantidadeEstrelas > 3.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: 15,
        ),
        Icon(
          quantidadeEstrelas > 5
              ? Icons.star
              : quantidadeEstrelas > 4.5 ? Icons.star_half : Icons.star_border,
          color: Colors.yellowAccent,
          size: 15,
        ),
      ],
    );
  }

  posterFilme(String posterPath) {
    return Container(
        width: 100.0,
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.red,
        ),
        child: Hero(
            tag: URL_IMAGE + posterPath,
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(8),
              child: Image.network(URL_IMAGE + posterPath, fit: BoxFit.contain),
            )));
  }

  descricaoFilme(String filmeTitle) {
    return Text(
      filmeTitle,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  subtituloFilme(String overview, double quantidadeEstrelas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        quantidadeEstrela(quantidadeEstrelas),
        SizedBox(
          height: 5,
        ),
        Text(
          overview.length >= 80 ? overview.substring(0, 80) + "..." : overview,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  cardFilmes(Filme filme) {
    Widget linha = Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          posterFilme(filme.posterPath),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                descricaoFilme(filme.title),
                SizedBox(
                  height: 25,
                ),
                subtituloFilme(filme.overview, filme.voteAverage / 2),
              ],
            ),
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilmePage(
                      filme: filme,
                    )),
          ),
      child: Card(
        color: Colors.blueGrey,
        child: linha,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF3a4256),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF3a4256),
          title: Text("Flutter Cine"),
        ),
        body: StreamBuilder<List<Filme>>(
            stream: bloc.filmesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text(snapshot.error);
              List<Filme> filme = snapshot.data;
              return ListView.builder(
                itemCount: filme.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardFilmes(filme[index]);
                },
              );
            }));
  }
}
