import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'packinglist_state.dart';

class PackinglistCubit extends Cubit<PackinglistState> {
  PackinglistCubit() : super(PackinglistInitial());
  Future<void> scanPack(String scanCode) async {
    if (state is PackinglistLoaded) {
      var currentState = state as PackinglistLoaded;
      emit(PackinglistLoading());
      currentState.packListCode = scanCode;
      
      emit(PackinglistLoaded());
    }
  }
}
