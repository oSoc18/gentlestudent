class Badge {
  String _id;
  String _type;
  String _name;
  String _description;
  String _image;
  String _criteria;
  String _issuer;
  List<dynamic> _alignment;
  List<dynamic> _tags;

  Badge(this._id, this._type, this._name, this._description, this._image, this._criteria, this._issuer, this._alignment, this._tags);

  Badge.map(dynamic obj) {
    this._id = obj["id"];
    this._type = obj["type"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._image = obj["image"];
    this._criteria = obj["criteria"];
    this._issuer = obj["issuer"];
    this._alignment = obj["alignment"];
    this._tags = obj["tags"];
  }

  String get id => _id;
  String get type => _type;
  String get name => _name;
  String get description => _description;
  String get image => _image;
  String get criteria => _criteria;
  String get issuer => _issuer;
  List<dynamic> get alignment => _alignment;
  List<dynamic> get tags => _tags;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["image"] = _image;
    map["criteria"] = _criteria;
    map["issuer"] = _issuer;
    map["alignment"] = _alignment;
    map["tags"] = _tags;

    return map;
  }
}