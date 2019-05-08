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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Cine"),
        ),
        body: StreamBuilder<List<Movie>>(
            stream: bloc.listOut,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text(snapshot.error);
              List<Movie> photo = snapshot.data;
              return ListView.separated(
                itemCount: photo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 500,
                    child: ListTile(
                      title: Text(
                        photo[index].title,
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Image.network("https://image.tmdb.org/t/p/w200/" +
                              photo[index].posterPath),
                          Text(
                            photo[index].releaseDate,
                          ),
                        ],
                      ),
                      subtitle: Text(photo[index].overview),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }));
  }
}
