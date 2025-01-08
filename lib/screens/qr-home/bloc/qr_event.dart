part of 'qr_bloc.dart';

sealed class QrEvent extends Equatable {
  const QrEvent();

  @override
  List<Object> get props => [];
}

class ScanQrcode extends QrEvent {
  final String qrCode;
  final bool isFromHome;

  const ScanQrcode({required this.qrCode, required this.isFromHome});
}

class ManualQrcode extends QrEvent {
  final String unitCode;
  final bool isFromHome;

  const ManualQrcode({required this.unitCode, required this.isFromHome});
}

class RegisterQrcode extends QrEvent {
  const RegisterQrcode();
}

class UpdateQrcode extends QrEvent {}
