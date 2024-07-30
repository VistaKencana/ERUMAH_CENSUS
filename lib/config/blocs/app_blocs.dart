import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocs {
  /*REGISTER YOUR BLOC HERE*/
  static List<BlocProvider> listOfBloc = [
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
  ];
}
