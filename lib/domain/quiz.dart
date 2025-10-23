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

class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];
  List<Player> players = [];

  Quiz({String? id, required this.questions}) : id = id ?? const Uuid().v4();

  void addAnswer(Answer asnwer) {
    this.answers.add(asnwer);
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
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

  void addPlayerOrUpdate(String name, int points, int percent) {
    Player? oldPlayer;
    for (var player in players) {
      if (player.name == name) {
        oldPlayer = player;
        break;
      }
    }
    if (oldPlayer != null) {
      oldPlayer.updateScores(points, percent);
    } else {
      Player newPlayer =
          Player(name: name, lastPoints: points, lastPercentage: percent);
      players.add(newPlayer);
    }
  }

  void allPlayerScores() {
    if (players.isEmpty) {
      print('No player yet');
      return;
    }
    for (var player in players) {
      print('Player : $player');
    }
  }

}

class Player {
  final String id;
  final String name;
  int lastPoints;
  int lastPercentage;

  Player(
      {String? id,
      required this.name,
      this.lastPoints = 0,
      this.lastPercentage = 0})
      : id = id ?? const Uuid().v4();

  void updateScores(int points, int percentage) {
    lastPoints = points;
    lastPercentage = percentage;
  }

  @override
  String toString() {
    return '$name: $lastPoints points $lastPercentage%';
  }
}
