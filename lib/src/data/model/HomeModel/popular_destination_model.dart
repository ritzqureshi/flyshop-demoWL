class PopularDestinationModel {
  String? id;
  String? packageTitle;
  String? location;
  String? flightIcon;
  String? hotelIcon;
  String? sightseeingIcon;
  String? transferIcon;
  String? activityIcon;
  String? packageType;
  String? perAdultPrice;
  String? image;
  String? agentId;

  PopularDestinationModel(
      {this.id,
      this.packageTitle,
      this.location,
      this.flightIcon,
      this.hotelIcon,
      this.sightseeingIcon,
      this.transferIcon,
      this.activityIcon,
      this.packageType,
      this.perAdultPrice,
      this.image,
      this.agentId});

  PopularDestinationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageTitle = json['package_title'];
    location = json['location'];
    flightIcon = json['flight_icon'];
    hotelIcon = json['hotel_icon'];
    sightseeingIcon = json['sightseeing_icon'];
    transferIcon = json['transfer_icon'];
    activityIcon = json['activity_icon'];
    packageType = json['package_type'];
    perAdultPrice = json['per_adult_price'];
    image = json['image'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_title'] = packageTitle;
    data['location'] = location;
    data['flight_icon'] = flightIcon;
    data['hotel_icon'] = hotelIcon;
    data['sightseeing_icon'] = sightseeingIcon;
    data['transfer_icon'] = transferIcon;
    data['activity_icon'] = activityIcon;
    data['package_type'] = packageType;
    data['per_adult_price'] = perAdultPrice;
    data['image'] = image;
    data['agent_id'] = agentId;
    return data;
  }
}
