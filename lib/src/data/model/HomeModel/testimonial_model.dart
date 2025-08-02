class TestimonialModel {
  String? id;
  String? image;
  String? name;
  String? rating;
  String? contents;
  String? testType;
  String? agentId;

  TestimonialModel({
    this.id,
    this.image,
    this.name,
    this.rating,
    this.contents,
    this.testType,
    this.agentId,
  });

  TestimonialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    rating = json['rating'];
    contents = json['contents'];
    testType = json['test_type'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['rating'] = rating;
    data['contents'] = contents;
    data['test_type'] = testType;
    data['agent_id'] = agentId;
    return data;
  }
}
