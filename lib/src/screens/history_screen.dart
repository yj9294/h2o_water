import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/services/history_service.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends BasePageState<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(S.current.history_title,
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
      body: _buildContentView(),
    );
  }

  @swidget
  Widget _buildContentView() {
    final historyLogic = context.watch<HistoryLogic>();
    return ListView.builder(
        padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        itemCount: historyLogic.recordsModel.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _buildChildGridView(historyLogic.recordsModel[index]),
            ));
  }

  @swidget
  Widget _buildChildGridView(List<RecordModel> records) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor("#87C100").withOpacity(0.3),
                HexColor("#B4DB55").withOpacity(0.3)
              ]),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(records[0].day,
                style: TextStyle(
                    color: HexColor("#000000").withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          Container(
              height: 1,
              width: MediaQuery.sizeOf(context).width - 72,
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: HexColor("#000000").withOpacity(0.1)),
          GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 335.0 / 64.0,
            children: records.map((e) => _buildChildGridItem(e)).toList(),
          )
        ],
      ),
    );
  }

  @swidget
  Widget _buildChildGridItem(RecordModel record) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Center(
                  child: Image.asset("assets/images/${record.item.icon}.png",
                      width: 35, height: 44)),
              const SizedBox(width: 8),
              Text(record.item.localTitle,
                  style: TextStyle(
                      color: HexColor("#000000").withOpacity(0.6),
                      fontSize: 18,
                      fontWeight: FontWeight.w500))
            ],
          ),
          Text("${record.ml}ml",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  void back() {
    Navigator.pop(context);
  }
}
