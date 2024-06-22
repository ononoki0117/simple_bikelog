import 'package:flutter/material.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/screens/add_new_car_screen.dart';

class DrawerMenuItemAdd extends StatelessWidget {
  const DrawerMenuItemAdd({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 3 * 2;

    return GestureDetector(
      onTap: () {
        debugPrint("Move to Add Screen");

        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).closeDrawer();
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AddNewCarScreen(title: '차량 추가');
        }));

        // todo : 페이지 이동 구현
      },
      child: Container(
        width: width,
        height: 80,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, -0.03),
            end: Alignment(-1, 0.03),
            colors: [Color(0xFFF6F6F6), Color(0xFFFAFAFA)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: BikeLogColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: width,
                height: 80,
                decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.4300000071525574),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 13,
              top: 24,
              child: Text(
                '추가',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Positioned(
                right: 13,
                top: 26,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ))
          ],
        ),
      ),
    );
  }
}
