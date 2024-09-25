part of 'qr_bloc.dart';

sealed class QrState extends Equatable {
  const QrState();

  @override
  List<Object> get props => [];
}

final class QrInitial extends QrState {}

final class QrLoading extends QrState {}

final class QrSuccess extends QrState {
  final ResidentInfoData? data;

  const QrSuccess({this.data});
}

final class QrError extends QrState {
  final String msg;

  const QrError({required this.msg});
}

final class QrNotFound extends QrState {
  final String msg;

  const QrNotFound({required this.msg});
}
