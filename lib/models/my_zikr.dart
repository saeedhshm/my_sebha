
class MyZikr{
 String zikrName;
 int count;
 int id;
 bool isFavourite;

 String zikrBinifit;

 MyZikr({this.count = 0,this.zikrName = '',this.isFavourite = false, });

 Map<String, dynamic> toMap() {
  return {
   'id': id,
   'zikrName': zikrName,
   'count': count,
   'isFavourite' : isFavourite ? 'T' : 'F' ,

  };
 }

 MyZikr.fromMap(Map<String,dynamic> map){
  id = map['id'];
  zikrName = map['zikrName'];
  count = map['count'];

  isFavourite = map['isFavourite'] == 'T';
 }
}