import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../component/title_page.dart';

class MoviePage extends StatefulWidget {
  final String url;
  MoviePage({required this.url});
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late String movieTitle;
  late String moviePlot;
  int randomIndex = 0;
  Future fetchTitle() async {
    var url = Uri.parse(widget.url);
    var response = await http.get(url);
    var title = convert.jsonDecode(response.body) as Map<dynamic, dynamic>;
    randomIndex = rnd();
    movieTitle = title["Movies"][randomIndex]["Title"].toString().toLowerCase();
    moviePlot = title["Movies"][randomIndex]["Plot"].toString();
  }

  int rnd() {
    var r = Random();
    return 0 + r.nextInt(250 - 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTitle(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return TitlePage(
            moviePlot: moviePlot,
            movieTitle: movieTitle,
            url: widget.url,
          );
        } else
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow[600],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: randomIndex % 2 == 0
                      ? Text(
                          'This question is tricky...',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Finding you an easy question...',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                ),
              ],
            ),
          );
      },
    );
  }
}
