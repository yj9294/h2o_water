
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/services/goal_service.dart';
import 'package:h2o_keeper/src/services/home_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(S.current.goal_title, style: TextStyle(color: HexColor("#030002"), fontSize: 18, fontWeight: FontWeight.w500)),
        leading: CupertinoButton(onPressed: back, child: Image.asset("assets/images/back.png"),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCenterView(),
          _buildSliderView(),
          _buildButtonView()
        ],
      )
    );
  }

  @swidget
  Widget _buildCenterView() {
    final goalLogic = context.watch<GoalLogic>();
    return Padding(
      padding: const EdgeInsets.only(top: 29, left: 106, right: 106),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Image.asset("assets/images/goal_1.png")),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text("${goalLogic.goal}ml",
                    style: TextStyle(
                        color: HexColor("#87C100"),
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
              ))
        ],
      )
    );
  }

  @swidget
  Widget _buildSliderView() {
    final goalLogic = context.watch<GoalLogic>();
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 24,
        child: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                goalLogic.goalDecrease();
              }, 
              child: Image.asset("assets/images/goal_-.png", width: 24, height: 24,)),
            Flexible(child: Slider(
              value: goalLogic.progress,
              max: 1.0,
              min: 0.025,
              activeColor: HexColor("#87C100"),
              inactiveColor: HexColor("#F0FFCB"),
              onChanged: (value) {
                final progress = (value * 4000).toInt();
                goalLogic.updateGoal(progress);            
              },
              onChangeStart: (value) {
                final progress = (value * 4000).toInt();
                goalLogic.updateGoal(progress);
              },
              onChangeEnd: (value) {
                final progress = (value * 4000).toInt();
                goalLogic.updateGoal(progress);
              },
            )),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                goalLogic.goalAdd();
              }, 
              child: Image.asset("assets/images/goal+.png", width: 24, height: 24)),
          ],
        ),
      ),
    );
  }

  @swidget
  Widget _buildButtonView() {
    final homeLogic = context.watch<HomeLogic>();
    final goalLogic = context.watch<GoalLogic>();
    return Padding(
        padding: const EdgeInsets.only(top: 90, left: 48, right: 48),
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              homeLogic.updateGoal(goalLogic.goal);
              Navigator.pop(context);
            },
            child: Center(
              child: Image.asset("assets/images/goal_button.png"),
            )));
  }

  void back() {
    Navigator.pop(context);
  }
}