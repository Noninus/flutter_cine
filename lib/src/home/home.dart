import 'package:flutter_cine/src/home/home_bloc.dart';
import 'package:flutter_cine/src/shared/models/movie.dart';
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

  criarCardFilmes(Movie movie) {
    var quantidadeEstrelas = movie.voteAverage / 2;
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

            title: Text(
              movie.title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Column(
              children: <Widget>[
                quantidadeEstrela(quantidadeEstrelas),
                Text(
                  movie.overview,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            trailing: Image.network(
              "https://image.tmdb.org/t/p/w200/" + movie.posterPath,
              width: 50,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Flutter Cine"),
        ),
        body: StreamBuilder<List<Movie>>(
            stream: bloc.listOut,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text(snapshot.error);
              List<Movie> movie = snapshot.data;
              return ListView.builder(
                itemCount: movie.length,
                itemBuilder: (BuildContext context, int index) {
                  return criarCardFilmes(movie[index]);
                },
              );
            }));
  }
}
