import 'dart:async';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/network/network_api.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

class OpportunityViewModel extends Model {
  Future<List<Opportunity>> _opportunities;
  Future<List<Opportunity>> get opportunities => _opportunities;
  set opportunities(Future<List<Opportunity>> value) {
    _opportunities = value;
    notifyListeners();
  }

  Future<List<Badge>> _badges;
  Future<List<Badge>> get badges => _badges;
  set badges(Future<List<Badge>> value) {
    _badges = value;
    notifyListeners();
  }

  Future<List<Issuer>> _issuers;
  Future<List<Issuer>> get issuers => _issuers;
  set issuers(Future<List<Issuer>> value) {
    _issuers = value;
    notifyListeners();
  }

  Future<List<Address>> _addresses;
  Future<List<Address>> get addresses => _addresses;
  set addresses(Future<List<Address>> value) {
    _addresses = value;
    notifyListeners();
  }

  final OpportunityApi opportunityApi;
  final BadgeApi badgeApi;
  final IssuerApi issuerApi;
  final AddressApi addressApi;

  OpportunityViewModel(
      {@required this.opportunityApi,
      @required this.badgeApi,
      @required this.issuerApi,
      @required this.addressApi});

  Future<bool> setOpportunities() async {
    opportunities = opportunityApi?.getAllOpportunities();
    return opportunities != null;
  }

  Future<bool> setBadges() async {
    badges = badgeApi?.getAllBadges();
    return badges != null;
  }

  Future<bool> setIssuers() async {
    issuers = issuerApi?.getAllIssuers();
    return issuers != null;
  }

  Future<bool> setAddresses() async {
    addresses = addressApi?.getAllAddresses();
    return addresses != null;
  }
}
