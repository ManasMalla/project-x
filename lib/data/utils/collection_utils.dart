import 'package:socialpreneur/domain/enums/collection_enum.dart';

class CollectionUtils {
  static String getCollectionPath(Collection collectionType) {
    switch (collectionType) {
      case Collection.users:
        return "users";
    }
  }
}
