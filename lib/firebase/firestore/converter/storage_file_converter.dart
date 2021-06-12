import 'package:json_annotation/json_annotation.dart';

import '../storage_file/firebase_storage_file.dart';

class StorageFileConverter
    implements JsonConverter<StorageFile, Map<String, dynamic>> {
  @override
  StorageFile fromJson(Map<String, dynamic> json) => StorageFile.fromJson(json);

  @override
  Map<String, dynamic> toJson(StorageFile object) => object.toJson();
}
