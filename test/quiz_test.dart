import 'package:test/test.dart';
import 'package:my_first_project/domain/quiz.dart';

main() {
  // test('My first test', () {
  //   // Do something
  //   int x = 2 + 2;

  //   // Check something
  //   expect(x, equals(4));
  // });
  Question q1 =
      Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2", point: 10);
  Question q2 =
      Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6", point: 50);
  Quiz quizs = Quiz(questions: [q1, q2]);
  test('test1', () {
    Player player = Player(name: "TestPlayer");
    player.addAnswer(Answer(question: q1, answerChoice: '2'));
    player.addAnswer(Answer(question: q2, answerChoice: '6'));
    
    expect(player.getScoreInPercentage(), equals(100));
    expect(player.getScoreInPoint(), equals(60));
  });
  test('test2', () {
    Player player = Player(name: "TestPlayer");
    player.addAnswer(Answer(question: q1, answerChoice: '2'));
    player.addAnswer(Answer(question: q2, answerChoice: '8'));
    
    expect(player.getScoreInPercentage(), equals(50)); 
    expect(player.getScoreInPoint(), equals(10)); 
  });
}
