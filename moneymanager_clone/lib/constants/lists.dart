import 'package:moneymanager_clone/constants/app_strings.dart';
import 'package:moneymanager_clone/constants/color_consts.dart';
import 'package:moneymanager_clone/constants/icons.dart';

class MyList {
  static List<List> expenceCategories = [
    [MyColor.othersColor, MyIcons.othersIcon, othersexpences],
    [MyColor.billColor, MyIcons.billIcon, bills],
    [MyColor.foodColor, MyIcons.foodIcon, food],
    [MyColor.entertainColor, MyIcons.entertainmentIcon, entertainment],
    [MyColor.investmentColor, MyIcons.investmentIcon, investment],
    [MyColor.transportColor, MyIcons.transportIcon, transport],
    [MyColor.shoppingColor, MyIcons.shoppingIcon, shopping],
    [MyColor.medicalColor, MyIcons.medicalIcon, medical],
    [MyColor.educationColor, MyIcons.educationIcon, education],
    [MyColor.giftColor, MyIcons.giftIcon, gifts],
    [MyColor.insuranceColor, MyIcons.insuranceIcon, insurance],
    [MyColor.taxesColor, MyIcons.taxesIcon, taxes],
  ];
  static List<List> incomeCategories = [
    [MyColor.othersColor, MyIcons.othersIcon, othersincomes],
    [MyColor.investmentColor, MyIcons.salaryIcon, salary],
    [MyColor.taxesColor, MyIcons.salesIcon, sales],
    [MyColor.educationColor, MyIcons.awardsIcon, awards],
  ];
}
