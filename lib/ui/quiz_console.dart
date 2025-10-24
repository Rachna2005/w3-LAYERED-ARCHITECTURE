import 'dart:io';
import '../domain/quiz.dart';
import '../data/quiz_file_provider.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your name: ');
      String? nameInput = stdin.readLineSync()?.trim();
      if (nameInput == null || nameInput.isEmpty) {
        print('--- Quiz Finished ---');
        quiz.displayAllPlayerScores();
        break;
      }
      // quiz.answers.clear();
      Player currentPlayer = Player(name: nameInput);

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.point} point)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          currentPlayer.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }
      int score = currentPlayer.getScoreInPercentage();
      int myPoint = currentPlayer.getScoreInPoint();
      // print('--- Quiz Finished ---');
      quiz.addPlayer(currentPlayer);
      print('\n--- Quiz Completed ---');
      print('Your score in percentage: $score % ');
      print('Your score in point: $myPoint ');
      quiz.displayAllPlayerScores();
    }
  }
}
