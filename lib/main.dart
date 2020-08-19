import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff5D72C5),
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void nextQuestion() {
    if (counter < quizBrain.questionsBank.length - 1) {
      counter++;
    }else{
      Alert(
        context: context,
        type: AlertType.error,
        title: "Quiz finished! 🤩",
        desc: "Congrats you got $correctAnswers correct Answers 🥳",
        buttons: [
          DialogButton(
            child: Text(
              "START AGAIN 👏🏻",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (

                ) async {
              Navigator.pop(context);
            },
            width: 200,
          )
        ],
      ).show();
      scoreKeeper.clear();
      counter=0;
      correctAnswers =0;
    }
  }

  int counter = 0;
  int correctAnswers =0;
  void checkAnswer(bool UserAnswer) {
    bool correctAnswer = quizBrain.questionsBank[counter].questionsAnswers;
    setState(() {

      if (correctAnswer == UserAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          ),
        );
        correctAnswers++;
    } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
            size: 30,
          ),
        );
    }
      nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.6, 0.6),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                height: 450,
                child: Text(
                  quizBrain.questionsBank[counter].questionsText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 180,
                    height: 60,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      color: Color(0xff10A896),
                      child: Text(
                        'True',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(true);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 180,
                    height: 60,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xffEB6A70),
                      child: Text(
                        'False',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        checkAnswer(false);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xffEEEFF6);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.5,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height + 100);
    path.lineTo(0, size.height + 100);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

