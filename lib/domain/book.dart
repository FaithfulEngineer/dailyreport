class Book {
  Book(this.id, this.type, this.reportdate, this.diary, this.email,
      this.contets);
  String id;
  String type;
  String contets;
  String reportdate;
  DateTime reoportdated = DateTime.now();
  String diary;
  String email;
}
