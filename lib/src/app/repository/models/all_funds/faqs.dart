class Ques {
  final FundQuestions data;

  Ques({
    required this.data,
  });

  factory Ques.fromJson(Map<String, dynamic> json) => Ques(
        data: FundQuestions.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class FundQuestions {
  final List<Faq> faqs;

  FundQuestions({
    required this.faqs,
  });

  factory FundQuestions.fromJson(Map<String, dynamic> json) => FundQuestions(
        faqs: List<Faq>.from(json["faqs"].map((x) => Faq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "faqs": List<dynamic>.from(faqs.map((x) => x.toJson())),
      };
}

class Faq {
  final String question;
  final String answer;

  Faq({
    required this.question,
    required this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
