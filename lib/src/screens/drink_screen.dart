
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/screens/goal_screen.dart';
import 'package:h2o_keeper/src/screens/record_screen.dart';
import 'package:h2o_keeper/src/services/goal_service.dart';
import 'package:h2o_keeper/src/services/home_service.dart';
import 'package:h2o_keeper/src/services/record_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class DrinkScreen extends StatefulWidget {
  const DrinkScreen({super.key});

  @override
  State<DrinkScreen> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [ 
          _buildTopView(),
          _buildProgressView(),
          _buildButtonView()
        ],
      ),
    );
  }

  @swidget
  Widget _buildTopView() {
    return Stack(alignment: Alignment.topCenter, children: [
            Container(
              padding: const EdgeInsets.only(top: 37, left: 111, right: 111),
              child: Image.asset("assets/images/drink_title.png")),
            Image.asset("assets/images/drink_center.png")
          ]);
  }

  @swidget
  Widget _buildProgressView() {
    final homeLogic = context.watch<HomeLogic>();
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(color: HexColor("#F0FFCB"), borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Center(child: Text("${homeLogic.progress}%", style: TextStyle(color: HexColor("#87C100"), fontSize: 32, fontWeight: FontWeight.w700)))
      ),
    );
  }

  @swidget
  Widget _buildButtonView() {
    final homeLogic = context.watch<HomeLogic>();
    return Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20), 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(padding: EdgeInsets.zero, onPressed: ()=> toGoalView(), child: _buildDailyButtonView(homeLogic.goal)),
        CupertinoButton(padding: EdgeInsets.zero, onPressed: () => toRecordView(), child: _buildRecordButtonView()),
      ],
    ));
  }

  @swidget
  Widget _buildDailyButtonView(int today) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(child: Image.asset("assets/images/drink_bg_1.png", width: 205, height: 52,)),
        Padding(padding: const EdgeInsets.only(top: 17, bottom: 17 ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(S.current.daily_goal_title(today),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          Center(child: Image.asset("assets/images/drink_edit.png", width: 20, height: 20,))
        ])),
      ],
    );
  }

  @swidget
  Widget _buildRecordButtonView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(child: Image.asset("assets/images/drink_bg.png", width: 110, height: 52,)),
        Row(children: [
          Text(S.current.add_to, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          Center(child: Image.asset("assets/images/drink_add.png", width: 20, height: 20,))
        ]),
      ],
    );
  }

  void toGoalView() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(create: (context) => GoalLogic(), child: const GoalScreen())));
  }

  void toRecordView() {
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => RecordLogic(), child: const RecordScreen())));
  }
}