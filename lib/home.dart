import 'package:flutter/material.dart';
import 'package:mynewflutterapp_quiz/answer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [
    /*  Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    */
  ];

  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      //answer was selected
      answerWasSelected = true;
      //check if answer was correct

      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding the score tracker

      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              )
            : Icon(
                Icons.close,
                color: Colors.red,
              ),
      );
      //when quiz end

      if (_questionIndex + 1 == _question.length) {
        endOfQuiz = true;
        Alert(
          context: context,
          title: "Finished",
          desc: _totalScore >= 5
              ? 'Congratualations..!! \n \n Your final score is : $_totalScore'
              : 'Your final score is $_totalScore. Better luck next time',
        ).show();
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happend at the end of the quiz
    if (_questionIndex >= _question.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            'Bollywood Quiz',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  if (_scoreTracker.length == 0)
                    SizedBox(
                      height: 20.0,
                    ),
                  if (_scoreTracker.length > 0) ..._scoreTracker
                ],
              ),
              Container(
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   image: AssetImage("assets/images/bulb.jpg"),
                // )),
                color: Colors.lime,
                height: 100.0,
                child: Center(
                  child: Text(
                    _question[_questionIndex]['question'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ...(_question[_questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map(
                (answer) => Answer(
                  answerText: answer['answerText'],
                  answerColor: answerWasSelected
                      ? answer['score']
                          ? Colors.green
                          : Colors.red
                      : null,
                  answerTap: () {
                    // if answer was already selected nothing happend on tap

                    if (answerWasSelected) {
                      return;
                    }
                    // answer is being selected

                    _questionAnswered(answer['score']);
                  },
                ),
              ),
              //      Answer(),
              //    Answer(),
              //  Answer(),
              SizedBox(
                height: 5.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!answerWasSelected) {
                    return;
                  }

                  _nextQuestion();
                },
                child: Text(
                  endOfQuiz ? 'Restart Quiz' : 'Next Question',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '${_totalScore.toString()}/${_question.length}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              if (answerWasSelected)
                Container(
                  height: 25.0,
                  width: double.infinity,
                  color: correctAnswerSelected ? Colors.green : Colors.red,
                  child: Text(
                    correctAnswerSelected
                        ? 'Well Done..!!'
                        : 'Ooopss..! You got wrong answer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              if (endOfQuiz)
                Container(
                  color: Colors.black,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      _totalScore >= 5
                          ? 'Congratualations you have done great job, your score is : $_totalScore'
                          : 'Your final score is $_totalScore. Better luck next time',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: _totalScore > 2 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}

final _question = const [
  {
    'question': 'Who was known as the King of Bollywood Music?',
    'answers': [
      {'answerText': 'Kishore Kumar ', 'score': false},
      {'answerText': 'Sachin Dev Burman ', 'score': false},
      {'answerText': 'Rahul Dev Burman', 'score': true},
    ],
  },
  {
    'question':
        'Which Bollywood actor was recently named in the WEF’s Young Global Leaders (YGLs) list?',
    'answers': [
      {'answerText': 'Deepika Padukone', 'score': true},
      {'answerText': 'Priyanka Chopra', 'score': false},
      {'answerText': 'Vidya Balan', 'score': false},
    ],
  },
  {
    'question':
        'Which Bollywood celebrity has been appointed as the first ever brand ambassador of IDFC FIRST Bank?',
    'answers': [
      {'answerText': 'Shah Rukh Khan', 'score': false},
      {'answerText': 'Ranveer Singh', 'score': false},
      {'answerText': 'Amitabh Bachchan', 'score': true},
    ],
  },
  {
    'question':
        'As of 2020, which is the only Bollywood movie to win 13 Filmfare Awards?',
    'answers': [
      {'answerText': 'Gully Boy', 'score': true},
      {'answerText': 'Article 15', 'score': false},
      {'answerText': 'Uri: The Surgical Strike', 'score': false},
    ],
  },
  {
    'question':
        'Which movie has become the first Bollywood film to go plastic-free?',
    'answers': [
      {'answerText': 'War', 'score': false},
      {'answerText': 'Coolie No. 1', 'score': true},
      {'answerText': 'Dream Girl', 'score': false},
    ],
  },
  {
    'question':
        'Which of the following movies has became the first Bollywood film ever to release in Saudi Arabia?',
    'answers': [
      {'answerText': 'Raazi', 'score': false},
      {'answerText': 'Parmanu', 'score': false},
      {'answerText': 'Gold', 'score': true},
    ],
  },
  {
    'question':
        'Which Bollywood personality has become the brand ambassador for Government of India (GoI)’s road safety awareness campaign?',
    'answers': [
      {'answerText': 'Akshay Kumar', 'score': true},
      {'answerText': 'Anushka Sharma', 'score': false},
      {'answerText': 'Amitabh Bachchan', 'score': false},
    ],
  },
  {
    'question':
        'Which Bollywood personality has been honoured with the Swara Mauli award?',
    'answers': [
      {'answerText': 'Lata Mangeshkar', 'score': true},
      {'answerText': 'Asha Bhosale', 'score': false},
      {'answerText': 'Kishor Kumar', 'score': false},
    ],
  },
  {
    'question':
        'Which Bollywood personality has been honoured with the ‘Godavari Gaurav’ award?',
    'answers': [
      {'answerText': 'Deepika Padukone', 'score': false},
      {'answerText': 'Amol Palekar', 'score': true},
      {'answerText': 'Rekha', 'score': false},
    ],
  },
  {
    'question': 'Which of these people sang a part in the song ‘Maahi Ve’?',
    'answers': [
      {'answerText': 'Alka Yagnik', 'score': false},
      {'answerText': 'Sadhana Sargam', 'score': true},
      {'answerText': 'Shaan', 'score': false},
    ],
  },
];

/*Alert(
                      context: context,
                      title: "Warning",
                      desc: "Please select an Answer",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Play again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                      ],
                    ).show();*/
