class OfferModel {
  String? id;
  String? image;
  String? name;
  String? description;
  String? category;
  String? channelMode;
  String? agentId;

  OfferModel(
      {this.id,
      this.image,
      this.name,
      this.description,
      this.category,
      this.channelMode,
      this.agentId});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    channelMode = json['channel_mode'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['channel_mode'] = channelMode;
    data['agent_id'] = agentId;
    return data;
  }
}
