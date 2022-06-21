import 'package:ayuu_quiz/components/generator/math_generator.dart';
import 'package:ayuu_quiz/helper/game_type.dart';
import 'package:ayuu_quiz/helper/quiz_status.dart';
import 'package:ayuu_quiz/models/math_quiz.dart';
import 'package:ayuu_quiz/network/user_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SimpleMathController extends GetxController {
  final int size;
  final int difficulty;
  final int quizType;
  final int pointPerQuestion;
  final String userId;

  SimpleMathController(
      {required this.size,
      required this.difficulty,
      required this.quizType,
      required this.userId,
      this.pointPerQuestion = 1})
      : super();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  UserFirestore _userFirestore = UserFirestore();
  RxBool isStarted = false.obs;
  RxInt points = 0.obs;
  RxInt currentStatus = QuizStatus.NOT_ANSWER.obs;
  RxList<MathQuiz> quizHistory = <MathQuiz>[].obs;
  Rxn<MathQuiz> currentQuiz = Rxn<MathQuiz>();
  RxInt currentPosition = 0.obs;

  RxBool isOver = false.obs;

  void setQuiz() {
    switch (quizType) {
      case GameType.MATH_ADD:
        currentQuiz.value = MathGenerator().randomAddQuiz(difficulty);
        break;
      case GameType.MATH_SUB:
        currentQuiz.value = MathGenerator().randomSubQuiz(difficulty);
        break;
      case GameType.MATH_MUL:
        currentQuiz.value = MathGenerator().randomMulQuiz(difficulty);
        break;
      case GameType.MATH_DIV:
        currentQuiz.value = MathGenerator().randomDivQuiz(difficulty);
        break;
      case GameType.MATH_ALL:
        currentQuiz.value = MathGenerator().randomAllQuiz(difficulty);
        break;
      default:
    }
  }

  void start() {
    isStarted.value = true;
    setQuiz();
    currentPosition.value += 1;
  }

  void next() {
    if (isOver.isTrue) return;
    if (currentPosition.value >= size) {
      analytics.logEvent(name: "played", parameters: {
        "uid": userId,
        "game": "math add",
        "result": points.value
      }).then((value) {
        // print("saved");
      });
      print(points.value);
      _userFirestore.played(points.value);
      isOver.value = true;
      isStarted.value = false;
    } else {
      quizHistory.add(currentQuiz.value!.copy(currentStatus.value));
      setQuiz();
      currentPosition.value += 1;
    }
  }

  void answer(double answer) {
    int score = 0;
    if (currentQuiz.value?.answer == answer) {
      currentStatus.value = QuizStatus.CORRECT;
      score = pointPerQuestion;
    } else {
      currentStatus.value = QuizStatus.WRONG;
      score = -1 * pointPerQuestion;
    }
    points += score;
  }

  void reset() {
    isStarted.value = false;
    isOver.value = false;
    points.value = 0;
    currentStatus.value = QuizStatus.NOT_ANSWER;
    quizHistory.value = [];
    currentQuiz.value = null;
    currentPosition.value = 0;
  }
}
