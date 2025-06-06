part of 'get_burung_tersedia_bloc_bloc.dart';

@immutable
sealed class GetBurungTersediaBlocState {}

final class GetBurungTersediaBlocInitial extends GetBurungTersediaBlocState {}

final class GetBurungTersediaLoading extends GetBurungTersediaBlocState {}

final class GetBurungTersediaLoaded extends GetBurungTersediaBlocState {
  final BurungSemuaTersediaModel burungTersedia;

  GetBurungTersediaLoaded({required this.burungTersedia});
}

final class GetBurungTersediaError extends GetBurungTersediaBlocState {
  final String message;

  GetBurungTersediaError({required this.message});
}
