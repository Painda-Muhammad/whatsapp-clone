import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/feature/user/domain/entity/contact_entity.dart';
import 'package:whatsapp_clone_app/feature/user/domain/usecases/user/get_device_number.dart';

part 'get_device_number_state.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  GetDeviceNumberCubit({required this.getDeviceNumberUsecase}) : super(GetDeviceNumberInitial());

  final GetDeviceNumberUsecase getDeviceNumberUsecase;

  Future<void> getDeviceNumber()async{
    try{
      final contactNumbers = await getDeviceNumberUsecase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumbers)); 
    }catch(_){
      emit(GetDeviceNumberFailure());
    }
  }
}
