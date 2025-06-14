import 'package:flutter/material.dart';
import 'package:inquiz_app/home.dart';

class ResultPage extends StatefulWidget {
  final int marks;

  const ResultPage({Key? key, required this.marks}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];

  late String message;
  late String image;

  @override
  void initState() {
    super.initState();

    final marks = widget.marks;

    if (marks < 7) {
      image = images[2];
      message = "You should Try Hard..\nYou Scored $marks\n"
          "The predicted Course for you: Introduction to Python: Absolute Beginner";
    } else if (marks < 14) {
      image = images[1];
      message = "You can Do Better..\nYou Scored $marks\n"
          "The predicted Course for you: Introduction to Computer Science and Programming Using Python";
    } else if (marks < 21) {
      image = images[1];
      message = "You can Do Better..\nYou Scored $marks\n"
          "The predicted Course for you: Python and Django Full Stack Web Developer Bootcamp";
    } else if (marks < 28) {
      image = images[1];
      message = "You can Do Better..\nYou Scored $marks\n"
          "The predicted Course for you: Python I: Essentials";
    } else if (marks < 35) {
      image = images[1];
      message = "You can Do Better..\nYou Scored $marks\n"
          "The predicted Course for you: Georgia Tech: Introduction to Computing in Python";
    } else {
      image = images[0];
      message = "Congrats! You did very well!\nYou Scored $marks\n"
          "The predicted Course for you: AI Programming with Python";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300.0,
                    height: 300.0,
                    child: ClipRect(
                      child: Image.asset(image),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Quando",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  side: const BorderSide(
                    width: 3.0,
                    color: Colors.indigo,
                  ),
                  foregroundColor: Colors.indigo,
                  splashFactory: InkRipple.splashFactory,
                ),
                child: const Text("Continue"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
