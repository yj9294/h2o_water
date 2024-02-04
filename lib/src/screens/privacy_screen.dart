
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends BasePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#EFF5E1"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(S.current.privacy, style: TextStyle(color: HexColor("#030002"), fontSize: 18)),
        leading: CupertinoButton(onPressed: back, child: Image.asset("assets/images/back.png"),),
        centerTitle: true,
      ),
      body: _buildContentView(),
    );
  }

  @swidget
  Widget _buildContentView() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: ListView.builder(padding: const EdgeInsets.all(16),itemCount: 1, shrinkWrap: true, itemBuilder: (context, index) {
        return Text(S.current.privacy_desc, style: TextStyle(color: HexColor("#000000").withOpacity(0.87), fontSize: 16), softWrap: true);
      }),
    );
  }

  void back() {
    Navigator.pop(context);
  }
}