class DecryptResponse {
  final String name;
  final String extension;
  final dynamic content;

  DecryptResponse({this.name, this.extension, this.content});

  factory DecryptResponse.fromJson(Map<String, dynamic> json) {
    return DecryptResponse(
      name: json['name'],
      extension: json['extension'],
      content: json['content'],
    );
  }
}
