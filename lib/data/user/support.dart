import 'dart:convert';

class Support {
  final String url;
  final String text;
  Support({
    this.url = '',
    this.text = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'text': text,
    };
  }

  factory Support.fromMap(Map<String, dynamic> map) {
    return Support(
      url: map['url'] ?? '',
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Support.fromJson(String source) => Support.fromMap(json.decode(source));
}