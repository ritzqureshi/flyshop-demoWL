class WhyWithUsModel {
  String? id;
  String? icon;
  String? heading;
  String? contents;
  String? category;
  String? agentId;

  WhyWithUsModel(
      {this.id,
      this.icon,
      this.heading,
      this.contents,
      this.category,
      this.agentId});

  WhyWithUsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    heading = json['heading'];
    contents = json['contents'];
    category = json['category'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['heading'] = heading;
    data['contents'] = contents;
    data['category'] = category;
    data['agent_id'] = agentId;
    return data;
  }
}
