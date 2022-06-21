class User {
  final String uid;
  final String displayName;
  int points;
  int played;
  User({
    required this.uid,
    required this.displayName,
    required this.points,
    required this.played,
  });
// factory User.fromJson(Map<String, dynamic> ionToJson(this);

}
