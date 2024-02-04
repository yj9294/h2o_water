
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/src/models/profile_item.dart';
import 'package:h2o_keeper/src/services/tip_service.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TipScreenState();
}

class _TipScreenState extends BasePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DDEAC7"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Details", style: TextStyle(color: HexColor("#030002"), fontSize: 18)),
        leading: CupertinoButton(onPressed: back, child: Image.asset("assets/images/back.png"),),
        centerTitle: true,
      ),
      body: _buildContentView(),
    );
  }

  @swidget 
  Widget _buildContentView() {
    return Column(
      children: [
        _buildTopView(),
        Flexible(child: _buildContentTextView())
      ],
    );
  }

  @swidget
  Widget _buildTopView() {
    final logic = context.watch<TipLogic>();
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: Text(logic.item.title, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700), softWrap: true, maxLines: 2),
    );
  }

  @swidget
  Widget _buildContentTextView() {
    final logic = context.watch<TipLogic>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(shrinkWrap: true, itemCount: 1, itemBuilder: (context, index) {
        return Text(logic.item.description, style: TextStyle(color: HexColor("#000000").withOpacity(0.87), fontSize: 16), softWrap: true);
      }),
    );  
  }

  void back() {
    Navigator.pop(context);
  }
}

extension StringNumberExt on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
}