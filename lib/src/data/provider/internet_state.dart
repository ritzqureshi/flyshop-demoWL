import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../../main.dart';


class InternetConnectivityState with ChangeNotifier {
  //Continous connectivity controller for internet connection
  final _connectionStatusController = StreamController<ConnectivityResult>();
  String? connectionStatus;

  final Connectivity _connectivity = Connectivity();
  bool _isDialogVisible = false;
  BuildContext? dialogContext;

  InternetConnectivityState() {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        for (var result in results) {
          _connectionStatusController.add(result);
        }
      },
    );
  }

  dynamic checkConnectivity(BuildContext context) async {
    try {
      _connectivity.onConnectivityChanged
          .listen((List<ConnectivityResult> results) {
        for (var result in results) {
          if (result == ConnectivityResult.none) {
            if (!_isDialogVisible) {
              _isDialogVisible = true;
              Platform.isAndroid
                  ? _openDialog(navigatorKey.currentState!.overlay!.context)
                  : _showAlertDialog(
                      navigatorKey.currentState!.overlay!.context);
            }
          } else {
            if (_isDialogVisible) {
              _isDialogVisible = false;
              navigatorKey.currentState!.pop();
            }
          }
        }
      });

      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      connectionStatus = 'Failed to get the connection result';
    }
  }

  void _openDialog(context) {
    //if condition is only becsuse of build method is called evertime so many time which makes
    if (!_isDialogVisible) {
      showDialog<void>(
          barrierDismissible: false,
          barrierColor: const Color.fromARGB(1, 97, 94, 94),
          context: context,
          builder: (context) {
            dialogContext = context;
            return const AlertDialog(
              title: Center(child: Text("Alert")),
              content: Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text('No Internet Connection'),
              ),
            );
          });
      _isDialogVisible = true;
    }
  }

  _showAlertDialog(context) {
    if (!_isDialogVisible) {
      showCupertinoModalPopup(
        barrierDismissible: false,
        barrierColor: const Color.fromARGB(1, 97, 94, 94),
        context: context,
        builder: (context) => const CupertinoAlertDialog(
          title: Text('Alert'),
          content: Text('No Internet Connection'),
        ),
      );
      _isDialogVisible = true;
    }
  }
}