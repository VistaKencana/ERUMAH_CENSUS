part of 'qr_bloc.dart';

sealed class QrState extends Equatable {
  const QrState();

  @override
  List<Object> get props => [];
}

final class QrInitial extends QrState {}

final class QrLoading extends QrState {}

final class QrRegLoading extends QrState {}

final class UnitCodeLoading extends QrState {}

final class UnitCodeSuccess extends QrState {
  final ResidentInfoData? data;

  const UnitCodeSuccess({this.data});
}

final class QrSuccess extends QrState {
  final ResidentInfoData? data;

  const QrSuccess({this.data});
}

final class QrRegSuccess extends QrState {}

final class QrError extends QrState {
  final String msg;

  const QrError({required this.msg});
}

final class UnitCodeError extends QrState {
  final String msg;

  const UnitCodeError({required this.msg});
}

final class QrRegError extends QrState {
  final String msg;

  const QrRegError({required this.msg});
}

final class QrNotFound extends QrState {
  final String msg;

  const QrNotFound({required this.msg});
}

final class QrNotTally extends QrState {
  final String msg;

  const QrNotTally({required this.msg});
}
