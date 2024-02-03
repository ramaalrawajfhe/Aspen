
import 'package:aspen/bottom_nav_bar/bttom_nav_bar_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/Aspenaspen_logo_text_img (1).png",
          fit: BoxFit.fitWidth,
          height: 100.h,
          width: 100.w,
          ),
          Positioned(
          top: 100,//93
          left: 57,
          right: 57,
          child: Image.asset(
            "assets/images/Plan your Luxurious Vacation.png",
            fit: BoxFit.fill,
            width:50.w ,
          ),
          ),
          Positioned(bottom: 140,
              child: Container(
                margin: const EdgeInsets.only(left: 32),
                constraints: const BoxConstraints(
                  maxWidth: 200,
                ),
          child: RichText(
            text:  TextSpan(
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                height: 1.13,
                color: Colors.white,
              ),

             children: [
               TextSpan(
                 text: 'plan your',
                 style: TextStyle(
                   fontSize: 17.sp,
                   fontWeight: FontWeight.w400,
                   height: 1.13,
                   color: Colors.white,
                 ),
               ),
                TextSpan(
                 text: 'Luxurious Vacation',
                 style: TextStyle(
                   fontSize: 28.sp,
                   fontWeight: FontWeight.w500,
                   height: 1.13,
                   color: Colors.white,
               ),
               ),
             ],
            ),
          ),
              ),
          ),

          Positioned(
            top: 90.h,
            left: 32,
            right: 32,
            child: CustButton(
            buttonText: 'Explore',
            onTop: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBarScreen())
              );
            },
            ))

        ],
      ),
    );
  }
}
class CustButton extends StatelessWidget {
  final String buttonText;
  final Function onTop;

  const CustButton({required this.buttonText, required this.onTop});

  @override
    Widget build(BuildContext context) {
      return ElevatedButton(
        onPressed: () => onTop(),
        child: Text(buttonText),
      );
    }
}


