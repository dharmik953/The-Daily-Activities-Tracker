abstract class Database{

}

class FirestoreDatabase{
  final String uid;

  FirestoreDatabase({required this.uid}): assert(uid != null);
}