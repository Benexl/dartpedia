class WikipediaImage {
  final String source;
  final int width;
  final int height;
  WikipediaImage({
    required this.source,
    required this.width,
    required this.height,
  });

  factory WikipediaImage.fromJson(Map<String, dynamic> json) => WikipediaImage(
    source: json['source'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
  );

  Map<String, dynamic> toJson() => {
    'source': source,
    'width': width,
    'height': height,
  };
}
