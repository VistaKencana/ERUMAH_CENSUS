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

class RegisterQrcode extends QrEvent {
  final String qrCode;
  final String unitCode;

  const RegisterQrcode({required this.qrCode, required this.unitCode});
}

class UpdateQrcode extends QrEvent {
  final String qrCode;
  final String unitCode;
  const UpdateQrcode({required this.qrCode, required this.unitCode});
}
