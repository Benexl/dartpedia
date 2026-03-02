class WikipediaPlatformContentUrls {
  final String page;
  final String revisions;
  final String edit;
  final String talk;
  WikipediaPlatformContentUrls({
    required this.page,
    required this.revisions,
    required this.edit,
    required this.talk,
  });

  factory WikipediaPlatformContentUrls.fromJson(Map<String, dynamic> json) =>
      WikipediaPlatformContentUrls(
        page: json['page'] as String,
        revisions: json['revisions'] as String,
        edit: json['edit'] as String,
        talk: json['talk'] as String,
      );

  Map<String, dynamic> toJson() => {
    'page': page,
    'revisions': revisions,
    'edit': edit,
    'talk': talk,
  };
}
