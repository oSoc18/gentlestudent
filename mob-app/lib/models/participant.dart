class Participant {
  final String participantId;
  final String email;
  final String name;
  final String institute;
  final String profilePicture;
  final List<String> favorites;

  Participant({
    this.participantId,
    this.institute,
    this.email,
    this.name,
    this.profilePicture,
    this.favorites,
  });
}
