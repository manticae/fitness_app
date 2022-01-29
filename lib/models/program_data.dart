class ProgramData {
  final String uid;
  final String title;
  final String description;
  final String? image;
  final String? userId;
  final bool isPrivate;
  ProgramData({
    this.userId,
    required this.uid,
    required this.title,
    required this.description,
    required this.isPrivate,
    this.image,
  });

  @override
  String toString() {
    return '{userId: $userId, uid: $uid, title: $title, description: $description, image: $image, isPrivate: $isPrivate}';
  }
}
