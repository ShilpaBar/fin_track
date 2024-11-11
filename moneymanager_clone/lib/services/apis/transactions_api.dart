import 'dart:convert';

import 'package:moneymanager_clone/constants/api_endpoint.dart';
import 'package:moneymanager_clone/models/get_records_model.dart';
import 'package:moneymanager_clone/services/interceptor.dart';
import 'package:pretty_logger/pretty_logger.dart';

import '../../utils/snackbar/snack_message.dart';

class TransactionsApi {
  HttpConfig _httpConfig = HttpConfig();
  Future<GetTransactionModel?> getRecordsApi() async {
    try {
      String? res = await _httpConfig.get(path: ApiEndPoint.fetchRecord);
      return res == null ? null : GetTransactionModel.fromRawJson(res);
    } catch (e) {
      PLog.red("Catch on Get Records Api : ${e}");
      return null;
    }
  }

  Future<String?> createRecordsApi(Map<String?, dynamic> body) async {
    try {
      String? responce =
          await _httpConfig.post(path: ApiEndPoint.addNewRecord, body: body);
      if (responce != null) {
        final obj = jsonDecode(responce);
        SnackMessage.succesMessgae(msg: obj['message']);
      }
      return responce;
    } catch (e) {
      PLog.red("Catch on Create New Record Api : ${e}");
      return null;
    }
  }
}
