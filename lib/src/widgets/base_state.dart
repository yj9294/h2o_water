
import 'package:flutter/cupertino.dart';

import 'package:h2o_keeper/main.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> with
    RouteAware, WidgetsBindingObserver  {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    debugPrint("$widget dispose 💧💧💧💧");
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint("$widget init 🔥🔥🔥🔥");
  }

  @override
  void didPopNext() {
    super.didPopNext();
    debugPrint("$widget appear ✅✅✅✅");
  }

  @override
  void didPush() {
    super.didPush();
    debugPrint("$widget appear ✅✅✅✅");
  }

  @override
  void didPop() {
    super.didPop();
    debugPrint("$widget disappear ❌❌❌❌");
  }

  @override
  void didPushNext() {
    super.didPushNext();
    debugPrint("$widget disappear ❌❌❌❌");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // 应用程序进入后台
      // 在这里执行进入后台时的操作
    } else if (state == AppLifecycleState.resumed) {
      // 应用程序从后台返回前台
      // 在这里执行返回前台时的操作
    }
  }
}