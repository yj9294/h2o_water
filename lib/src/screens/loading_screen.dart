
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/src/services/loading_service.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends BasePageState {

  @override
  Widget build(BuildContext context) {
    final lodingLogic = context.watch<LoadingLogic>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/loading.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  _contentTitle()
                ],
              ),
              _progressView(lodingLogic.progress)
            ],
          )
        ],
      ),
    );
  }

  @swidget
  Widget _contentTitle() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Text("H20", style: TextStyle(color: HexColor("#547605"), fontSize: 44, fontWeight: FontWeight.w900)),
          Text("Keepper", style: TextStyle(color: HexColor("#547605"), fontSize: 44, fontWeight: FontWeight.w900))
        ],
      ),
    );
  }

  @swidget
  Widget _progressView(double progress) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 60, top: 239),
      child: LinearProgressIndicator(
              color: HexColor("#87C100"),
              backgroundColor: HexColor("#F0FFCB"),
              borderRadius: BorderRadius.circular(2),
              value: progress,
            )
    );
  }
}