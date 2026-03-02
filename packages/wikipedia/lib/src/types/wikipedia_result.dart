import 'wikipedia_content_urls.dart';
import 'wikipedia_image.dart';
import 'wikipedia_namespace.dart';
import 'wikipedia_titles.dart';

class WikipediaResult {
  final String type;
  final String title;
  final String displaytitle;
  final WikipediaNamespace namespace;
  final String wikibaseItem;
  final WikipediaTitles titles;
  final int pageid;
  final WikipediaImage? thumbnail;
  final WikipediaImage? originalimage;
  final String lang;
  final String dir;
  final String revision;
  final String tid;
  final String timestamp;
  final String? description;
  final String? descriptionSource;
  final WikipediaContentUrls contentUrls;
  final String extract;
  final String? extractHtml;

  WikipediaResult({
    required this.type,
    required this.title,
    required this.displaytitle,
    required this.namespace,
    required this.wikibaseItem,
    required this.titles,
    required this.pageid,
    this.thumbnail,
    this.originalimage,
    required this.lang,
    required this.dir,
    required this.revision,
    required this.tid,
    required this.timestamp,
    this.description,
    this.descriptionSource,
    required this.contentUrls,
    required this.extract,
    this.extractHtml,
  });

  factory WikipediaResult.fromJson(Map<String, dynamic> json) {
    return WikipediaResult(
      type: json['type'] as String,
      title: json['title'] as String,
      displaytitle: json['displaytitle'] as String,
      namespace: WikipediaNamespace.fromJson(json['namespace']),
      wikibaseItem: json['wikibase_item'] as String,
      titles: WikipediaTitles.fromJson(json['titles']),
      pageid: json['pageid'] as int,
      thumbnail: json['thumbnail'] != null
          ? WikipediaImage.fromJson(json['thumbnail'])
          : null,
      originalimage: json['originalimage'] != null
          ? WikipediaImage.fromJson(json['originalimage'])
          : null,
      lang: json['lang'] as String,
      dir: json['dir'] as String,
      revision: json['revision'] as String,
      tid: json['tid'] as String,
      timestamp: json['timestamp'] as String,
      description: json['description'],
      descriptionSource: json['description_source'],
      contentUrls: WikipediaContentUrls.fromJson(json['content_urls']),
      extract: json['extract'] as String,
      extractHtml: json['extract_html'],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'title': title,
    'displaytitle': displaytitle,
    'namespace': namespace.toJson(),
    'wikibase_item': wikibaseItem,
    'titles': titles.toJson(),
    'pageid': pageid,
    if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
    if (originalimage != null) 'originalimage': originalimage!.toJson(),
    'lang': lang,
    'dir': dir,
    'revision': revision,
    'tid': tid,
    'timestamp': timestamp,
    if (description != null) 'description': description,
    if (descriptionSource != null) 'description_source': descriptionSource,
    'content_urls': contentUrls.toJson(),
    'extract': extract,
    if (extractHtml != null) 'extract_html': extractHtml,
  };
}
