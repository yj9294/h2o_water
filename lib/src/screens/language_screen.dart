
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/language_item.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends BasePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EFF5E1"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(S.current.language, style: TextStyle(color: HexColor("#030002"), fontSize: 18)),
        leading: CupertinoButton(onPressed: back, child: Image.asset("assets/images/back.png"),),
        centerTitle: true,
      ),
      body: _buildContentView(),
    );
  }

  @swidget _buildContentView() {
    final languageLogic = context.watch<LanguageLogic>();
    return ListView.builder(shrinkWrap: true, itemCount: languageLogic.items.length, itemBuilder: (context, index) {
      return _buildLanguageItem(languageLogic.items[index]);
    });
  }

  @swidget 
  Widget _buildLanguageItem(LanguageItem item) {
    final languageLogic = context.watch<LanguageLogic>();
    final homeLogic = context.watch<HomeLogic>();
    final profileLogic = context.watch<ProfileLogic>();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: (){
            languageLogic.updateItem(item);
            homeLogic.updateLanguage(item.languageCode);
            profileLogic.refreshUI();
          },
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.title, style: TextStyle(color: HexColor("#000000").withOpacity(0.87), fontSize: 16)),
                  Center(child: Image.asset(item != languageLogic.item ? "assets/images/choose.png" : "assets/images/selected.png"),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } 

  void back() {
    Navigator.pop(context);
  }
}