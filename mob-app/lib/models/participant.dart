import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Participant fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    List<dynamic> listDynamic = data['favorites'];
    List<String> listStrings = new List();
    listDynamic.forEach((d) => listStrings.add(d));

    return new Participant(
        participantId: snapshot.documentID,
        name: data['name'],
        institute: data['institute'],
        email: data['email'],
        profilePicture: data['profilePicture'],
        favorites: listStrings);
  }
}
