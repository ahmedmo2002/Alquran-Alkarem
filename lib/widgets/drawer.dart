import 'package:alquran_alkareem/models/surah_model.dart';
import 'package:alquran_alkareem/utiles/my_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../data/api/surahs.dart';
import 'surah_info.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../main.dart';
import '../utiles/values.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    Get.put(Controller());
    return GetBuilder<Controller>(builder: (controller) {
      return Drawer(
        backgroundColor: controller.isDarkMode == true
            ? const Color.fromARGB(255, 52, 58, 64)
            : bG,
        elevation: 10,
        width: context.screenWidth / 1.1,
        child: SafeArea(child: GetBuilder<Controller>(
          builder: (controller) {
            return Scaffold(
              backgroundColor: controller.isDarkMode == true
                  ? const Color.fromARGB(255, 52, 58, 64)
                  : bG,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: AppBar(
                    backgroundColor: secondryBG,
                    elevation: 10,
                    iconTheme: const IconThemeData(color: bG),
                    title: TextField(
                        onChanged: (text) {
                          controller.searchSurah(removeTashkeel(text));
                          text.isEmpty ? controller.clearSearchSurahs() : null;
                        },
                        style: const TextStyle(color: bG),
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'ابحث عن السوره...',
                          hintStyle: const TextStyle(color: bG),
                          border: InputBorder.none,
                          suffix: IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.clearSearchSurahs();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: bG,
                              )),
                          prefix: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        )),
                  ),
                ),
              ),
              body: ScrollablePositionedList.builder(
                itemScrollController: controller.scrollController2,
                itemCount: surahsApi.length,
                itemBuilder: (context, index) {
                  return removeTashkeel(surahsApi[index]['name'])
                          .contains(controller.searchSurahText)
                      ? SurahInfo(
                          index: index,
                          surahModel: SurahModel(
                              name: surahsApi[index]["name"],
                              number: surahsApi[index]["number"].toString(),
                              revelationType: surahsApi[index]
                                  ["revelationType"],
                              numberOfAyahs:
                                  surahsApi[index]["numberOfAyahs"].toString(),
                              page: surahsApi[index]['page'].toString()),
                        )
                      : const SizedBox.shrink();
                },
              ),
            );
          },
        )),
      );
    });
  }
}
