import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:english_words/english_words.dart';
import 'package:flash_cards/control_page.dart';
import 'package:flash_cards/model/english_today.dart';
import 'package:flash_cards/style/text_style.dart';
import 'package:flash_cards/values/share_keys.dart';
import 'package:flash_cards/widgets/all_words_page.dart';
import 'package:flash_cards/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleTranslator translator = GoogleTranslator();
  int _currentIndex = 0;
  int len = 0;
  String ts = '';
  // ignore: prefer_collection_literals
  Map map = Map<int, String>();
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

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];

    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList
          .map((e) => EnglishToday(
                noun: e,
              ))
          .toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.91);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                margin: const EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.center,
                child: Text(
                  '"Five English words every day"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 20, color: Colors.black87),
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
                    // ignore: avoid_print
                    translator
                        .translate(Letter.toString(), from: 'en', to: 'vi')
                        .then((s) {
                      // ignore: unused_local_variable
                      ts = s.toString();
                    });
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
                          // ignore: avoid_unnecessary_containers
                          Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              alignment: Alignment.centerRight,
                              child: Image.asset('assets/image/heart.png',
                                  height: 45, width: 45, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: fistLetter,
                                    style: AppStyles.h1.copyWith(
                                        fontSize: 70,
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
                                              fontSize: 50,
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
                              ts,
                              style: AppStyles.h4.copyWith(
                                  letterSpacing: 1, color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : SizedBox(
                    height: size.height * 1 / 11,
                    width: double.infinity,
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      color: const Color(0xffEDF2FB),
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ListView.builder(
                          //physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          addAutomaticKeepAlives: true,
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
        child: Image.asset('assets/image/reload.png',
            height: 40, width: 40, color: const Color(0xffEDF2FB)),
      ),

      drawer: Drawer(
        child: Container(
          color: const Color(0xffD7E3FC),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 24)),
              Text('Your Mind',
                  style: AppStyles.h3.copyWith(color: Colors.black)),
              AppButton(
                  label: 'Favorites',
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const ControlPage()));
                  }),
              AppButton(
                  label: 'Your Control',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ControlPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
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

Widget buildShowMore() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    alignment: Alignment.centerLeft,
    child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: const Color(0xffABC4FF),
        child: InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => AllWords(words: this.words)));
          },
          splashColor: Colors.blueAccent,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyles.h5,
            ),
          ),
        )),
  );
}
