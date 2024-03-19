part of 'get_device_number_cubit.dart';

sealed class GetDeviceNumberState extends Equatable {
  const GetDeviceNumberState();

  @override
  List<Object> get props => [];
}

final class GetDeviceNumberInitial extends GetDeviceNumberState {}
final class GetDeviceNumberLoading extends GetDeviceNumberState {}
final class GetDeviceNumberLoaded extends GetDeviceNumberState {
 const GetDeviceNumberLoaded({required this.contacts});
 final List<ContactEntity> contacts;

  @override
  List<Object> get props => [contacts];
}
final class GetDeviceNumberFailure extends GetDeviceNumberState {}
