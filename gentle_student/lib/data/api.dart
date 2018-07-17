import 'dart:async';

import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/experience.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/adres.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdressApi{
  Future<List<Adress>> getAllAdress() async {
    return (await Firestore.instance.collection('Adress').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  Future<Adress> getAdressById(String adresId) async{
    List<Adress> adresses = await getAllAdress();
    for (var adress in adresses) {
      if(adress.adresId == adresId){
        return adress;
      }
    }
  }

  StreamSubscription watch(Adress adress, void onChange(Adress adress)) {
    return Firestore.instance
        .collection('Adress')
        .document(adress.adresId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Adress _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Adress(
      adresId: snapshot.documentID,
      street: data['street'],
      housenumber: data['housenumber'],
      city: data['city'],
      postalcode: data['postalcode']
    );
  }
}

class OpportunityApi {

  Future<List<Opportunity>> getAllOpportunities() async {
    return (await Firestore.instance.collection('Opportunities').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Opportunity opportunity, void onChange(Opportunity opportunity)) {
    return Firestore.instance
        .collection('Opportunities')
        .document(opportunity.opportunityId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Opportunity _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    Adress adres = new Adress(adresId: "", street: data['street'], postalcode: data['postalCode'], city: data['city'], housenumber: data['housenumber']);

    return new Opportunity(
      opportunityId: snapshot.documentID,
      title: data['name'],
      difficulty: _dataToDifficulty(data['difficulty']),
      category: _dataToCategory(data['category']),
      badge: new Badge(data['badgeImageUrl']),
      opportunityImageUrl: data['oppImageUrl'],
      shortDescription: data['shortDescription'],
      longDescription: data['longDescription'],
      beginDate: DateTime.parse(data['beginDate']),
      endDate: DateTime.parse(data['endDate']),
      adresId: adres.adresId,
      issuerId: data['issuerName'],
    );
  }

  Difficulty _dataToDifficulty(int difficulty) {
    switch (difficulty) {
      case 0:
        return Difficulty.BEGINNER;
      case 1:
        return Difficulty.INTERMEDIATE;
      case 2:
        return Difficulty.EXPERT;
    }
    return Difficulty.BEGINNER;
  }

  Category _dataToCategory(int category) {
    switch (category) {
      case 0:
        return Category.DUURZAAMHEID;
      case 1:
        return Category.DIGITALEGELETTERDHEID;
      case 2:
        return Category.ONDERNEMINGSZIN;
      case 3:
        return Category.ONDERZOEK;
      case 4:
        return Category.WERELDBURGERSCHAP;
    }
    return Category.DUURZAAMHEID;
  }
}

class ExperiencesApi{
  Future<List<Experience>> getAllExperiencs() async {
    return (await Firestore.instance.collection('Experiences').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Experience experience, void onChange(Experience experience)) {
    return Firestore.instance
        .collection('Experiences')
        .document(experience.experienceId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Experience _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Experience(
      experienceId: snapshot.documentID,
      content: data['content'],
      recap: data['recap'],
      date: data['date'],
      authorId: data['difficulty']
    );
  }
}