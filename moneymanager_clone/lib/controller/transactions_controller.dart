import 'package:get/get.dart';
import 'package:moneymanager_clone/models/get_records_model.dart';
import 'package:moneymanager_clone/models/record.dart';
import 'package:moneymanager_clone/services/apis/transactions_api.dart';

class TransactionsController extends GetxController {
  TransactionsApi _transactionsApi = TransactionsApi();
  GetTransactionModel? getTransactionModel;
  bool isLoading = false;
  getTransactions() async {
    isLoading = true;
    update();
    getTransactionModel = await _transactionsApi.getRecordsApi();
    isLoading = false;
    update();
  }

  Future<bool> createNewTransaction(TransactionModel transaction) async {
    final x = await _transactionsApi.createRecordsApi(transaction.toMap());
    return x != null;
  }
}
