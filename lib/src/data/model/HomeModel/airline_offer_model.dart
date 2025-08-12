class AirlineOfferModel {
  String? id;
  String? category;
  String? image;

  AirlineOfferModel({this.id, this.category, this.image});

  AirlineOfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}
