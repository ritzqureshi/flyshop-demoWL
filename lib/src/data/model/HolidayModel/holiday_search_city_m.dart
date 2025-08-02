class HolidaySearchCityModel {
  String? location;
  String? id;

  HolidaySearchCityModel({this.location, this.id});

  HolidaySearchCityModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['id'] = id;
    return data;
  }
}
