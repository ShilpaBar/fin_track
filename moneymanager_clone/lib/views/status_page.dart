import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanager_clone/constants/app_strings.dart';
import 'package:moneymanager_clone/constants/lists.dart';
import 'package:moneymanager_clone/controller/auth_controller.dart';
import 'package:moneymanager_clone/controller/transactions_controller.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../models/get_records_model.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  ScrollController scrollController = ScrollController();
  bool isScroll = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // checkScroll();
    });
  }

  bool onChanged1 = false;
  // int inCome = 0, exPence = 0, e = 0, f = 0, total = 0;
  TransactionsController transactionsController =
      Get.find<TransactionsController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TransactionsController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ALL TIME",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "All",
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(Icons.arrow_drop_down_outlined)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: scrollController,
            child: GetBuilder<AuthController>(
              builder: (_) {
                int inCome = (transactionsController
                            .getTransactionModel?.data?.records ??
                        [])
                    .map((e) => e.type == "Income" ? e.amount : 0)
                    .toList()
                    .reduce((x, y) => (x + y));
                int exPense = (transactionsController
                            .getTransactionModel?.data?.records ??
                        [])
                    .map((e) => e.type == "Expense" ? e.amount : 0)
                    .toList()
                    .reduce((x, y) => (x + y));
                int total = (transactionsController
                            .getTransactionModel?.data?.records ??
                        <Record>[])
                    .map((e) => e.amount)
                    .toList()
                    .reduce((x, y) => (x + y));
                // inCome = e = f = expence = total = 0;

                // final value = box.values.toList().cast<IncomeModel>();
                // for (var i in value) {
                //   if (i.type == income) {
                //     inCome = inCome + int.parse(i.amount);
                //     f++;
                //   }
                //   if (i.type == expense) {
                //     expence = expence + int.parse(i.amount);
                //     e++;
                //   }
                // }
                // inCome == 0 && expence == 0
                //     ? total = 1
                //     : total = inCome + expence;
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.all(25),
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.green[600],
                                      size: 10,
                                    ),
                                    Text(
                                      "$income ${inCome * 100 ~/ (inCome < 1 ? 1 : total)}%",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.orange[600],
                                      size: 10,
                                    ),
                                    Text(
                                      "$expense ${exPense * 100 ~/ (exPense < 1 ? 1 : total)}%",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Divider(thickness: 1),
                                    Divider(
                                      thickness: 1,
                                      height: 40,
                                    ),
                                    Divider(
                                      thickness: .5,
                                      height: 40,
                                    ),
                                    Divider(
                                      thickness: .5,
                                      height: 40,
                                    ),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 75.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Type",
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(income),
                                        Text(expense),
                                        Text("Overall"),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          style:
                                              TextStyle(color: Colors.black38),
                                          "Amount"),
                                      Text(inCome.toString()),
                                      Text(exPense.toString()),
                                      Text((inCome - exPense).toString()),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          style:
                                              TextStyle(color: Colors.black38),
                                          "Transaction"),
                                      // Text(f.toString()),
                                      // Text(e.toString()),
                                      // Text((f + e).toString()),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onChanged1 = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 150,
                                decoration: BoxDecoration(
                                    boxShadow: onChanged1
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 15,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: onChanged1
                                        ? Colors.transparent
                                        : Colors.indigoAccent[100]),
                                child: Text(
                                  income,
                                  style: TextStyle(
                                      color: onChanged1
                                          ? Colors.black26
                                          : Colors.black),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onChanged1 = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 150,
                                decoration: BoxDecoration(
                                    boxShadow: !onChanged1
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 15,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: !onChanged1
                                        ? Colors.transparent
                                        : Colors.indigoAccent[100]),
                                child: Text(expense,
                                    style: TextStyle(
                                        color: !onChanged1
                                            ? Colors.black26
                                            : Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StickyHeader(
                            header: Container(
                              padding: EdgeInsets.only(top: 10),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1, color: Colors.black26),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(10),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                            "EXPENSE CATEGORIES BREAKEDOWN"),
                                      ),
                                      subtitle: Container(
                                        color: Colors.blueGrey[100],
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Category",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Percentage",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                            content: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: onChanged1
                                  ? MyList.expenceCategories.length
                                  : MyList.incomeCategories.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                inCome == 0 ? inCome = 1 : inCome = inCome;
                                exPense == 0 ? exPense = 1 : exPense = exPense;
                                int spent = 0;
                                // for (var i in value) {
                                //   if (i.category ==
                                //       (onChanged1
                                //           ? MyList.expenceCategories[index][2]
                                //           : MyList.incomeCategories[index][2])) {
                                //     spent += int.parse(i.amount);
                                //   }
                                // }

                                return ListTile(
                                  dense: true,
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: onChanged1
                                          ? MyList.expenceCategories[index][0]
                                          : MyList.incomeCategories[index][0],
                                    ),
                                    child: Icon(onChanged1
                                        ? MyList.expenceCategories[index][1]
                                        : MyList.incomeCategories[index][1]),
                                  ),
                                  tileColor: Colors.white,
                                  title: Text(
                                      onChanged1
                                          ? MyList.expenceCategories[index][2]
                                          : MyList.incomeCategories[index][2],
                                      textScaleFactor: .9),
                                  subtitle: Text("$spent"),
                                  trailing: Container(
                                    alignment: Alignment.center,
                                    width: 37,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5, color: Colors.black26),
                                    ),
                                    child: Text(
                                        " ${spent * 100 ~/ (onChanged1 ? exPense : inCome)}%"),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
