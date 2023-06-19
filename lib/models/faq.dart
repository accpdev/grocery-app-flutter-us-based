class FAQ {
  FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });

  late final String id;
  late final String question;
  late final String answer;
  bool isExpanded = false;

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    question = json['question'].toString();
    answer = json['answer'].toString();
    isExpanded = json['is_expanded'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['question'] = question;
    itemData['answer'] = answer;
    itemData['is_expanded'] = isExpanded;
    return itemData;
  }
}
