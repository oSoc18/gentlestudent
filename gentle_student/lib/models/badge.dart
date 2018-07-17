import 'package:meta/meta.dart';

//This model represents a badge as defined by the badgr API
class Badge {
  
  //Declaration of the variables
  final String entityType;
  final String entityId;
  final String openBadgeId;
  final String createdAt;
  final String createdBy;
  final String issuer;
  final String issuerOpenBadgeId;
  final String name;
  final String image;
  final String description;
  final String criteriaUrl;
  final String criteriaNarrative;
  final List alignments;
  final List tags;
  final String extensions;
  //Extra variables for Gentlestudent
  final String opportunityId;

  Badge({
    @required this.entityType,
    @required this.entityId,
    @required this.openBadgeId,
    @required this.createdAt,
    @required this.createdBy,
    @required this.issuer,
    @required this.issuerOpenBadgeId,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.criteriaUrl,
    @required this.criteriaNarrative,
    @required this.alignments,
    @required this.tags,
    @required this.extensions,
    @required this.opportunityId
  });
  
}