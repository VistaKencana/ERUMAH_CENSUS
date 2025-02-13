import 'package:eperumahan_bancian/data/api/repositories/bloc/dropddown_bloc/dropdown_bloc.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/property_bloc/property_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/anak_tanggungan/bloc/anak_tanggungan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bloc/bancian_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/pasangan/bloc/pasangan_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/penghuni/bloc/penghuni_bloc.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/unit_kedai/bloc/unit_kedai_bloc.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:eperumahan_bancian/screens/profile/bloc/profile_bloc.dart';
import 'package:eperumahan_bancian/screens/qr-home/bloc/qr_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocs {
  /*REGISTER YOUR BLOC HERE*/
  static List<BlocProvider> listOfBloc = [
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
    BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
    BlocProvider<DropdownBloc>(create: (context) => DropdownBloc()),
    BlocProvider<PropertyBloc>(create: (context) => PropertyBloc()),
    BlocProvider<QrBloc>(create: (context) => QrBloc()),
    BlocProvider<BancianBloc>(create: (context) => BancianBloc()),
    BlocProvider<PenghuniBloc>(create: (context) => PenghuniBloc()),
    BlocProvider<PasanganBloc>(create: (context) => PasanganBloc()),
    BlocProvider<AnakTanggunganBloc>(create: (context) => AnakTanggunganBloc()),
    BlocProvider<UnitKedaiBloc>(create: (context) => UnitKedaiBloc()),
  ];
}
