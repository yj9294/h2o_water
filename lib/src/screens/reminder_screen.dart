import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends BasePageState {
  @override
  Widget build(BuildContext context) {
    final reminderLogic = context.watch<ReminderLogic>();
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(S.current.reminder,
                  style: TextStyle(
                      color: HexColor("#030002"),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              leading: CupertinoButton(
                onPressed: back,
                child: Image.asset("assets/images/back.png"),
              ),
              actions: [
                CupertinoButton(
                    onPressed: () {
                      reminderLogic.updateShowTimeView(true);
                    },
                    child: Image.asset("assets/images/time_add.png"))
              ],
              centerTitle: true,
            ),
            body: Column(
              children: [
                _buildWeekendView(),
                Flexible(child: _buildListView()),
                _buildGADView()
              ],
            )),
        reminderLogic.showTimeView ? _buildTimeView() : const Center()
      ],
    );
  }

  @swidget
  Widget _buildWeekendView() {
    final reminderLogic = context.watch<ReminderLogic>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 16, left: 16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  HexColor("#87C100").withOpacity(0.25),
                  HexColor("#B4DB55").withOpacity(0.25)
                ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    reminderLogic.updateWeekMode(!reminderLogic.weekMode);
                  },
                  child: Row(
                    children: [
                      Text(S.current.week_mode,
                          style: TextStyle(
                              color: HexColor("#030002"), fontSize: 18)),
                      const SizedBox(width: 16),
                      Center(
                          child: Image.asset(
                              reminderLogic.weekMode
                                  ? "assets/images/reminder_on.png"
                                  : "assets/images/reminder_off.png",
                              width: 42,
                              height: 22))
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 211,
                  child: Text(S.current.week_desc,
                      style: TextStyle(
                          color: HexColor("#000000").withOpacity(0.6),
                          fontSize: 14),
                      maxLines: 2,
                      softWrap: true),
                )
              ],
            ),
            Center(
                child: Image.asset("assets/images/reminder_i.png",
                    width: 51, height: 100))
          ],
        ),
      ),
    );
  }

  @swidget
  Widget _buildListView() {
    final reminderLogic = context.watch<ReminderLogic>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  HexColor("#87C100").withOpacity(0.25),
                  HexColor("#B4DB55").withOpacity(0.25)
                ])),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: reminderLogic.items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _buildListItem(reminderLogic.items[index]),
                  index == reminderLogic.items.length - 1
                      ? const Center()
                      : Container(
                          height: 1,
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: const Divider())
                ],
              );
            }),
      ),
    );
  }

  @swidget
  Widget _buildListItem(String item) {
    final reminderLogic = context.watch<ReminderLogic>();
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(item,
              style: TextStyle(
                  color: HexColor("#000000").withOpacity(0.87), fontSize: 16)),
          CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                reminderLogic.deleteItem(item);
              },
              child: Image.asset("assets/images/reminder_delete.png",
                  width: 20, height: 20))
        ],
      ),
    );
  }

  @swidget
  Widget _buildTimeView() {
    final reminderLogic = context.watch<ReminderLogic>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            reminderLogic.updateShowTimeView(false);
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: HexColor("000000").withOpacity(0.6),
          ),
        ),
        Column(
          children: [
            const Spacer(),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: HexColor("#FFFFFF"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(S.current.time_select,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)),
                    const SizedBox(height: 20),
                    _buildPickerView(),
                    CupertinoButton(
                        onPressed: () {
                          reminderLogic.addNewReminder();
                          reminderLogic.updateShowTimeView(false);
                        },
                        child: Center(
                            child:
                                Image.asset("assets/images/goal_button.png")))
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @swidget
  Widget _buildPickerView() {
    final logic = context.watch<ReminderLogic>();
    return SizedBox(
      height: 200.0,
      child: Row(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.0,
              onSelectedItemChanged: (int index) {
                logic.updateHour(index);
              },
              children: List.generate(24, (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: logic.hour == index
                        ? TextStyle(
                            color: HexColor("#87C100"),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900)
                        : TextStyle(
                            color: HexColor("#000000"),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.0,
              onSelectedItemChanged: (int index) {
                logic.updateMintue(index);
              },
              children: List.generate(60, (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: logic.mintue == index
                        ? TextStyle(
                            color: HexColor("#87C100"),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900)
                        : TextStyle(
                            color: HexColor("#000000"),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                  ),
                );
              }),
            ),
          ),
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

  void back() {
    Navigator.pop(context);
  }
}
