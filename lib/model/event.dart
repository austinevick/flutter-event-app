class Event {
  final String title;
  final String description;

  const Event(this.title, this.description);

  @override
  String toString() => 'Event(title: $title, description: $description)';
}
