import 'dart:ffi';
import 'package:uuid/uuid.dart';

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  int point;

  Question(
      {String? id,
      required this.title,
      required this.choices,
      required this.goodChoice,
      this.point = 1})
      : id = id ?? Uuid().v4();
}

class Answer {
  final String id;
  final Question question;
  final String answerChoice;

  Answer({String? id, required this.question, required this.answerChoice})
      : id = id ?? const Uuid().v4();

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  final String id;
  final String name;
  List<Answer> answers = [];
  Player({String? id, required this.name}) : id = id ?? const Uuid().v4();

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  int getScoreInPercentage() {
    int totalScore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalScore++;
      }
    }
    return answers.isEmpty ? 0 : ((totalScore / answers.length) * 100).toInt();
  }

  int getScoreInPoint() {
    int totalPoint = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalPoint += answer.question.point;
      }
    }
    return totalPoint;
  }

  @override
  String toString() {
    return '$name: ${getScoreInPoint()} points ${getScoreInPercentage()}%';
  }
}

class Quiz {
  final String id;
  List<Question> questions;
  List<Player> players = [];

  Quiz({String? id, required this.questions}) : id = id ?? const Uuid().v4();

  void addPlayer(Player player) {
    // Find if player already exists and update their answers
    for (Player p in players) {
      if (p.name.toLowerCase() == player.name.toLowerCase()) {
        p.answers = player.answers;
        return;
      }
    }
    // If not found, add new player
    players.add(player);
  }
  void displayAllPlayerScores() {
    if (players.isEmpty) {
      print('No players yet');
      return;
    }
    for (var player in players) {
      print('Player: $player');
    }
  }
}
