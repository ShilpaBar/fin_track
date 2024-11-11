// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager_clone/constants/app_strings.dart';
import 'package:moneymanager_clone/constants/color_consts.dart';
import 'package:moneymanager_clone/constants/lists.dart';
import 'package:moneymanager_clone/controller/transactions_controller.dart';
import 'package:moneymanager_clone/main.dart';
import 'package:moneymanager_clone/models/record.dart';
import 'package:moneymanager_clone/theme/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:moneymanager_clone/views/home_page.dart';
import 'package:pretty_logger/pretty_logger.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  ScrollController scrollController = ScrollController();
  bool isScroll = false;
  int? _value = 0;
  String category = "Select A Category";
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> k1 = GlobalKey<FormState>();
  CalcController calcController = CalcController();
  int sum = 0;

  @override
  void initState() {
    super.initState();

    calcController.addListener.call;

    scrollController.addListener(() {});
  }

  bool onChanged1 = false;

  DateTime? _selectedDate;
  DateTime? _selectedTime;
/*


 */
  // Future<void> insertRecord() async {
  //   if (amountController.text != "" ||
  //       titleController.text != "" ||
  //       noteController.text != "") {
  //     try {
  //       String uri = "http://10.0.2.2/moneyManager_api/insert_record.php";
  //       var res = await http.post(Uri.parse(uri),
  //           body: TransactionModel(
  //             amount: amountController.text,
  //             title: titleController.text,
  //             note: noteController.text,
  //             category: onChanged1
  //                 ? MyList.expenceCategories[_value!][2]
  //                 : MyList.incomeCategories[_value!][2],
  //             type: onChanged1 ? expense : income,
  //             date: DateFormat.yMMMEd()
  //                 .format(_selectedDate ?? DateTime.now())
  //                 .toString(),
  //             time: _selectedTime == null
  //                 ? DateFormat('hh:mm a').format(DateTime.now())
  //                 : DateFormat('hh:mm a').format(_selectedTime!).toString(),
  //           ).toMap());
  //       PLog.red(res.body);
  //       var response = jsonDecode(res.body);
  //       if (response["success"] == "true") {
  //         print("Rocord inserted");
  //       } else {
  //         print("some issue");
  //       }
  //     } catch (e) {
  //       PLog.red(e.toString());
  //     }
  //   } else {
  //     print("please fill all fields");
  //   }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, pickedTime.hour, pickedTime.minute);
      });
    }
  }

  bool isToggled = false;
  TransactionsController transactionsController =
      Get.find<TransactionsController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<TransactionsController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 35, right: 10),
            height: 111,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black45,
                    size: 19,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black26,
                  child: Icon(
                    Icons.wallet,
                    color: Colors.black45,
                    size: 19,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Main Account",
                      style: commonBlackText20.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Account",
                      style:
                          commonBlack26Text18.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
          titleSpacing: 0,
        ),
        bottomSheet: Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.star_border),
              Row(children: [
                Text(
                  "Add Batch",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isToggled,
                  onChanged: (value) {
                    setState(() {
                      isToggled = !isToggled;
                    });
                  },
                ),
              ]),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.enabletextfieldcolor,
                    fixedSize: Size(120, 45),
                  ),
                  onPressed: () async {
                    // if (k1.currentState!.validate()) {
                    //   addNew();
                    // }
                    bool suc = await transactionsController
                        .createNewTransaction(TransactionModel(
                      amount: amountController.text,
                      title: titleController.text,
                      note: noteController.text,
                      category: onChanged1
                          ? MyList.expenceCategories[_value!][2]
                          : MyList.incomeCategories[_value!][2],
                      type: onChanged1 ? expense : income,
                      date: DateFormat.yMMMEd()
                          .format(_selectedDate ?? DateTime.now())
                          .toString(),
                      time: _selectedTime == null
                          ? DateFormat('hh:mm a').format(DateTime.now())
                          : DateFormat('hh:mm a')
                              .format(_selectedTime!)
                              .toString(),
                    ));

                    suc
                        ? {
                            navigationKey.currentState!.pop(),
                            transactionsController.getTransactions()
                          }
                        : null;
                  },
                  icon: Icon(
                    Icons.done,
                    size: 15,
                  ),
                  label: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: k1,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onChanged1 = false;
                                  _value = 0;
                                  category = "Select A Category";
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      income,
                                      style: commonBlackText18.copyWith(
                                          color: onChanged1
                                              ? Colors.black26
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.green[100],
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onChanged1 = true;
                                  _value = 0;
                                  category = "Select A Category";

                                  // debugPrint(DateTime.sunday.toString());
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      expense,
                                      style: commonBlackText18.copyWith(
                                          color: !onChanged1
                                              ? Colors.black26
                                              : Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.orange[50],
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                        color: Colors.orangeAccent,
                                      ),
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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .5, color: Colors.black38),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat.yMMMEd().format(
                                          _selectedDate ?? DateTime.now()),
                                      style: commonBlackText18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .5, color: Colors.black38),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _selectedTime == null
                                            ? DateFormat('hh:mm a')
                                                .format(DateTime.now())
                                            : DateFormat('hh:mm a')
                                                .format(_selectedTime!),
                                        style: commonBlackText18,
                                      ),
                                    ]),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = null;
                                    _selectedTime = null;
                                  });
                                },
                                icon: Icon(Icons.refresh))
                          ],
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: amountController,
                          style: TextStyle(fontSize: 50),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            return v!.isEmpty ? "Please Enter An Amount" : null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calculate_rounded,
                                size: 30,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    elevation: 0,
                                    scrollControlDisabledMaxHeightRatio: .7,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      double currentvalue = 0;
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: SizedBox(
                                          height: 500,
                                          width: 300,
                                          child: SimpleCalculator(
                                            controller: calcController,
                                            value: currentvalue,
                                            hideExpression: false,
                                            hideSurroundingBorder: false,
                                            autofocus: true,
                                            onChanged:
                                                (key, value, expression) {
                                              setState(() {
                                                currentvalue = value ?? 0;
                                                setState(() {
                                                  amountController.text =
                                                      calcController.value!
                                                          .toInt()
                                                          .toString();
                                                });
                                              });
                                            },
                                            theme: const CalculatorThemeData(
                                              borderColor: Colors.white,
                                              borderWidth: 1,
                                              displayColor: Colors.white,
                                              displayStyle: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blueAccent),
                                              expressionColor: Color.fromARGB(
                                                  255, 137, 150, 226),
                                              expressionStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              operatorColor: Color.fromARGB(
                                                  255, 253, 114, 161),
                                              operatorStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              commandColor: Color.fromARGB(
                                                  255, 250, 195, 113),
                                              commandStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              numColor: Colors.grey,
                                              numStyle: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          FloatingActionButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.done))
                                        ],
                                      );
                                    });
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColor.enabletextfieldcolor,
                                  width: 2,
                                  style: BorderStyle.solid),
                            ),
                            hintText: "Enter Amount",
                            hintStyle: TextStyle(
                                fontSize: 43,
                                color: Colors.black12,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyColor.enabletextfieldcolor,
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                              labelText: "Title",
                              // labelStyle: TextStyle(
                              //   color: MyColor.enabletextfieldcolor,
                              // ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          width: size.width - 20,
                          // height: 300,
                          decoration: BoxDecoration(
                              border: Border.all(width: .5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Category:",
                                    style: commonBlack38Text20,
                                  ),
                                  Text(
                                    category,
                                    style: commonBlackText20,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      debugPrint(
                                          MyList.expenceCategories.toString());
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.edit_note),
                                  )
                                ],
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                clipBehavior: Clip.antiAlias,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: onChanged1
                                    ? List.generate(
                                        MyList.expenceCategories.length,
                                        (index) {
                                        return ChoiceChip(
                                          label: Container(
                                            decoration: BoxDecoration(
                                                border: _value != index
                                                    ? Border.all(width: .5)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      MyList.expenceCategories[
                                                          index][0],
                                                  child: Icon(
                                                    MyList.expenceCategories[
                                                        index][1],
                                                    color: Colors.black,
                                                    size: 19,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0),
                                                  child: Text(
                                                    MyList.expenceCategories[
                                                        index][2],
                                                    style: commonBlackText20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          selected: _value == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                _value = index;
                                              }

                                              category = MyList
                                                  .expenceCategories[index][2];
                                            });
                                          },
                                          disabledColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          labelPadding: EdgeInsets.zero,
                                          selectedColor: MyList
                                              .expenceCategories[index][0],
                                        );
                                      })
                                    : List.generate(
                                        MyList.incomeCategories.length,
                                        (index) {
                                        return ChoiceChip(
                                          label: Container(
                                            decoration: BoxDecoration(
                                                border: _value != index
                                                    ? Border.all(width: .5)
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      MyList.incomeCategories[
                                                          index][0],
                                                  child: Icon(
                                                    MyList.incomeCategories[
                                                        index][1],
                                                    color: Colors.black,
                                                    size: 19,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0),
                                                  child: Text(
                                                    MyList.incomeCategories[
                                                        index][2],
                                                    style: commonBlackText20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          selected: _value == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                _value = index;
                                              }
                                              category = MyList
                                                  .incomeCategories[index][2];
                                            });
                                          },
                                          disabledColor: Colors.transparent,
                                          // pressElevation: .5,
                                          backgroundColor: Colors.transparent,
                                          padding: EdgeInsets.zero,
                                          labelPadding: EdgeInsets.zero,
                                          selectedColor:
                                              MyList.incomeCategories[index][0],
                                        );
                                      }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          controller: noteController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyColor.enabletextfieldcolor,
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                              labelText: "Note",
                              // labelStyle: TextStyle(
                              //   color: MyColor.enabletextfieldcolor,
                              // ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
