import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:english_words/english_words.dart';
import 'package:flash_cards/model/english_today.dart';
import 'package:flash_cards/style/text_style.dart';
import 'package:flash_cards/widgets/app_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() {
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: 5, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    words = newList
        .map((e) => EnglishToday(
              noun: e,
            ))
        .toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.91);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffEDF2FB),
      appBar: AppBar(
        backgroundColor: const Color(0xffEDF2FB),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.menu_rounded,
            size: 40,
            color: Colors.black,
          ),
        ),
        title: Text('English today',
            style: AppStyles.h3.copyWith(color: Colors.black, fontSize: 36)),
      ),
      // ignore: avoid_unnecessary_containers
      body: SizedBox(
        width: double.infinity,
        //margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
                height: size.height * 1 / 10,
                // padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                child: Text(
                  '"rat vui khi duoc gap ban ne e e e e e e e  ee e e e e e"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 16, color: Colors.black87),
                )),
            SizedBox(
              height: size.height * 2 / 3,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    // ignore: unused_local_variable, non_constant_identifier_names
                    String? Letter = words[index].noun ?? '';
                    String fistLetter = Letter.substring(0, 1);

                    String leftLetter = Letter.substring(1, Letter.length);
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      decoration: const BoxDecoration(
                          color: Color(0xffABC4FF),
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(2, 3),
                                blurRadius: 3)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 1),
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.heart_broken,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: fistLetter,
                                    style: AppStyles.h1.copyWith(
                                        fontSize: 89,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          const BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 6,
                                              offset: Offset(3, 6))
                                        ]),
                                    children: [
                                      TextSpan(
                                          text: leftLetter,
                                          style: AppStyles.h2.copyWith(
                                              shadows: [
                                                const BoxShadow(
                                                    blurRadius: 0,
                                                    offset: Offset(0, 0))
                                              ]))
                                    ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(
                              '"tự xài gg dịch mà dịch nha :>"',
                              style: AppStyles.h4.copyWith(
                                  letterSpacing: 1, color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: size.height * 1 / 11,
              // ignore: avoid_unnecessary_containers
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return buildIndicator(index == _currentIndex, size);
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffABC4FF),
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.published_with_changes,
          size: 40,
          color: const Color(0xffEDF2FB),
        ),
      ),

      drawer: Drawer(
        child: Container(
          color: const Color(0xffD7E3FC),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 24)),
              Text('Your Mind',
                  style: AppStyles.h3.copyWith(color: Colors.black)),
              AppButton(label: 'Favorites', onTap: () {}),
              AppButton(label: 'Your Control', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive
              ? const Color(0xffABC4FF)
              : const Color.fromARGB(255, 145, 152, 154),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
