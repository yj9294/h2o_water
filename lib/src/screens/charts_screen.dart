import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:h2o_keeper/src/models/charts_item.dart';
import 'package:h2o_keeper/src/models/charts_model.dart';
import 'package:h2o_keeper/src/screens/history_screen.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(color: HexColor("#B4DB55")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildTopView(), _buildChartView(), _buildGADView()],
      ),
    );
  }

  @swidget
  Widget _buildTopView() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: HexColor("#B4DB55"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTopItemView(ChartsItem.day),
          _buildTopItemView(ChartsItem.week),
          _buildTopItemView(ChartsItem.month),
          _buildTopItemView(ChartsItem.year),
          CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) => HistoryLogic(),
                            child: const HistoryScreen())));
              },
              child: Center(
                  child: Image.asset("assets/images/charts_history.png",
                      width: 24, height: 24)))
        ],
      ),
    );
  }

  @swidget
  _buildTopItemView(ChartsItem item) {
    final chartsLogic = context.watch<ChartsLogic>();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        chartsLogic.updateItem(item);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(item.localTitle,
            style: TextStyle(
                color: chartsLogic.item == item
                    ? HexColor("#87C100")
                    : HexColor("#87C100").withOpacity(0.5),
                fontSize: 20,
                fontWeight: FontWeight.w900)),
      ),
    );
  }

  @swidget
  _buildChartView() {
    final chartsLogic = context.watch<ChartsLogic>();
    return Padding(
      padding: const EdgeInsets.only(top: 37, left: 20, right: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
        height: 40 * chartsLogic.chartsLeft.length.toDouble() + 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildChartLeftView(),
            Flexible(child: _buildChartRightView())
          ],
        ),
      ),
    );
  }

  @swidget
  Widget _buildChartLeftView() {
    final chartsLogic = context.watch<ChartsLogic>();
    return Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: chartsLogic.chartsLeft
              .map((e) => _buildChartLeftItem(e.toString()))
              .toList(),
        ));
  }

  @swidget
  Widget _buildChartLeftItem(String value) {
    return SizedBox(
        width: 50,
        height: 40,
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                color: HexColor("#000000").withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.right,
          ),
        ));
  }

  @swidget
  Widget _buildChartRightView() {
    final chartsLogic = context.watch<ChartsLogic>();
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 130,
      height: 40 * chartsLogic.chartsLeft.length.toDouble() + 40,
      child: Stack(
        children: [
          Positioned.fill(child: _buildLineBGView()),
          _buildRightContentView()
        ],
      ),
    );
  }

  @swidget
  Widget _buildLineBGView() {
    final chartsLogic = context.watch<ChartsLogic>();
    return Column(
      children: chartsLogic.chartsLeft.map((e) => _buildLineView()).toList(),
    );
  }

  @swidget
  Widget _buildLineView() {
    return Padding(
      padding: const EdgeInsets.only(top: 19.5, bottom: 19.5),
      child: Container(
        height: 1,
        color: HexColor("#87C100").withOpacity(0.15),
      ),
    );
  }

  @swidget
  Widget _buildRightContentView() {
    final chartsLogic = context.watch<ChartsLogic>();
    return Container(
      padding: EdgeInsets.zero,
      child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          shrinkWrap: true,
          mainAxisSpacing: 15,
          crossAxisSpacing: 0,
          childAspectRatio: 240.0 / 40,
          children: chartsLogic.chartsModels
              .map((e) => _buildRightContentProgressView(e))
              .toList()),
    );
  }

  @swidget
  Widget _buildRightContentProgressView(ChartsModel model) {
    return SizedBox(
      width: 40,
      height: 240,
      child: Column(
        children: [
          _buildProgressItem(model.progress),
          _buildProgressBottomView(model.unit)
        ],
      ),
    );
  }

  @swidget
  Widget _buildProgressItem(double progress) {
    return Padding(
      padding: const EdgeInsets.only(top: 19.5, bottom: 19.5),
      child: Column(
        children: [
          Container(
            width: 40,
            height: (200 - 39) * (1 - progress),
            color: Colors.transparent,
          ),
          Container(
            width: 40,
            height: progress * (200.0 - 39.0),
            color: HexColor("#87C100"),
          )
        ],
      ),
    );
  }

  @swidget
  Widget _buildProgressBottomView(String unit) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(unit,
              style: TextStyle(
                  color: HexColor("#000000"),
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  @swidget
  Widget _buildGADView() {
    final homeLogic = context.watch<HomeLogic>();
    final width = MediaQuery.sizeOf(context).width - 40;
    final height = width * 116.0 / 335.0;
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
            width: width,
            height: height,
            child: homeLogic.hasNativeAD
                ? AdWidget(ad: homeLogic.adModel.ad!)
                : const Center()));
  }
}
