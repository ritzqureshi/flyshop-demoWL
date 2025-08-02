class TravelBlogModel {
  String? id;
  String? blogHeading;
  String? contents;
  String? slug;
  String? featureImage;
  String? wlid;

  TravelBlogModel(
      {this.id,
      this.blogHeading,
      this.contents,
      this.slug,
      this.featureImage,
      this.wlid});

  TravelBlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogHeading = json['blog_heading'];
    contents = json['contents'];
    slug = json['slug'];
    featureImage = json['feature_image'];
    wlid = json['wlid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['blog_heading'] = blogHeading;
    data['contents'] = contents;
    data['slug'] = slug;
    data['feature_image'] = featureImage;
    data['wlid'] = wlid;
    return data;
  }
}
