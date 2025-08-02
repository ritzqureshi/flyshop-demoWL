import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/api/custom_item_drawer_api.dart';
import '../../data/model/customItemModel/custom_item_model.dart';

class CmsPageScreen extends StatefulWidget {
  final CustomDrawerItemModel itemData;
  const CmsPageScreen({super.key, required this.itemData});

  @override
  State<CmsPageScreen> createState() => _CmsPageScreenState();
}

class _CmsPageScreenState extends State<CmsPageScreen> {
  CmsPageModel? _cmsPage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  Future<void> _loadPage() async {
    final data = await CustomItemDrawerApi.getPageContent(
      widget.itemData.id ?? "",
    );
    setState(() {
      _cmsPage = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.itemData.pageTitle ?? "")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cmsPage == null
          ? Center(child: Text("No content found."))
          : SingleChildScrollView(
              child: Html(data: _cmsPage!.pageContents ?? ""),
            ),
    );
  }
}
