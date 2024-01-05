class MorrfFaq {
  final String id;
  final String question;
  final String answer;

  MorrfFaq({required this.id, required this.question, required this.answer});

  MorrfFaq.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        question = data['question'],
        answer = data['answer'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
    };
  }
}

class MorrfServiceQuestion {
  final String id;
  final String question;
  final String answer;

  MorrfServiceQuestion(
      {required this.id, required this.question, required this.answer});

  MorrfServiceQuestion.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        question = data['question'],
        answer = data['answer'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
    };
  }
}
