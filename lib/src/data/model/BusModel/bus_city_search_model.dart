class BusSearchCityModel {
  int? cityId;
  String? cityName;
  String? id;

  BusSearchCityModel({this.cityId, this.cityName, this.id});

  BusSearchCityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['id'] = id;
    return data;
  }
}
