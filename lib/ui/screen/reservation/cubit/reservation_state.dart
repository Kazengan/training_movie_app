part of 'reservation_cubit.dart';

sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ReservationLoading extends ReservationState {}

final class ReservationsLoaded extends ReservationState {
  final List<String> seats;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? selectedSeat;

  ReservationsLoaded({
    required this.seats,
    this.selectedDate,
    this.selectedTime,
    this.selectedSeat,
  });
}

final class ReservationFailed extends ReservationState {
  final String message;

  ReservationFailed({required this.message});
}
