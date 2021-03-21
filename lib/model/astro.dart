/* Model Class for API request */
class Astrology {
  final String date;
  final String explanation;
  final String url;
  String title;
  final String hdUrl;

  Astrology({this.date, this.explanation, this.url, this.title, this.hdUrl});
  factory Astrology.fromMap(Map<String, dynamic> json) {
    return Astrology(
      date: json['date'],
      explanation: json['explanation'],
      url: json['url'],
      title: json['title'],
      hdUrl: json['hdurl'],
    );
  }
}
