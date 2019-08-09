import 'package:flutter_cine/src/filme/filme.dart';
import 'package:flutter_cine/src/home/home_future.dart';
import 'package:flutter_cine/src/shared/constrants.dart';
import 'package:flutter_cine/src/shared/models/filme.dart';
import 'package:flutter/material.dart';

class HomeFuturePage extends StatefulWidget {
  HomeFuturePage({Key key}) : super(key: key);

  @override
  _HomeFuturePageState createState() => _HomeFuturePageState();
}

class _HomeFuturePageState extends State<HomeFuturePage> {
  Future<List<Filme>> filmes;

  @override
  void initState() {
    super.initState();
    filmes = fetchFilmes();
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
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.red,
        ),
        child: Hero(
            tag: URL_POSTER + posterPath,
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(4),
              child:
                  Image.network(URL_POSTER + posterPath, fit: BoxFit.contain),
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
      body: FutureBuilder<List<Filme>>(
        future: filmes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Filme> filme = snapshot.data;
            return ListView.builder(
              itemCount: filme.length,
              itemBuilder: (BuildContext context, int index) {
                return cardFilmes(filme[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Animação loading
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
