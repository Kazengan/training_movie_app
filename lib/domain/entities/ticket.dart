import 'dart:convert';

class TicketEntity {
  final String id;
  final String seat;
  final DateTime date;
  final double price;
  final String title;
  final String urlImage;
  final int idMovie;

  const TicketEntity({
    required this.id,
    required this.seat,
    required this.date,
    required this.price,
    required this.title,
    required this.urlImage,
    required this.idMovie,
  });

  // Convert TicketEntity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seat': seat,
      'date': date.toString(),
      'price': price,
      'title': title,
      'urlImage': urlImage,
      'idMovie': idMovie,
    };
  }

  // Convert Map to TicketEntity
  factory TicketEntity.fromMap(Map<String, dynamic> map) {
    return TicketEntity(
      id: map['id'],
      seat: map['seat'],
      date: DateTime.parse(map['date']),
      price: map['price'],
      title: map['title'],
      urlImage: map['urlImage'],
      idMovie: map['idMovie'],
    );
  }

  // Convert TicketEntity to JSON
  String toJson() => json.encode(toMap());

  // Create TicketEntity from JSON
  factory TicketEntity.fromJson(String source) =>
      TicketEntity.fromMap(json.decode(source));
}
