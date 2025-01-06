//REGISTER PROVIDERS HERE
import 'package:eperumahan_bancian/data/api/repositories/provider/dropdown_provider.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/subrent/provider/subrent_provider.dart';
import 'package:eperumahan_bancian/screens/dashboard/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  //Register provider here
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => DashboardProvider()),
    ChangeNotifierProvider(create: (context) => DropdownProvider()),
    ChangeNotifierProvider(create: (context) => SubrentProvider()),
  ];
}
