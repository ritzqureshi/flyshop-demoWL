class FAQModel {
  String? id;
  String? question;
  String? answer;
  String? category;
  String? channelMode;
  String? agentId;

  FAQModel({
    this.id,
    this.question,
    this.answer,
    this.category,
    this.channelMode,
    this.agentId,
  });

  FAQModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    category = json['category'];
    channelMode = json['channel_mode'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['category'] = category;
    data['channel_mode'] = channelMode;
    data['agent_id'] = agentId;
    return data;
  }
}
