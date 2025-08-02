class CustomDrawerItemModel {
  String? id;
  String? pageName;
  String? pageTitle;

  CustomDrawerItemModel({this.id, this.pageName, this.pageTitle});

  CustomDrawerItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    pageTitle = json['page_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page_name'] = pageName;
    data['page_title'] = pageTitle;
    return data;
  }
}

class CmsPageModel {
  final String? id;
  final String? pageName;
  final String? pageTitle;
  final String? pageKeyword;
  final String? pageDescription;
  final String? pageContents;

  CmsPageModel({
    this.id,
    this.pageName,
    this.pageTitle,
    this.pageKeyword,
    this.pageDescription,
    this.pageContents,
  });

  factory CmsPageModel.fromJson(Map<String, dynamic> json) {
    return CmsPageModel(
      id: json['id'],
      pageName: json['page_name'],
      pageTitle: json['page_title'],
      pageKeyword: json['page_keyword'],
      pageDescription: json['page_description'],
      pageContents: json['page_contents'],
    );
  }
}
