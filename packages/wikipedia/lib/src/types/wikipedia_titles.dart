class WikipediaTitles {
  final String canonical;
  final String normalized;
  final String display;
  WikipediaTitles({
    required this.canonical,
    required this.normalized,
    required this.display,
  });

  factory WikipediaTitles.fromJson(Map<String, dynamic> json) =>
      WikipediaTitles(
        canonical: json['canonical'] as String,
        normalized: json['normalized'] as String,
        display: json['display'] as String,
      );

  Map<String, dynamic> toJson() => {
    'canonical': canonical,
    'normalized': normalized,
    'display': display,
  };
}
