
class MyZikr{
 String zikrName;
 int count;
 int id;
 bool isFavourite;
 String zikrType;
 String zikrBinifit;

 MyZikr({this.count = 0,this.zikrName = '',this.isFavourite = false,this.zikrType });

 Map<String, dynamic> toMap() {
  return {
   'id': id,
   'zikrName': zikrName,
   'count': count,
   'isFavourite' : isFavourite ? 'T' : 'F' ,
   'zikrType' : zikrType
  };
 }

 MyZikr.fromMap(Map<String,dynamic> map){
  id = map['id'];
  zikrName = map['zikrName'];
  count = map['count'];
  zikrType = map['zikrType'];
  isFavourite = map['isFavourite'] == 'T';
 }
}