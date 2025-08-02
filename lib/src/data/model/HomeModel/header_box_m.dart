class HeaderBoxModel {
  bool? status;
  Data? data;

  HeaderBoxModel({this.status, this.data});

  HeaderBoxModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? b2cTheme;
  String? flight;
  String? hotel;
  String? holiday;
  String? bus;
  String? cabEnquiry;
  String? activity;
  String? train;
  String? groupEnquiry;
  String? visa;
  String? umrah;
  String? cruise;
  String? newcarbooking;
  String? sSR;
  String? cab;
  String? parentId;

  Data(
      {this.id,
      this.b2cTheme,
      this.flight,
      this.hotel,
      this.holiday,
      this.bus,
      this.cabEnquiry,
      this.activity,
      this.train,
      this.groupEnquiry,
      this.visa,
      this.umrah,
      this.cruise,
      this.newcarbooking,
      this.sSR,
      this.cab,
      this.parentId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    b2cTheme = json['b2c_theme'].toString();
    flight = json['flight'];
    hotel = json['hotel'];
    holiday = json['holiday'];
    bus = json['bus'];
    cabEnquiry = json['cab_enquiry'];
    activity = json['activity'];
    train = json['train'];
    groupEnquiry = json['group_enquiry'];
    visa = json['visa'];
    umrah = json['umrah'];
    cruise = json['cruise'];
    newcarbooking = json['newcarbooking'];
    sSR = json['SSR'];
    cab = json['cab'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['b2c_theme'] = b2cTheme;
    data['flight'] = flight;
    data['hotel'] = hotel;
    data['holiday'] = holiday;
    data['bus'] = bus;
    data['cab_enquiry'] = cabEnquiry;
    data['activity'] = activity;
    data['train'] = train;
    data['group_enquiry'] = groupEnquiry;
    data['visa'] = visa;
    data['umrah'] = umrah;
    data['cruise'] = cruise;
    data['newcarbooking'] = newcarbooking;
    data['SSR'] = sSR;
    data['cab'] = cab;
    data['parentId'] = parentId;
    return data;
  }
}
