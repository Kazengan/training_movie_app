import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  Future<void> loadTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataTicket = prefs.getStringList('ticket') ?? [];

    List<TicketEntity> tickets = dataTicket
        .map((ticketJson) => TicketEntity.fromJson(ticketJson))
        .toList();

    emit(TicketLoaded(tickets: tickets));
  }

  Future<void> addTicket(TicketEntity ticket) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataTicket = prefs.getStringList('ticket') ?? [];

    dataTicket.add(ticket.toJson());
    prefs.setStringList('ticket', dataTicket);

    loadTickets();
  }
}
