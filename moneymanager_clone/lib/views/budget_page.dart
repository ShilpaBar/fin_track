// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

// final indexListner = StateProvider<int>((ref) => 0);

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController limitInputController = TextEditingController();

  int spent = 0;
  int spent1 = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
  }

  // Future setLimit(i) async {
  //   final values = SetLimitModel(
  //     category: MyList.expenceCategories[i][2],
  //     limit: limitInputController.text,
  //   );
  //   Boxes.getLimit().add(values);
  //   values.save();
  //   limitInputController.clear();
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ALL",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   controller: scrollController,
      //   child: ValueListenableBuilder<Box<IncomeModel>>(
      //       valueListenable: Boxes.getData().listenable(),
      //       builder: (context, box, _) {
      //         final details = box.values.toList().cast<IncomeModel>();

      //         List spentList = [];
      //         return ValueListenableBuilder(
      //             valueListenable: Boxes.getLimit().listenable(),
      //             builder: (context, limit, _) {
      //               Set<String> list = {};

      //               final limits = limit.values.toList().cast<SetLimitModel>();
      //               IconData? icon;
      //               Color? color;

      //               return Column(
      //                 children: [
      //                   limit.isEmpty
      //                       ? Column(
      //                           children: [
      //                             Image(
      //                               color: Color.fromARGB(96, 158, 158, 158),
      //                               width: 70,
      //                               image: AssetImage(
      //                                 "assets/navigation_menu/sparkle.png",
      //                               ),
      //                             ),
      //                             Padding(
      //                               padding: const EdgeInsets.symmetric(
      //                                   vertical: 8.0),
      //                               child: Text(
      //                                 "Budget not set for this month",
      //                                 style: TextStyle(
      //                                     color: Colors.black26, fontSize: 15),
      //                               ),
      //                             ),
      //                           ],
      //                         )
      //                       : StickyHeader(
      //                           header: Container(
      //                             width: MediaQuery.of(context).size.width,
      //                             color: Colors.white,
      //                             child: Padding(
      //                               padding: EdgeInsets.only(left: 10),
      //                               child: Text(
      //                                 'Budgeted Categories',
      //                                 style: TextStyle(
      //                                     color: Colors.black, fontSize: 15),
      //                               ),
      //                             ),
      //                           ),
      //                           content: SizedBox(
      //                             height: limits.length * 72,
      //                             child: ListView.builder(
      //                               physics: NeverScrollableScrollPhysics(),
      //                               itemCount: limit.length,
      //                               itemBuilder: (context, index1) {
      //                                 spent1 = 0;
      //                                 for (var i in details) {
      //                                   if (i.category ==
      //                                       limits[index1].category) {
      //                                     spent1 += int.parse(i.amount);
      //                                   }
      //                                 }
      //                                 for (var i in MyList.expenceCategories) {
      //                                   if (i[2] == limits[index1].category) {
      //                                     icon = i[1];
      //                                     color = i[0];
      //                                   }
      //                                 }
      //                                 list.add(limits[index1].category);

      //                                 return ListTile(
      //                                   leading: Container(
      //                                     height: 35,
      //                                     width: 35,
      //                                     decoration: BoxDecoration(
      //                                       borderRadius:
      //                                           BorderRadius.circular(5),
      //                                       color: color,
      //                                     ),
      //                                     child: Icon(
      //                                       icon,
      //                                       color: Colors.black,
      //                                     ),
      //                                   ),
      //                                   title: Row(
      //                                     children: [
      //                                       Text(
      //                                         limits[index1].category,
      //                                         style: TextStyle(
      //                                           color: int.parse(limits[index1]
      //                                                       .limit) >
      //                                                   spent1
      //                                               ? Colors.lightGreen
      //                                               : Colors.redAccent,
      //                                         ),
      //                                       ),
      //                                       Spacer(),
      //                                       Text(
      //                                         int.parse(limits[index1].limit) >
      //                                                 spent1
      //                                             ? "Remaining:${int.parse(limits[index1].limit) - spent1}"
      //                                             : "Exceded:${spent1 - int.parse(limits[index1].limit)}",
      //                                         style: TextStyle(
      //                                           color: int.parse(limits[index1]
      //                                                       .limit) >
      //                                                   spent1
      //                                               ? Colors.lightGreen
      //                                               : Colors.redAccent,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   subtitle: Row(
      //                                     children: [
      //                                       Text(
      //                                           "Limit:${limits[index1].limit}"),
      //                                       Spacer(),
      //                                       Text("Spent:${spent1.toString()}")
      //                                     ],
      //                                   ),
      //                                   trailing: IconButton(
      //                                     icon: Icon(Icons.delete),
      //                                     onPressed: () {
      //                                       limits[index1].delete();
      //                                     },
      //                                   ),
      //                                 );
      //                               },
      //                             ),
      //                           ),
      //                         ),
      //                   StickyHeader(
      //                     header: Container(
      //                       width: MediaQuery.of(context).size.width,
      //                       color: Colors.white,
      //                       child: Padding(
      //                         padding: EdgeInsets.only(left: 10),
      //                         child: Text(
      //                           'Not Budgeted Categories',
      //                           style: TextStyle(
      //                               color: Colors.black, fontSize: 15),
      //                         ),
      //                       ),
      //                     ),
      //                     content: ListView.builder(
      //                       physics: NeverScrollableScrollPhysics(),
      //                       shrinkWrap: true,
      //                       itemCount: MyList.expenceCategories.length,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         spent = 0;
      //                         for (var i in details) {
      //                           if (i.category ==
      //                               MyList.expenceCategories[index][2]) {
      //                             spent += int.parse(i.amount);
      //                           }
      //                         }

      //                         if (list.contains(
      //                             MyList.expenceCategories[index][2])) {
      //                           spentList.add(spent);
      //                         }

      //                         return list.contains(
      //                                 MyList.expenceCategories[index][2])
      //                             ? SizedBox()
      //                             : ListTile(
      //                                 dense: true,
      //                                 leading: Container(
      //                                   height: 35,
      //                                   width: 35,
      //                                   decoration: BoxDecoration(
      //                                     borderRadius:
      //                                         BorderRadius.circular(5),
      //                                     color: MyList.expenceCategories[index]
      //                                         [0],
      //                                   ),
      //                                   child: Icon(
      //                                     MyList.expenceCategories[index][1],
      //                                     color: Colors.black,
      //                                   ),
      //                                 ),
      //                                 tileColor: Colors.white,
      //                                 title: Text(
      //                                     MyList.expenceCategories[index][2],
      //                                     textScaleFactor: .9),
      //                                 subtitle: Text("Spent:$spent"),
      //                                 trailing: ElevatedButton(
      //                                   style: ElevatedButton.styleFrom(
      //                                     padding: EdgeInsets.all(0),
      //                                     fixedSize: Size(90, 20),
      //                                     side:
      //                                         BorderSide(color: Colors.black26),
      //                                     backgroundColor: Colors.transparent,
      //                                     elevation: 0,
      //                                   ),
      //                                   child: Text(
      //                                     "SET LIMIT ",
      //                                     style: TextStyle(
      //                                         fontSize: 14,
      //                                         color: Colors.black,
      //                                         fontWeight: FontWeight.bold,
      //                                         letterSpacing: .5),
      //                                   ),
      //                                   onPressed: () {
      //                                     showModalBottomSheet(
      //                                       isScrollControlled: true,
      //                                       backgroundColor: Colors.transparent,
      //                                       context: context,
      //                                       builder: (context) {
      //                                         return AlertDialog(
      //                                           title: Text(
      //                                             setbudget,
      //                                             style: commonBlackBoldText25,
      //                                           ),
      //                                           content: Column(
      //                                             mainAxisSize:
      //                                                 MainAxisSize.min,
      //                                             children: [
      //                                               ListTile(
      //                                                 contentPadding:
      //                                                     EdgeInsets.zero,
      //                                                 leading: Container(
      //                                                   height: 35,
      //                                                   width: 35,
      //                                                   decoration:
      //                                                       BoxDecoration(
      //                                                     borderRadius:
      //                                                         BorderRadius
      //                                                             .circular(5),
      //                                                     color: MyList
      //                                                             .expenceCategories[
      //                                                         index][0],
      //                                                   ),
      //                                                   child: Icon(
      //                                                     MyList.expenceCategories[
      //                                                         index][1],
      //                                                     color: Colors.black,
      //                                                   ),
      //                                                 ),
      //                                                 tileColor: Colors.white,
      //                                                 title: Text(
      //                                                     MyList.expenceCategories[
      //                                                         index][2],
      //                                                     textScaleFactor: .9),
      //                                               ),
      //                                               TextFormField(
      //                                                 keyboardType:
      //                                                     TextInputType.number,
      //                                                 controller:
      //                                                     limitInputController,
      //                                                 decoration: InputDecoration(
      //                                                     border:
      //                                                         OutlineInputBorder()),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                           actions: [
      //                                             TextButton(
      //                                                 onPressed: () {
      //                                                   limitInputController
      //                                                       .clear();
      //                                                   Navigator.pop(context);
      //                                                 },
      //                                                 child: Text(cancelCap,
      //                                                     style:
      //                                                         commonBlueTextButtontext18w500)),
      //                                             TextButton(
      //                                                 onPressed: () {
      //                                                   setLimit(index);
      //                                                   Future.delayed(
      //                                                       Duration(
      //                                                           seconds: 1),
      //                                                       () {
      //                                                     setState(() {});
      //                                                   });
      //                                                 },
      //                                                 child: Text(saveCap,
      //                                                     style:
      //                                                         commonBlueTextButtontext18w500)),
      //                                           ],
      //                                         );
      //                                       },
      //                                     );
      //                                   },
      //                                 ),
      //                               );
      //                       },
      //                     ),
      //                   )
      //                 ],
      //               );
      //             });
      //       }),
      // ),
    );
  }
}
