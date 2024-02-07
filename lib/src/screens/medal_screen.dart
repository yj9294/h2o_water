import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/medal_item.dart';
import 'package:h2o_keeper/src/services/medal_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class MedalScreen extends StatefulWidget {
  const MedalScreen({super.key});

  @override
  State<MedalScreen> createState() => _MedalScreenState();
}

class _MedalScreenState extends State<MedalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(S.current.medal_title,
              style: TextStyle(
                  color: HexColor("#030002"),
                  fontSize: 22,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: _buildContentView());
  }

  @swidget
  Widget _buildContentView() {
    return ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildKeepView();
          } else if (index == 1) {
            return _buildGoalView();
          }
          return null;
        });
  }

  @swidget
  _buildKeepView() {
    final medalLogic = context.watch<MedalLogic>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.keep_title,
            style: TextStyle(
                color: HexColor("#030002"),
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            mainAxisSpacing: 20,
            childAspectRatio: 70 / 110,
            children:
                medalLogic.keepModels.map((e) => _buildKeepItem(e)).toList(),
          ),
        )
      ],
    );
  }

  @swidget
  Widget _buildKeepItem(MedalKeep item) {
    final medalLogic = context.watch<MedalLogic>();
    return Center(
        child:
            Image.asset("assets/images/${item.iconWith(medalLogic.records)}"));
  }

  @swidget
  _buildGoalView() {
    final medalLogic = context.watch<MedalLogic>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.arch_title,
            style: TextStyle(
                color: HexColor("#030002"),
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.count(
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 20,
              childAspectRatio: 70 / 110,
              children:
                  medalLogic.goalModels.map((e) => _buildGoalItem(e)).toList()),
        )
      ],
    );
  }

  @swidget
  Widget _buildGoalItem(MedalGoal item) {
    final medalLogic = context.watch<MedalLogic>();
    return Center(
        child:
            Image.asset("assets/images/${item.iconWith(medalLogic.records)}"));
  }
}
