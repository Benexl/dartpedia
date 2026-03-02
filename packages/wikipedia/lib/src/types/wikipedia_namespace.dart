class WikipediaNamespace {
  final int id;
  final String text;
  WikipediaNamespace({required this.id, required this.text});

  factory WikipediaNamespace.fromJson(Map<String, dynamic> json) =>
      WikipediaNamespace(id: json['id'] as int, text: json['text'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}
