import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/equipment/create_local_equipment_usecase.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_equipment_by_copy_num_and_item_id_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_states.dart';
import 'package:sccc_v3/service_locator.dart';

class EquipmentDetailsCubit extends Cubit<EquipmentDetailsState> {
  EquipmentDetailsCubit() : super(EquipmentDetailsInitial());

  Future<void> loadEquipmentDetails(EquipmentCopyByCopyNumAndItemIdReq params) async {
    emit(EquipmentDetailsLoading());
    try {
      final result = await getIt<GetEquipmentByCopyNumAndItemIdUsecase>().call(param: params);
      result.fold((error) {
        getIt<Logger>().e('$error');
        emit(EquipmentDetailsError(message: error));
      }, (equipment) => emit(EquipmentDetailsLoaded(equipment: equipment)));
    } catch (e) {
      emit(EquipmentDetailsError(message: e.toString()));
    }
  }

  Future<void> borrowEquipmentCopy(LocalEquipmentCopyEntity params) async {
    emit(EquipmentDetailsLoading());
    try {
      await getIt<CreateLocalEquipmentUsecase>().call(param: params);
    } catch (e) {
      emit(EquipmentDetailsBorrowError(message: e.toString()));
    }
  }
}
