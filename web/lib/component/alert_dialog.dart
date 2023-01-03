import 'package:flutter/material.dart';
import 'package:guessthemovie/screens/home.dart';
import '../screens/movie_page.dart';

class CustomAlertDialog extends StatefulWidget {
  final title;
  final content;
  CustomAlertDialog({this.title, this.content});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 10,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 50,
            width: 100,
            child: InkWell(
              hoverColor: Colors.yellow,
              child: Center(child: Text('Home')),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
            ),
          ),
        ),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 50,
            width: 180,
            child: InkWell(
              hoverColor: Colors.yellow,
              child: Center(child: Text('Play again')),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MoviePage();
              })),
            ),
          ),
        ),
      ],
    );
  }
}
