class PopularDestinationModel {
  String? id;
  String? city;
  String? image;
  String? agentId;

  PopularDestinationModel({this.id, this.city, this.image, this.agentId});

  PopularDestinationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    image = json['image'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['city'] = city;
    data['image'] = image;
    data['agent_id'] = agentId;
    return data;
  }
}
