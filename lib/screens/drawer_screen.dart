import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/components/drawer_menu_item.dart';
import 'package:simple_bikelog/components/drawer_menu_item_add.dart';
import 'package:simple_bikelog/model/car_info_model.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  List<Widget> getMenuItems() {
    var carInfoList = Hive.box<CarInfo>('carInfo');
    Iterable<CarInfo> _searchedCarInfo = [];

    List<Widget> items = List.empty(growable: true);

    _searchedCarInfo = carInfoList.values;

    for (CarInfo info in _searchedCarInfo) {
      items.add(DrawerMenuItem(info: info));
      items.add(const SizedBox(
        height: 19,
      ));
    }

    items.add(const DrawerMenuItemAdd());

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getMenuItems(),
        ),
      ),
    );
  }
}
