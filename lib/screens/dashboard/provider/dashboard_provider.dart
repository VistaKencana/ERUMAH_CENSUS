import 'package:eperumahan_bancian/data/api/repositories/dashboard_repository.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_activity_json_model.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_json_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  List<DashboardModel> latestList = [];
  bool latestLoading = false;
  List<DashboardModel> incompleteList = [];
  bool incompleteLoading = false;
  DashboardUserActivity acitivtyData = DashboardUserActivity();
  bool activityLoading = false;
  final repo = DashboardRepository();
  final log = const AppLog(classname: "DashboardProvider");

  Future<void> initDashboard() async {
    setListLoading(true);
    await Future.wait([
      fetchUserActivity(),
      fetchLatest(),
      fetchIncomplete(),
    ]);
  }

  void setListLoading(bool val) {
    latestLoading = val;
    incompleteLoading = val;
    activityLoading = val;
    notifyListeners();
  }

  Future fetchLatest() async {
    // MARK: Download Latest
    try {
      latestList = await repo.getLatest();
    } catch (e) {
      log.logError(tag: "initDashboard-latest", msg: e.toString());
    } finally {
      latestLoading = false;
      notifyListeners();
    }
  }

  Future fetchIncomplete() async {
    // MARK: Download Incomplete
    try {
      incompleteList = await repo.getIncomplete();
    } catch (e) {
      log.logError(tag: "initDashboard-incomplete", msg: e.toString());
    } finally {
      incompleteLoading = false;
      notifyListeners();
    }
  }

  Future fetchUserActivity() async {
    // MARK: User Activity
    try {
      acitivtyData = await repo.getUserActivity();
    } catch (e) {
      log.logError(tag: "initDashboard-user activity", msg: e.toString());
    } finally {
      activityLoading = false;
      notifyListeners();
    }
  }
}
