
class Zikr{
 String zikrName;
 int count;
 int id;
 bool isFavourite;
 String zikrType;

 Zikr({this.count,this.zikrName,this.isFavourite = false,this.zikrType});

 Map<String, dynamic> toMap() {
  return {
//   'id': id,
   'zikrName': zikrName,
   'count': count,
   'isFavourite' : isFavourite ? 'T' : 'F' ,
   'zikrType' : zikrType
  };
 }

 Zikr.fromMap(Map<String,dynamic> map){
  id = map['id'];
  zikrName = map['zikrName'];
  count = map['count'];
  zikrType = map['zikrType'];
  isFavourite = map['isFavourite'] == 'T';
 }
}