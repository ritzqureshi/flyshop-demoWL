import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ikotech/src/common/utils/functions.dart';

import '../../data/model/HomeModel/travel_blog_model.dart';

class BlogDetailsWidget extends StatelessWidget {
  final TravelBlogModel travelBlog;
  const BlogDetailsWidget({super.key, required this.travelBlog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blog Details")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image with Overlay & Title
            Stack(
              children: [
                FunctionsUtils.buildCachedImage(
                  travelBlog.featureImage ?? "",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      travelBlog.blogHeading ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Html(data: travelBlog.contents ?? ""),
          ],
        ),
      ),
    );
  }
}
