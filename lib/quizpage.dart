import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inquiz_app/resultpage.dart';

class Getjson extends StatelessWidget {
  const Getjson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString("assets/cpp.json"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("Error loading quiz data"));
        }

        List<dynamic> mydata = json.decode(snapshot.data!);
        return Quizpage(mydata: mydata);
      },
    );
  }
}

class Quizpage extends StatefulWidget {
  final List<dynamic> mydata;

  const Quizpage({Key? key, required this.mydata}) : super(key: key);

  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  late List<dynamic> mydata;
  Color colortoshow = Colors.indigoAccent;
  final Color right = Colors.green;
  final Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  int timer = 30;
  String showtimer = "30";

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  @override
  void initState() {
    super.initState();
    mydata = widget.mydata;
    starttimer();
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;

    if (i < 10) {
      setState(() {
        i++;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResultPage(marks: marks)),
      );
    }

    setState(() {
      btncolor.updateAll((key, value) => Colors.indigoAccent);
    });
  }

  void starttimer() {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      if (canceltimer || timer < 1) {
        t.cancel();
        if (timer < 1) nextquestion();
      } else {
        setState(() {
          timer--;
          showtimer = timer.toString();
        });
      }
    });
  }

  void checkAnswer(String k) {
    if (mydata[2]["1"] == mydata[1][i.toString()][k]) {
      marks += 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }

    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    Timer(const Duration(seconds: 2), nextquestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Incept"),
            content: const Text("You can't Go Back At this stage."),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              )
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Quando",
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  choiceButton("a"),
                  choiceButton("b"),
                  choiceButton("c"),
                  choiceButton("d"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
