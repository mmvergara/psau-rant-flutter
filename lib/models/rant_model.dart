class Rant {
  final String rantAuthorName;
  final String rantAuthorId;
  final String rantId;
  final String rantTitle;
  final String rantContent;
  Map<String, String> rantLikes;

  Rant({
    required this.rantAuthorName,
    required this.rantAuthorId,
    required this.rantId,
    required this.rantTitle,
    required this.rantContent,
    required this.rantLikes,
  });
}
