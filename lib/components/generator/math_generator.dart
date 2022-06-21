import 'dart:math';

import 'package:ayuu_quiz/models/math_quiz.dart';

class MathGenerator {
  final random = Random();

  List<MathQuiz> generateAddQuiz(int size, int difficulty) {
    List<MathQuiz> list = [];
    for (var i = 0; i < size; i++) {
      list.add(randomAddQuiz(difficulty));
    }
    return list;
  }

  MathQuiz randomAddQuiz(int difficulty) {
    double min = 1;
    // 1=>10 2=>40
    double max = 10 * difficulty.toDouble() * 2;
    double x = random.nextInt((max + min).toInt()) + min;
    double y = random.nextInt((max + min).toInt()) + min;
    double ans = x + y;
    List<double> otherOptions = getNumbersArround(ans).sublist(0, 2);
    List<double> options = [...otherOptions, ans, _getSimilarNumber(ans)];
    options.shuffle();
    return MathQuiz(
        question: "${x.toInt()} + ${y.toInt()}", answer: ans, options: options);
  }

  MathQuiz randomAllQuiz(int difficulty) {
    int type = random.nextInt(4);
    switch (type) {
      case 0:
        return randomAddQuiz(difficulty);
      case 1:
        return randomSubQuiz(difficulty);
      case 2:
        return randomMulQuiz(difficulty);
      case 3:
        return randomDivQuiz(difficulty);
      default:
        return randomAddQuiz(difficulty);
    }
  }

  MathQuiz randomDivQuiz(int difficulty) {
    double min = 1;
    // 1=>10 2=>40
    double max = 10 * difficulty.toDouble();
    double ans = random.nextInt((max + min).toInt()) + min;
    double y = random.nextInt((max + min).toInt()) + min;
    double x = ans * y;
    List<double> otherOptions =
        getNumbersArround(ans, arround: 50).sublist(0, 2);
    List<double> options = [...otherOptions, ans, _getSimilarNumber(ans)];
    options.shuffle();
    return MathQuiz(
        question: "${x.toInt()} / ${y.toInt()}", answer: ans, options: options);
  }

  MathQuiz randomMulQuiz(int difficulty) {
    print(difficulty);
    double min = 1;
    // 1=>10 2=>40
    double max = 10 * difficulty.toDouble();
    double x = random.nextInt((max + min).toInt()) + min;
    double y = random.nextInt((max + min).toInt()) + min;
    double ans = x * y;
    List<double> otherOptions =
        getNumbersArround(ans, arround: 50).sublist(0, 2);
    List<double> options = [...otherOptions, ans, _getSimilarNumber(ans)];
    options.shuffle();
    return MathQuiz(
        question: "${x.toInt()} * ${y.toInt()}", answer: ans, options: options);
  }

  MathQuiz randomSubQuiz(int difficulty) {
    double min = 1;
    // 1=>10 2=>40
    double max = 10 * difficulty.toDouble() * 2;
    double x = random.nextInt((max + min).toInt()) + min;
    double y = random.nextInt((max + min).toInt()) + min;
    if (x < y) {
      double t = x;
      x = y;
      y = t;
    }
    double ans = x - y;
    List<double> otherOptions = getNumbersArround(ans).sublist(0, 2);
    List<double> options = [...otherOptions, ans, _getSimilarNumber(ans)];
    options.shuffle();
    return MathQuiz(
        question: "${x.toInt()} - ${y.toInt()}", answer: ans, options: options);
  }

  double _getSimilarNumber(double num) {
    int v = random.nextInt(2);
    if (v == 0 && (num - 10) > 0) {
      return num - 10;
    } else {
      return num + 10;
    }
  }

  List<double> getNumbersArround(double num, {arround = 20, skip = 1}) {
    double min = num - arround;
    if (min < 1) {
      arround += (min * -1) + 1;
      min = 1;
    }
    double max = num + arround;

    List<double> list = [];
    for (var i = min; i < max; i += skip) {
      if (i != num) {
        list.add(i);
      }
    }
    list.shuffle();
    return list;
  }
}
