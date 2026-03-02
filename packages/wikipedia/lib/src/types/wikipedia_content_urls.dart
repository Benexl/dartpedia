import 'wikipedia_platform_content_urls.dart';

class WikipediaContentUrls {
  final WikipediaPlatformContentUrls desktop;
  final WikipediaPlatformContentUrls mobile;
  WikipediaContentUrls({required this.desktop, required this.mobile});

  factory WikipediaContentUrls.fromJson(Map<String, dynamic> json) =>
      WikipediaContentUrls(
        desktop: WikipediaPlatformContentUrls.fromJson(json['desktop']),
        mobile: WikipediaPlatformContentUrls.fromJson(json['mobile']),
      );

  Map<String, dynamic> toJson() => {
    'desktop': desktop.toJson(),
    'mobile': mobile.toJson(),
  };
}
