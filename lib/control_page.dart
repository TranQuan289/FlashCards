import 'package:flash_cards/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF2FB),
      appBar: AppBar(
        // ignore: prefer_const_constructors
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xffD7E3FC),
        ),
        backgroundColor: const Color(0xffEDF2FB),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 40,
            color: Colors.black,
          ),
        ),
        title: Text('Your control',
            style: AppStyles.h3.copyWith(color: Colors.black, fontSize: 36)),
      ),
      body: Container(),
    );
  }
}
