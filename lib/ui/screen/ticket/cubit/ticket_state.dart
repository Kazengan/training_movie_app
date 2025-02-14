part of 'ticket_cubit.dart';

@immutable
sealed class TicketState {}

final class TicketInitial extends TicketState {}
final class TicketLoaded extends TicketState {
  final List<TicketEntity> tickets;

  TicketLoaded({required this.tickets});
}
