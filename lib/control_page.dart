import 'package:flash_cards/style/text_style.dart';
import 'package:flash_cards/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  // ignore: prefer_final_fields, unused_field
  double _currentSliderValue = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      _currentSliderValue = value.toDouble();
    });
  }

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
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, _currentSliderValue.toInt());
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
      // ignore: avoid_unnecessary_containers
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'How much a number word at once',
              style: AppStyles.h4.copyWith(fontSize: 18, color: Colors.black),
            ),
            const Spacer(),
            Text(
              '${_currentSliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                  color: const Color(0xffABC4FF),
                  fontSize: 138,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Slider(
                value: _currentSliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                onChanged: (value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.centerLeft,
              child: Text(
                'slide to set',
                style: AppStyles.h5.copyWith(color: Colors.black),
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
