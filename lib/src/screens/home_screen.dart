import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/src/models/tabbar_item.dart';
import 'package:h2o_keeper/src/screens/charts_screen.dart';
import 'package:h2o_keeper/src/screens/drink_screen.dart';
import 'package:h2o_keeper/src/screens/medal_screen.dart';
import 'package:h2o_keeper/src/screens/profile_screen.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:h2o_keeper/src/widgets/base_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageState {
  initState() {
    super.initState();
    AppTrackingTransparency.requestTrackingAuthorization();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final logic = context.read<LoadingLogic>();
    if (state == AppLifecycleState.paused) {
      // 在这里执行进入后台时的操作
    } else if (state == AppLifecycleState.resumed) {
      // 在这里执行返回前台时的操作
      logic.startLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentView(),
    );
  }

  @swidget
  Widget _contentView() {
    final homeLogic = context.watch<HomeLogic>();
    return Column(
      children: [
        _buildContent(),
        _tabbarView(homeLogic.item),
        const SizedBox(height: 10)
      ],
    );
  }

  @swidget
  Widget _buildContent() {
    final homeLogic = context.watch<HomeLogic>();
    if (homeLogic.item == TabbarItem.drink) {
      return const Flexible(child: DrinkScreen());
    } else if (homeLogic.item == TabbarItem.charts) {
      return const Flexible(child: ChartsScreen());
    } else if (homeLogic.item == TabbarItem.medal) {
      return const Flexible(child: MedalScreen());
    } else {
      return const Flexible(child: ProfileScreen());
    }
  }

  @swidget
  Widget _tabbarView(TabbarItem item) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: HexColor("#E5F2C6")),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              TabbarItem.values.map((e) => _tabbarItem(e, e == item)).toList(),
        ),
      ),
    );
  }

  Widget _tabbarItem(TabbarItem item, bool isSelected) {
    final homeLogic = context.watch<HomeLogic>();
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
      onPressed: () => homeLogic.updateItem(item),
      child: Center(
        child: Image.asset(
            "assets/images/${isSelected ? item.selectedIcon : item.icon}.png",
            width: 56,
            height: 36),
      ),
    );
  }
}
