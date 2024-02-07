
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/profile_item.dart';
import 'package:h2o_keeper/src/screens/language_screen.dart';
import 'package:h2o_keeper/src/screens/privacy_screen.dart';
import 'package:h2o_keeper/src/screens/reminder_screen.dart';
import 'package:h2o_keeper/src/screens/tip_screen.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileLogic = context.watch<ProfileLogic>();
    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [HexColor("#87C100").withOpacity(0.3), profileLogic.isRefresh ? HexColor("#87C100") : HexColor("#87C101").withOpacity(0.3)])
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(S.current.profile_title, style: TextStyle(color: HexColor("#000000").withOpacity(0.87), fontSize: 22)),
            centerTitle: true,
          ),
          body: _buildContentView(),
        )
      ],
    );
  }

  @swidget
  Widget _buildContentView() {
    return ListView.builder(itemCount: ProfileItem.values.length + 1, itemBuilder: (context, index) {
      if (index < 4) {
        return _buildListItem(ProfileItem.values[index]);
      } else {
        return _buildStaticListView();
      }
    });
  }

  @swidget
  Widget _buildListItem(ProfileItem item) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        gotoItemView(item);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(item.title, style: TextStyle(color: HexColor("#030002"), fontSize: 16, fontWeight: FontWeight.w500)),
            Image.asset("assets/images/arrow_right.png", width: 20, height: 20,)
          ],
        ),
      ),
    );
  }

  @swidget 
  Widget _buildStaticListView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white),
        child: SizedBox(
          height: 300,
          child: ListView.builder(itemCount: ProfileTipItem.values.length, physics: const NeverScrollableScrollPhysics(), itemBuilder: (context, index) {
            return _buildTipsItem(ProfileTipItem.values[index]);
          }),
        ),
      ),
    );
  }

  @swidget
  Widget _buildTipsItem(ProfileTipItem item) {
    return CupertinoButton(
      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 16, right: 16),
      onPressed: () {
        gotoDetaiView(item);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.sizeOf(context).width - 156, child: Text(item.title, style: TextStyle(fontSize: 14, color: HexColor("#030002")), maxLines: 2, softWrap: true,)),
              Center(
                child: Image.asset("assets/images/${item.icon}", width: 72, height: 72),
              )
            ],
          ),
          item == ProfileTipItem.when ? const Center() : const SizedBox(height: 2, child: Divider())
        ],
      ),
    );
  }

  void gotoItemView(ProfileItem item) {
    switch (item) {
      case ProfileItem.reminder:
        Navigator.push(context,
          CupertinoPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => ReminderLogic(), child: const ReminderScreen())));
      case ProfileItem.language:
        Navigator.push(context,
          CupertinoPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => LanguageLogic(), child: const LanguageScreen())));
      case ProfileItem.privacy:
        Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const PrivacyScreen()));
      case ProfileItem.rate:
          launchAppStore();
      default:break;
    }
  }

  void gotoDetaiView(ProfileTipItem item) {
    Navigator.push(context,
          CupertinoPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => TipLogic(item), child: const TipScreen())));
  }

  void launchAppStore() async {
    // Replace 'your_app_id' with the actual App Store ID of your app
    // ignore: prefer_const_declarations
    LaunchReview.launch(iOSAppId: "6477433880");
  }
}