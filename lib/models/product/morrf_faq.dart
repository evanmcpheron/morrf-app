class MorrfFaq {
  final String id;
  final String question;
  final String answer;

  MorrfFaq({required this.id, required this.question, required this.answer});

  MorrfFaq.fromDat(Map<String, dynamic> data)
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
