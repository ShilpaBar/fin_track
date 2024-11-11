// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moneymanager_clone/constants/app_strings.dart';
import 'package:moneymanager_clone/controller/auth_controller.dart';
import 'package:moneymanager_clone/controller/transactions_controller.dart';
import 'package:moneymanager_clone/main.dart';
import 'package:moneymanager_clone/models/record.dart';
import 'package:moneymanager_clone/services/shared_preferences/user_creds.dart';
import 'package:moneymanager_clone/theme/text_styles.dart';
import 'package:moneymanager_clone/views/add_page.dart';
import 'package:moneymanager_clone/views/login_page.dart';

import '../models/get_records_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TransactionsController transactionsController =
      Get.find<TransactionsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await transactionsController.getTransactions();
      // Boxes.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<TransactionsController>(builder: (_) {
      List<Record> value =
          transactionsController.getTransactionModel?.data?.records ?? [];

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(15.0),
              child: transactionsController.isLoading
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue, size: 40),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "ALL TIME",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              UserCredintailStore().deleteJwt();
                              navigationKey.currentState!.pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                  (f) => false);
                            },
                            label: Text("Log Out"))
                      ],
                    ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: transactionsController.isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue, size: 60)
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  // height: 65,
                                  // width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            income,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                              "${value.map((e) => e.type == "Income" ? e.amount : 0).toList().reduce((x, y) => (x + y))}"),
                                        ],
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          size: 15,
                                        ),
                                        backgroundColor: Colors.green[100],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Gap(10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  // height: 65,
                                  // width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expense,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                              "${value.map((e) => e.type == "Expense" ? e.amount : 0).toList().reduce((x, y) => (x + y))}"),
                                        ],
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 15,
                                          color: Colors.orangeAccent,
                                        ),
                                        backgroundColor: Colors.orange[50],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          value.isEmpty
                              ? Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/navigation_menu/undraw_receipt_re_fre3.svg",
                                      height: 400,
                                    ),
                                    Text(
                                      "No Transaction",
                                      style: TextStyle(
                                          fontSize: 23, letterSpacing: .5),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Tap + to add new expense/inCome",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          letterSpacing: .5),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  height: size.height * .55,
                                  child: ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              value[index].category ?? "",
                                              style: commonBlackText20,
                                            ),
                                            Spacer(),
                                            Text(
                                              value[index].type == income
                                                  ? "+${value[index].amount}"
                                                  : "-${value[index].amount}",
                                              style: value[index].type == income
                                                  ? incomeGreenText20
                                                  : expenceRedText20,
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              // value[index].delete();
                                            },
                                            icon: Icon(Icons.delete)),
                                      );
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
