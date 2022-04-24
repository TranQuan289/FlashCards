import 'package:flash_cards/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xffEDF2FB),
        appBar: AppBar(
          backgroundColor: const Color(0xffEDF2FB),
          elevation: 0,
          leading: InkWell(
            onTap: () {},
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
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                  height: size.height * 1 / 10,
                  padding: const EdgeInsets.all(16),
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 6),
                        decoration: const BoxDecoration(
                            color: Color(0xffABC4FF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15, top: 15),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.heart_broken,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: 'B',
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
                                            text: 'eautiful',
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
                                '"nit dang lam gi ma k co tra loi tin nhan tran cun"',
                                style: AppStyles.h4.copyWith(letterSpacing: 1),
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
          onPressed: () {},
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.published_with_changes,
            size: 40,
            color: const Color(0xffEDF2FB),
          ),
        ));
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
