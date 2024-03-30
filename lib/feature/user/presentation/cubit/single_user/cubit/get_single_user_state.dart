part of 'get_single_user_cubit.dart';

sealed class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object> get props => [];
}

final class GetSingleUserInitial extends GetSingleUserState {}
final class GetSingleUserLoading extends GetSingleUserState {}
final class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity singleUser;
 const GetSingleUserLoaded({required this.singleUser});

 @override
 List<Object> get props => [singleUser];

}
final class GetSingleUserFailure extends GetSingleUserState {}
