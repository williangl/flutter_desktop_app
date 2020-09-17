class DecryptResponse {
  final String name;
  final String ext;
  final dynamic content;

  DecryptResponse({this.name, this.ext, this.content});

  factory DecryptResponse.fromJson(Map<String, dynamic> json) {
    return DecryptResponse(
      name: json['name'],
      ext: json['extension'],
      content: json['content'],
    );
  }
}
