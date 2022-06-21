class MathQuiz {
  String question;
  double answer;
  List<double> options;
  int status;
  MathQuiz(
      {required this.question,
      required this.answer,
      required this.options,
      this.status = 1});
  MathQuiz copy(status) {
    return MathQuiz(
        question: question, answer: answer, options: options, status: status);
  }
}
