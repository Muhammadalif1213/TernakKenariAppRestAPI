import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rest_api/data/models/response/burung_semua_tersedia_model.dart';
import 'package:rest_api/data/repository/get_all_burung_tersedia_repository.dart';

part 'get_burung_tersedia_bloc_event.dart';
part 'get_burung_tersedia_bloc_state.dart';

class GetBurungTersediaBlocBloc
    extends Bloc<GetBurungTersediaBlocEvent, GetBurungTersediaBlocState> {
  final GetAllBurungTersediaRepository getAllBurungTersediaRepository;

  GetBurungTersediaBlocBloc(this.getAllBurungTersediaRepository)
    : super(GetBurungTersediaBlocInitial()) {
    on<GetAllBurungTersediaBlocEvent>((_getAllBurungTersedia));
  }

  Future<void> _getAllBurungTersedia(
    GetAllBurungTersediaBlocEvent event,
    Emitter<GetBurungTersediaBlocState> emit,
  ) async {
    emit(GetBurungTersediaLoading());

    final result = await getAllBurungTersediaRepository.getAllBurungTersedia();

    result.fold(
      (error) => emit(GetBurungTersediaError(message: error)),
      (burungTersedia) => emit(GetBurungTersediaLoaded(burungTersedia: burungTersedia)),
    );
  }
}
