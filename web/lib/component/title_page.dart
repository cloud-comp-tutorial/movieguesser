import 'package:flutter/material.dart';
import 'package:guessthemovie/component/alert_dialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../screens/movie_page.dart';

class TitlePage extends StatefulWidget {
  final String movieTitle;
  final String moviePlot;

  TitlePage({
    required this.movieTitle,
    required this.moviePlot,
  });

  @override
  _TitlePageState createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  void initState() {
    super.initState();
    hiddenTitleString = widget.movieTitle.replaceAll(RegExp(r'[\S]'), '*');
  }

  late String hiddenTitleString;
  late List<String> hiddenTitleList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size).width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AnimatedTextKit(
                        key: UniqueKey(),
                        animatedTexts: [
                          TypewriterAnimatedText(
                            hiddenTitleString,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: width < 780 ? 25 : 60),
                            speed: Duration(milliseconds: 30),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                      Card(
                        color: Color.fromARGB(234, 248, 255, 117),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        elevation: 3,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Plot',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  720
                                              ? 18
                                              : 36,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.moviePlot,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  720
                                              ? 14
                                              : 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.yellow,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: controller,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Type here',
                        labelText: 'Type letter or movie title',
                        labelStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.yellow),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) => value.length == 1
                          ? guessTheLetter()
                          : guessTheMovie(),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Wrap(
                direction: width < 720 ? Axis.vertical : Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 50,
                        width: 150,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              'Guess the letter',
                            ),
                          ),
                          onTap: () {
                            guessTheLetter();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 50,
                        width: 150,
                        child: InkWell(
                          child: Center(
                            child: Text(
                              'Guess the movie',
                            ),
                          ),
                          onTap: () {
                            guessTheMovie();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'The movie was',
                content: widget.movieTitle,
              );
            },
          );
        },
        backgroundColor: Colors.yellow,
        label: Text(
          'Reveal',
          style: TextStyle(color: Colors.black),
        ),
        icon: Icon(
          Icons.info_outline_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  void guessTheMovie() {
    if (widget.movieTitle == controller.text.trim().toLowerCase()) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: "Yey",
            content: "You guessed it right!!",
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops, Movie title is not ${controller.text}')));
    }
  }

  void guessTheLetter() {
    String letter = controller.text.trim();
    if (letter.length == 1 &&
        widget.movieTitle.contains(letter.toLowerCase())) {
      setState(() {
        hiddenTitleList = hiddenTitleString.split('');
        List movieTitleList = widget.movieTitle.split('');
        for (int i = 0; i < widget.movieTitle.length; i++) {
          if (letter.toLowerCase() == movieTitleList[i]) {
            hiddenTitleList[i] = letter;
          }
          hiddenTitleString = hiddenTitleList.join();
        }

        if (hiddenTitleString == widget.movieTitle) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: "Yey",
                content: "You guessed it right!!",
              );
            },
          );
        }
        controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Movie title does not contain ${controller.text}')));
    }
  }
}
