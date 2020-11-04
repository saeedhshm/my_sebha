class Zikr {
  String _category;
  int _count;
  String _description;
  String _reference;
  String _zekr;

  Zikr(
      {String category,
        int count,
        String description,
        String reference,
        String zekr}) {
    this._category = category;
    this._count = count;
    this._description = description;
    this._reference = reference;
    this._zekr = zekr;
  }

  String get category => _category;
//  set category(String category) => _category = category;
  int get count {
    // if(int.tryParse(_count) != null)
    //   return int.tryParse(_count);
    return _count ;
  }
 set count(int count) => _count = count;
  String get description => _description;
//  set description(String description) => _description = description;
  String get reference => _reference;
//  set reference(String reference) => _reference = reference;
  String get zekr => _zekr;
//  set zekr(String zekr) => _zekr = zekr;

  Zikr.fromJson(Map<String, dynamic> json) {

    _category = json['category'];
    _count = int.tryParse(json['count']) ?? 1;
    _description = json['description'];
    _reference = json['reference'];
    _zekr = json['zekr'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['category'] = this._category;
//    data['count'] = this._count;
//    data['description'] = this._description;
//    data['reference'] = this._reference;
//    data['zekr'] = this._zekr;
//    return data;
//  }
}
