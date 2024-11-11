import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:moneymanager_clone/views/login_page.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_logger/pretty_logger.dart';

import '../constants/api_endpoint.dart';
import '../main.dart';
import '../utils/snackbar/snack_message.dart';
import 'shared_preferences/user_creds.dart';

class HttpConfig {
  final UserCredintailStore _credintailStore = UserCredintailStore();
//set url in Api End point
  // final String _baseUrl = 'https://mobileapp-api.groundmetrx.com/api/v1/driver';
  // final String _baseUrl = 'https://portal.groundmetrx.com/api/v1/driver';
  final String _baseUrl = 'http://10.0.2.2/moneyManager_api';
  // final String _baseUrl = 'https://team-a.groundmetrx.com/api/v1/driver';
  // final String _baseUrl = 'https://groundmetrx.com/api/v1/driver';

  /// Post Request
  // int _postMethodCallCount = 0
  Future<String?> post({
    required String path,
    Map? body,
  }) async {
    if (_checkNetwork()) {
      PLog.blue("endPoint     ------------------$path");
      PLog.blue("Body     ------------------${jsonEncode(body)}");

      return await _post(
        path: path,
        body: body,
      );
    } else {
      /// Show message of No Internet
      return null;
    }
  }

  /// private _post method
  Future<String?> _post({required String path, Map? body}) async {
    // postMethodCallCount = postMethodCallCount + 1;
    String? token = await _credintailStore.getJwt();
    //PLog.red('access token ------ $token');

    try {
      final response = await http.post(
        Uri.parse(_baseUrl + path),
        body: body != null ? jsonEncode(body) : null,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          'Content-Type': 'application/json',
          if (path != ApiEndPoint.logIn) "Authorization": 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => http.Response(
            jsonEncode({
              'message':
                  'Request Timeout / Weak Internet / Internet Connection Lost'
            }),
            408),
      );
      PLog.green(response.statusCode.toString());
      // PLog.red('response  ---${response.body}');
      debugPrint('response  ---${response.body}');

      // PLog.green(response.headers.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        // _postMethodCallCount = 0;
        PLog.yellow(response.statusCode.toString());

        return response.body;
      } else {
        await _statusCodeCheck(path: path, responce: response
            // statusCode: response.statusCode,
            // body: response.body,
            );
        // SnackMessage.faildMessage(msg: jsonDecode(response.body)["message"]);
        debugPrint('response vulval ---${response.statusCode}');

        return null;
      }
    } catch (e) {
      SnackMessage.faildMessage(msg: e.toString());
      PLog.red("$e");
      return null;
    }
  }

  int _patchMethodCallCount = 0;
  //PRIVATE PATCH METHOD
  Future<String?> _patch({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    try {
      String? token = await _credintailStore.getJwt();
      // String? rtoken = await _credintailStore.getRefreshToken();
      //PLog.red('access token ------ $token');
      //PLog.red('refresh token ------ $rtoken');

      // patchMethodCallCount = patchMethodCallCount + 1;
      final response = await http.patch(
        Uri.parse(_baseUrl + path),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => http.Response(
            jsonEncode({
              'message':
                  'Request Timeout / Weak Internet / Internet Connection Lost'
            }),
            408),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _patchMethodCallCount = 0;
        return response.body;
      } else {
        await _statusCodeCheck(path: path, responce: response
            // statusCode: response.statusCode,
            // body: response.body,
            );
        _patchMethodCallCount = 0;
        return null;
      }
    } catch (e) {
      //PLog.red('Patch method error $e');
    }
    return null;
  }

  //PATCH REQUEST
  Future<String?> patch({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    if (_checkNetwork()) {
      return await _patch(
        path: path,
        body: body,
      );
    } else {
      return null;
    }
  }

  /// Get Request
  int _getMethodCallCount = 0;
  Future<String?> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    if (_checkNetwork()) {
      PLog.blue("endPoint     ------------------$path");

      return await _get(path: path, queryParams: queryParams);
    } else {
      ///
      return null;
    }
  }

  /// Common Functions
  Future<String?> _get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    /// Call user credintial store and retrive JWT token
    /// parse that token to [token]

    String? token = await _credintailStore.getJwt();
    PLog.red('access token ------ $token');

    final response = await http.get(
      Uri.parse(_baseUrl + path).replace(queryParameters: queryParams),
      headers: {
        "Accept": 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () => http.Response(
          jsonEncode({
            'message':
                'Request Timeout / Weak Internet / Internet Connection Lost'
          }),
          408),
    );
    PLog.cyan(Uri.parse(_baseUrl + path)
        .replace(queryParameters: queryParams)
        .toString());
    PLog.red('get response ------ ${response.body}');
    PLog.red('get header ------ ${response.headers}');
    // PLog.red('get request ------ ${response.request}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      _getMethodCallCount = 0;
      // PLog.red('get response body ------ ${response.body}');

      return response.body;
    } else {
      await _statusCodeCheck(
        path: path,
        responce: response,
        // statusCode: response.statusCode,
        // body: response.body,
      );
      _getMethodCallCount = 0;
      return null;
    }
  }

  /// Status code check
  _statusCodeCheck({
    required http.Response responce,
    String? path,
  }) async {
    path != null ? PLog.red(path) : null;
    int statusCode = responce.statusCode;
    String body = responce.body;
    switch (statusCode) {
      case 400:
        PLog.yellow((responce.request ?? "").toString());

        SnackMessage.faildMessage(msg: jsonDecode(body)['message']);
        break;
      case 401:
        PLog.yellow(body.toString());
        SnackMessage.warningMessage(msg: jsonDecode(body)['message']);
        _credintailStore.deleteJwt();

        navigationKey.currentState!.pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => LoginPage(),
            ),
            (route) => false);
        break;
      case 404:
        PLog.red(body.toString());
        SnackMessage.faildMessage(msg: jsonDecode(body)['message']);
        break;
      case 422:
        PLog.red(body.toString());
        if (jsonDecode(body)['data'] != [] &&
            jsonDecode(body)['data'] != null) {
          SnackMessage.faildMessageWithErrorData(
              data: jsonDecode(body)['data']);
        } else {
          SnackMessage.faildMessage(msg: jsonDecode(body)['message']);
        }
        break;
      case 429:
        PLog.yellow(body.toString());
        SnackMessage.warningMessage(msg: jsonDecode(body)['message']);

        _credintailStore.deleteJwt();

        break;
      case 503:
        PLog.red(body.toString());
        // await underMaintainance("GX server under maintainance.");
        SnackMessage.faildMessage(msg: jsonDecode(body)['message']);
        break;
      default:
        SnackMessage.warningMessage(msg: jsonDecode(body)['message']);
        break;
    }
  }

  // Future<void> underMaintainance(x,
  //     {String image = ImagesPath.notFound404}) async {
  //   await showDialog(
  //     barrierDismissible: false,
  //     context: navigationKey.currentState!.context,
  //     builder: (context) => CustomTextEmptyWarningDialogue(
  //       contentText: x,
  //       icon: Image.asset(image),
  //     ),
  //   );
  // }

  /// Refresh Token
  Future<void> refreshToken() async {
    /// Get refresh Token from User Credintial Store
    // String? refreshToken = await _credintailStore.getRefreshToken();

    /// parse that to body
    // final resData = await _post(
    //   path: '/v1/auth/refresh-tokens',
    //   body: {"refreshToken": "$refreshToken"},
    // );

    // RefreshTokenModel data = RefreshTokenModel.fromJson(
    //   jsonDecode(resData!),
    // );

    //PLog.yellow('Refresh token data $refreshToken');
    // await _credintailStore.setJwt(data.tokens!.access!.token!);
    // await _credintailStore.setRefreshToken(data.tokens!.refresh!.token!);

    /// After get response store refresh token and jwt token
    /// to user credintal store
  }

  /// Network check
  bool _checkNetwork() {
    // connectivityController.setStatus();
    // return connectivityController.connectionStatus;
    return true;
  }

  Future<String?> fileUpload(
      {required String filePath, required String endPoint}) async {
    try {
      if (_checkNetwork()) {
        var request =
            http.MultipartRequest('POST', Uri.parse(_baseUrl + endPoint));
        request.files.add(await http.MultipartFile.fromPath("image", filePath));

        final String? token = await _credintailStore.getJwt();

        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

        final streamedResponce = await request.send();
        http.Response responce =
            await http.Response.fromStream(streamedResponce);
        if (streamedResponce.statusCode == 200) {
          return responce.body;
        } else {
          await _statusCodeCheck(responce: responce
              // statusCode: response.statusCode,
              // body: result,
              );
          return null;
        }
        // final result = await http.Response.fromStream(response);
      } else {
        return null;
      }
    } catch (e) {
      SnackMessage.faildMessage(
          msg: "Something went wrong! \nPlease try again! $e");
      return null;
    }
  }

  Future<String?> postWithFilePaths(
      {required Map<String, List<String>> bodyWithFiles,
      required String path,
      Map<String, String>? body}) async {
    try {
      if (_checkNetwork()) {
        final String? token = await _credintailStore.getJwt();

        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(_baseUrl + path));
        PLog.yellow('Request initialized: $request');

        if (bodyWithFiles.isNotEmpty) {
          for (var x in bodyWithFiles.keys) {
            if (bodyWithFiles[x] != null && bodyWithFiles[x]!.isNotEmpty) {
              for (var f in bodyWithFiles[x]!) {
                request.files.add(await http.MultipartFile.fromPath(x, f));
                PLog.yellow('Added file: $f to field: $x');
              }
            }
          }
        }

        if (body != null) {
          request.fields.addAll(body);
          PLog.yellow('Added body fields: $body');
        }

        PLog.yellow(
            'Request files: ${request.files.map((e) => "${e.field}:${e.filename}")}');
        PLog.yellow('Request fields: ${request.fields}');

        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
        PLog.yellow('Request headers: ${request.headers}');

        final streamedResponce = await request.send();
        PLog.yellow(
            'Response status: ${streamedResponce.statusCode} ${streamedResponce.reasonPhrase}');

        http.Response responce =
            await http.Response.fromStream(streamedResponce);
        PLog.yellow('Response body: ${responce.body}');

        if (streamedResponce.statusCode == 200) {
          return responce.body;
        } else {
          await _statusCodeCheck(
              // statusCode: response.statusCode,
              // body: result.body,
              responce: responce);
          PLog.green('Status code check result: ${responce.body}');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      PLog.red('Error: $e');
      SnackMessage.faildMessage(
          msg: "Something went wrong! \nPlease try again! $e");
      return null;
    }
  }

  // Future<String?> downloadFile({
  //   required String path,
  // }) async {
  //   try {
  //     // Get the directory to save the file
  //     Directory? appDocDir = Platform.isAndroid
  //         ? await getDownloadsDirectory()
  //         : await getApplicationDocumentsDirectory();

  //     String appDocPath = appDocDir!.path;

  //     // Create the full path for the file
  //     String fullPath =
  //         '$appDocPath/${DateTime.now().toUtc().toIso8601String()}.${path.split(".").last}';
  //     final res = await http.get(Uri.parse(path));
  //     // PLog.red('${res.body}');

  //     if (res.statusCode == 200) {
  //       // Write the file to the local storage
  //       File file = File(fullPath);
  //       await file.writeAsBytes(res.bodyBytes);
  //       final x = await OpenFile.open(file.path);
  //       PLog.green('File downloaded to ${file.path}  ${x.message}');
  //     } else {
  //       PLog.red('Failed to download file');
  //       return null;
  //     }
  //     return null;
  //   } catch (e) {
  //     PLog.red('Catch download file : $e');

  //     return null;
  //   }
  // }

  // Future launchFileUrl({
  //   required String path,
  // }) async {
  //   try {
  //     PLog.cyan(path);
  //     Uri uri = Uri.parse(
  //         "https://d2ngqq37m3gzem.cloudfront.net/reimbursement/BFSioH1vrfERVvfqcIGYkchJFZ28o9VxcTRTuRiE.pdf");
  //     if (await canLaunchUrl(uri)) {

  //   } catch (e) {
  //     PLog.red("{----------------e}");
  //   }
  // }

  // Future<String?> updateFCM(String fcm) async {
  //   String? res = await post(path: ApiEndPoint.updateFcm, body: {"token": fcm});

  //   PLog.red("$res");
  //   return res;
  // }
}
