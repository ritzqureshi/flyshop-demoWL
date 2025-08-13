import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/utils/functions.dart';
import 'package:ikotech/src/data/model/LoginModel/user_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/api/custom_item_drawer_api.dart';
import '../../data/model/customItemModel/custom_item_model.dart';

class CustomSideDrawer extends StatefulWidget {
  final UserModel? userModel;
  const CustomSideDrawer({super.key, this.userModel});

  @override
  State<CustomSideDrawer> createState() => _CustomSideDrawerState();
}

class _CustomSideDrawerState extends State<CustomSideDrawer> {
  List<CustomDrawerItemModel>? _drawerItems;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadDrawerItems();
  }

  Future<void> _loadDrawerItems() async {
    final data = await CustomItemDrawerApi.customDrawerItemMethod();
    setState(() {
      _drawerItems = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.75,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              Container(
                decoration: BoxDecoration(
                  color: FunctionsUtils.hexToColor(
                    Constant.backgroundThemeColor,
                  ),
                ),
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Row(
                    children: [
                      Text(
                        widget.userModel?.user?.email ?? "",
                        style: TextStyle(
                          color: FunctionsUtils.hexToColor(Constant.textColour),
                          fontSize: 21,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 38,
                          color: FunctionsUtils.hexToColor(Constant.textColour),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
              _isLoading
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: 6, // dummy placeholders
                        itemBuilder: (context, index) {
                          return _buildShimmerItem();
                        },
                      ),
                    )
                  : _drawerItems == null || _drawerItems!.isEmpty
                  ? Expanded(
                      child: Center(child: Text("No menu items available.")),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _drawerItems!.length,
                        itemBuilder: (context, index) {
                          final item = _drawerItems![index];
                          return _buildMenuItem(item);
                        },
                      ),
                    ),
             
              const Divider(),

              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      "© 2024 ${Constant.companyName}\nAll Rights Reserved.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/makeindia.png', // replace with actual asset path
                          height: 24,
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 32,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.orangeAccent,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '🇮🇳',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(CustomDrawerItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.pageTitle ?? ""),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.push(
              "/drawerItemPage",
              extra: item,
            );
            // getLog(item.toJson(), "item");
          },
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildShimmerItem() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListTile(
            title: Container(
              height: 16,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
            trailing: Container(width: 24, height: 24, color: Colors.white),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
