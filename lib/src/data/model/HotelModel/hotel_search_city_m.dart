class HotelSearchCityModel {
  String? id;
  String? cityName;
  String? countryName;
  String? fullRegionName;
  String? type;
  int? cityCode;

  HotelSearchCityModel(
      {this.id,
      this.cityName,
      this.countryName,
      this.fullRegionName,
      this.type,
      this.cityCode});

  HotelSearchCityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['cityName'];
    countryName = json['countryName'];
    fullRegionName = json['fullRegionName'];
    type = json['type'];
    cityCode = json['cityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cityName'] = cityName;
    data['countryName'] = countryName;
    data['fullRegionName'] = fullRegionName;
    data['type'] = type;
    data['cityCode'] = cityCode;
    return data;
  }
}
