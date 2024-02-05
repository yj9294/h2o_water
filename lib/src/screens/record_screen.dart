import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/gad_position.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/services/charts_service.dart';
import 'package:h2o_keeper/src/services/home_service.dart';
import 'package:h2o_keeper/src/services/medal_service.dart';
import 'package:h2o_keeper/src/services/record_service.dart';
import 'package:h2o_keeper/src/utils/gad_util.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RecordScreenState();
}

class _RecordScreenState extends BasePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(S.current.record_title,
              style: TextStyle(
                  color: HexColor("#030002"),
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          leading: CupertinoButton(
            onPressed: back,
            child: Image.asset("assets/images/back.png"),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor("#87C100"),
                HexColor("#B4DB55").withOpacity(0.3)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Image.asset("assets/images/record.png"),
            Column(
              children: [
                _buildTopView(),
                Flexible(child: _buildGridView()),
                _buildButtonView()
              ],
            )
          ],
        ));
  }

  @swidget
  Widget _buildTopView() {
    final recordLogic = context.watch<RecordLogic>();
    return SizedBox(
      height: 210,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/goal_2.png", height: 140),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                recordLogic.item == RecordItem.customization
                    ? TextField(
                        controller: recordLogic.nameController,
                        minLines: 1,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#496900")),
                        onChanged: (text) {
                          recordLogic.updateName(text);
                        })
                    : Text(recordLogic.item.localTitle,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#496900"))),
                SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                            controller: recordLogic.mlController,
                            minLines: 1,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#496900"))),
                      ),
                      Text("ml",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: HexColor("#496900")))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @swidget
  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 22,
          crossAxisSpacing: 15,
          childAspectRatio: 160.0 / 108.0,
          children: RecordItem.values.indexed
              .map((e) => _buildGridItem(e.$1))
              .toList()),
    );
  }

  @swidget
  Widget _buildGridItem(int index) {
    final recordLogic = context.watch<RecordLogic>();
    final item = RecordItem.values[index];
    return CupertinoButton(
      onPressed: () {
        recordLogic.updateItem(item);
      },
      padding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: (MediaQuery.sizeOf(context).width - 55) / 2.0,
            height: 80,
            decoration: BoxDecoration(
                color: recordLogic.colors[index],
                borderRadius: const BorderRadius.all(Radius.circular(16))),
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("assets/images/${item.icon}.png",
                    width: 80, height: 100),
                Container(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 55,
                            child: Text(item.localTitle,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400))),
                        Text("200",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w500))
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @swidget
  Widget _buildButtonView() {
    final homeLogic = context.watch<HomeLogic>();
    final chartsLogic = context.watch<ChartsLogic>();
    final medalLogic = context.watch<MedalLogic>();

    final recordLogic = context.watch<RecordLogic>();
    return CupertinoButton(
      onPressed: () {
        if (recordLogic.isMLSure) {
          homeLogic.appendRecord(recordLogic.recordModel);
          chartsLogic.updateRecord(homeLogic.records);
          medalLogic.updateRecord(homeLogic.records);
          saveButtonTapped();
        }
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 48, right: 48, bottom: 10),
        child: Center(
          child: Image.asset("assets/images/goal_button.png"),
        ),
      ),
    );
  }

  void saveButtonTapped() {
    final homeLogic = context.read<HomeLogic>();
    homeLogic.updateShowInteresttitalAD(true);
    GADUtil().load(GADPosition.interstitial);
    GADUtil().show(GADPosition.interstitial, closeHandler: () {
      Future.delayed(const Duration(seconds: 1), () {
        homeLogic.updateShowInteresttitalAD(false);
      });
      back();
    });
  }

  void back() {
    Navigator.pop(context);
  }
}
