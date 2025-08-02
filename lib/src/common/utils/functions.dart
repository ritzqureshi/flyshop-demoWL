import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikotech/src/common/utils/colours.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

abstract class FunctionsUtils {
  //Show Dialog Method
  static void loadingDialog(
    BuildContext context, {
    String message = "Please wait..",
    bool preventBackClose = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: preventBackClose ? false : true,
          onPopInvokedWithResult: (val, res) {
            if (preventBackClose) {
              return;
            }
          },
          child: Dialog(
            child: preventBackClose
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoActivityIndicator(
                          radius: 20,
                        ), // Replaced with CircularProgressIndicator for compactness
                        const SizedBox(height: 20),
                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(fontSize: 16),
                            // textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoActivityIndicator(
                          radius: 15,
                        ), // Replaced with CircularProgressIndicator for compactness
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  static void toast(String msg) {
    BotToast.showText(text: msg);
  }

  static void toastAlertNotification(String msg, {int seconds = 3}) {
    BotToast.showSimpleNotification(
      title: msg,
      backgroundColor: Colors.orange[400],
      titleStyle: const TextStyle(color: Colors.white, fontSize: 18),
      duration: Duration(seconds: seconds),
    );
  }

  static void toastSuccessNotification(String msg, {int seconds = 3}) {
    BotToast.showSimpleNotification(
      title: msg,
      backgroundColor: MyColors.green,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 18),
      duration: Duration(seconds: seconds),
    );
  }

  static void toastFailedNotification(
    String msg, {
    int seconds = 3,
    String title = "Alert!",
  }) {
    BotToast.showSimpleNotification(
      title: title,
      subTitle: msg,
      backgroundColor: Colors.red[400],
      closeIcon: const Icon(Icons.close, color: Colors.white),
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      subTitleStyle: const TextStyle(color: Colors.white, fontSize: 18),
      duration: Duration(seconds: seconds),
    );
  }

  // static void saveUserDataLocally(StoreModel user) async {
  //   final userBox = Hive.box(Constant.companyName);
  //   await userBox.put('storeData', user.toJson());
  // }

  // static StoreModel? getUserDataLocally() {
  //   final userBox = Hive.box(Constant.companyName);
  //   final userData = userBox.get('storeData');
  //   if (userData == null) return null;
  //   final castedData = Map<String, dynamic>.from(userData);
  //   final userOnly = Map<String, dynamic>.from(castedData);
  //   return StoreModel.fromJson(userOnly);
  // }

  // static void logout() async {
  //   final userBox = Hive.box(Constant.companyName);
  //   userBox.delete(Constant.companyName);
  //   await userBox.delete('storeData');
  //   GoRouter.of(navigatorKey.currentState!.context).go('/login');
  // }

  //--------Android Dialog box for delete account-------//
  static void androidDialog(
    BuildContext context,
    Function()? onPressed, {
    String message = '',
    String titleMsg = 'Delete Message?',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              titleMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23),
            ),
          ),
          content: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle()),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: onPressed,
                  child: Container(
                    margin: EdgeInsets.all(1),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //------COnvvert into *--------//
  static String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 7) {
      return '*' * phoneNumber.length;
    }
    return '*' * 7 + phoneNumber.substring(7);
  }

  static void launchURL(
    String url, {
    LaunchMode mode = LaunchMode.inAppBrowserView,
  }) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: mode);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //------TextField input format for phone number-------//
  static List<TextInputFormatter> phoneInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly, // Allow only digits
      LengthLimitingTextInputFormatter(10), // Limit to 10 characters
    ];
  }

  //-------iOS dialog show for delete account-------///
  static void iOSdialog(
    BuildContext context,
    Function()? onPressed, {
    String message = 'Delete for Everyone?',
    String titleMsg = 'Delete Message?',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(
            alignment: Alignment.bottomCenter,
            child: Text(titleMsg, textAlign: TextAlign.center),
          ),
          // content: Container(
          //     alignment: Alignment.bottomCenter,
          //     child: const Text(
          //       'Delete Message?',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(),
          //     )),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle()),
            ),
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text(
                message,
                style: const TextStyle(
                  color: MyColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //-------Parse basefare and tax-----//
  static double parseValue(dynamic baseFare) {
    if (baseFare == null || baseFare.toString().isEmpty) {
      return 0.0; // Handle null or empty values
    }
    try {
      return double.parse(baseFare.toString());
    } catch (e) {
      getLog(e, "Err parseBaseFare");
      return 0.0; // Return 0.0 if parsing fails
    }
  }

  //-------DownLoad Pdf And File--------//
  static Future<void> downloadFileWebView(
    BuildContext context,
    Uri url,
    List<Cookie> cookies,
  ) async {
    try {
      FunctionsUtils.loadingDialog(context);
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = await getExternalStorageDirectory(); // Works for Android
      } else {
        downloadsDir =
            await getApplicationDocumentsDirectory(); // Works for iOS
      }
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(url);
      String cookieHeader = cookies
          .map((cookie) => "${cookie.name}=${cookie.value}")
          .join("; ");
      request.headers.set(HttpHeaders.cookieHeader, cookieHeader);
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String? fileName;
        String? contentDisposition = response.headers.value(
          HttpHeaders.contentDisposition,
        );
        String? contentType = response.headers.value(
          HttpHeaders.contentTypeHeader,
        );

        if (contentDisposition != null &&
            contentDisposition.contains("filename=")) {
          fileName = contentDisposition
              .split("filename=")
              .last
              .replaceAll('"', '');
        } else {
          fileName = url.pathSegments.last;
        }
        if (contentType != null && fileName.isNotEmpty) {
          if (contentType.contains("application/pdf")) {
            fileName = fileName.endsWith(".pdf") ? fileName : "$fileName.pdf";
          } else if (contentType.contains("application/vnd.ms-excel") ||
              contentType.contains(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              )) {
            fileName = fileName.endsWith(".xls") || fileName.endsWith(".xlsx")
                ? fileName
                : "$fileName.xls";
          }
        }
        String fullPath = "${downloadsDir?.path}/$fileName";
        File file = File(fullPath);
        await file.create(recursive: true);
        await response.pipe(file.openWrite());
        FunctionsUtils.toast("Download successfully");
        Navigator.of(context).pop();
        await OpenFile.open(file.path);
      } else {
        debugPrint("Failed to download file. Status: ${response.statusCode}");
      }
      httpClient.close();
    } catch (e) {
      debugPrint("Error during file download: $e");
    }
  }

  //--------Coommon Colour-------//
  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // add full opacity if not provided
    }
    return Color(int.parse(hex, radix: 16));
  }

  static Widget buildCachedImage(
    String imageUrl, {
    BoxFit fit = BoxFit.none,
    double? width,
    double? height,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ?? Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Image(image: AssetImage("assets/images/noimageavail.png"), fit: fit),
    );
  }

  //-----String to dot ------//
  static String truncateTextToDot(String text, int len) {
    try {
      List<String> words = text.split(' ');
      if (words.length <= len) {
        return text;
      } else {
        String truncatedText = words.take(len).join(' ');
        return '$truncatedText ...';
      }
    } catch (e) {
      getLog(e, "Err truncateTextToDot");
      return "";
    }
  }

  //--------Common Show Modal Sheet------//
  static void showTravellerSheet(
    BuildContext context, {
    Widget? widget,
    String title = "",
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.white,
      elevation: 1.9,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * .8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 40),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            widget ?? Container(),
          ],
        ),
      ),
    );
  }
}

void getLog(dynamic data, String title) {
  log("$title:-:$data");
}
