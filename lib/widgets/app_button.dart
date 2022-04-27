import 'package:flash_cards/style/text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 45, right: 20, left: 20),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
            ]),
        child: Text(
          label,
          style: AppStyles.h4.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
