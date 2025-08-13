import '../../common/api_services.dart';
import '../../common/utils/constant.dart';
import '../../common/utils/functions.dart';
import '../model/customItemModel/custom_item_model.dart';

class CustomItemDrawerApi {
  static Future<List<CustomDrawerItemModel>?> customDrawerItemMethod() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.customItemDrawerApi;
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final offerAndDeals = (response.data['data'] as List)
            .map((item) => CustomDrawerItemModel.fromJson(item))
            .toList();
        return offerAndDeals;
      }
      return null;
    } catch (e) {
      getLog(e.toString(), "Error customDrawerItemMethod");
      return null;
    }
  }

  static Future<CmsPageModel?> getPageContent(String pageId) async {
    try {
      // getLog("${Constant.customItemDrawerPageContentApi}$pageId", "urlToyse");
      final dioCommon = DioCommon();
      dioCommon.setUrl = "${Constant.customItemDrawerPageContentApi}$pageId";
      dioCommon.setMethod = "GET";
      final response = await dioCommon.response;
      CmsPageModel? contentData;
      if (response.statusCode == 200) {
        contentData = CmsPageModel.fromJson(response.data['data']);
        return contentData;
      }
      return Future.value(contentData);
    } catch (e) {
      getLog(e.toString(), "Error getPageContent");
      return null;
    }
  }
}
