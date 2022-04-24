import 'package:flash_cards/main_page.dart';
import 'package:flash_cards/style/text_style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Intro());
}

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffABC4FF),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome too",
                  style: AppStyles.h3.copyWith(fontSize: 54),
                ),
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'English',
                        style: AppStyles.h2.copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        'Qoutues',
                        style: AppStyles.h4.copyWith(height: 0.8),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: RawMaterialButton(
                      shape: const CircleBorder(),
                      fillColor: const Color.fromARGB(255, 133, 162, 212),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                            (route) => false);
                      },
                      //ignore: prefer_const_constructors
                      child: Icon(Icons.keyboard_arrow_right,
                          size: 120, color: Colors.black38),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
