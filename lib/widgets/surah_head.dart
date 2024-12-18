import 'package:alquran_alkareem/utiles/my_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran_alkareem/controller/controller.dart';
import 'package:alquran_alkareem/data/api/quran_api.dart';
import 'package:alquran_alkareem/widgets/ayah.dart';

import '../models/aya_model.dart';
import '../utiles/values.dart';

class SurahHead extends StatelessWidget {
  const SurahHead({super.key, required this.ayahIndex});

  final int ayahIndex;

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return GetBuilder<Controller>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: context.isPortrait
                ? context.screenHeight / 10
                : context.screenWidth / 10,
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: BoxDecoration(
                color: controller.isDarkMode == true
                    ? secondryBG
                    : Colors.amber[50]),
            alignment: Alignment.center,
            child: Text(
                ayahsApi[ayahIndex]["numberInSurah"] == 1
                    ? ayahsApi[ayahIndex]["name"]
                    : "",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkMode == true ? bG : Colors.black)),
          ),
          ayahsApi[ayahIndex]["numberInSurah"] == 1 &&
                  ayahsApi[ayahIndex]["name"] != "سورة الفاتحة  " &&
                  ayahsApi[ayahIndex]["name"] != "سورة التوبة  "
              ? Text(
                  "\u0628\u0650\u0633\u0652\u0645\u0650 \u0671\u0644\u0644\u0651\u064e\u0647\u0650 \u0671\u0644\u0631\u0651\u064e\u062d\u0652\u0645\u064e\u0670\u0646\u0650 \u0671\u0644\u0631\u0651\u064e\u062d\u0650\u064a\u0645\u0650",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: controller.isDarkMode == true ? bG : Colors.black),
                  textAlign: TextAlign.center,
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: context.screenHeight / 34,
          ),
          Ayah(
              ayahIndex: ayahIndex,
              ayahModel: AyaModel(
                  surahName: ayahsApi[ayahIndex]["name"],
                  ayahText: ayahsApi[ayahIndex]["text"],
                  ayaNumber: ayahsApi[ayahIndex]["numberInSurah"].toString(),
                  page: ayahsApi[ayahIndex]["page"].toString(),
                  juz: ayahsApi[ayahIndex]["juz"].toString()))
        ],
      );
    });
  }
}
