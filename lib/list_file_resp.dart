import 'package:json_annotation/json_annotation.dart'; 
  
part 'list_file_resp.g.dart';

//flutter packages pub run build_runner build
@JsonSerializable()
class ListFileResp extends Object {

  @JsonKey(name: '@odata.context')
  String context;

  @JsonKey(name: '@odata.count')
  int count;

  @JsonKey(name: 'value')
  List<Value> value;

  ListFileResp(this.context,this.count,this.value,);

  factory ListFileResp.fromJson(Map<String, dynamic> srcJson) => _$ListFileRespFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListFileRespToJson(this);

}

  
@JsonSerializable()
  class Value extends Object {

  @JsonKey(name: '@microsoft.graph.downloadUrl')
  String downloadUrl;

  @JsonKey(name: 'createdDateTime')
  String createdDateTime;

  @JsonKey(name: 'cTag')
  String cTag;

  @JsonKey(name: 'eTag')
  String eTag;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'lastModifiedDateTime')
  String lastModifiedDateTime;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'webUrl')
  String webUrl;

  @JsonKey(name: 'reactions')
  Reactions reactions;

  @JsonKey(name: 'createdBy')
  CreatedBy createdBy;

  @JsonKey(name: 'lastModifiedBy')
  LastModifiedBy lastModifiedBy;

  @JsonKey(name: 'parentReference')
  ParentReference parentReference;

  @JsonKey(name: 'file')
  File file;

  @JsonKey(name: 'fileSystemInfo')
  FileSystemInfo fileSystemInfo;

  Value(this.downloadUrl,this.createdDateTime,this.cTag,this.eTag,this.id,this.lastModifiedDateTime,this.name,this.size,this.webUrl,this.reactions,this.createdBy,this.lastModifiedBy,this.parentReference,this.file,this.fileSystemInfo,);

  factory Value.fromJson(Map<String, dynamic> srcJson) => _$ValueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

}

  
@JsonSerializable()
  class Reactions extends Object {

  @JsonKey(name: 'commentCount')
  int commentCount;

  Reactions(this.commentCount,);

  factory Reactions.fromJson(Map<String, dynamic> srcJson) => _$ReactionsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReactionsToJson(this);

}

  
@JsonSerializable()
  class CreatedBy extends Object {

  @JsonKey(name: 'application')
  Application application;

  @JsonKey(name: 'user')
  User user;

  CreatedBy(this.application,this.user,);

  factory CreatedBy.fromJson(Map<String, dynamic> srcJson) => _$CreatedByFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

}

  
@JsonSerializable()
  class Application extends Object {

  @JsonKey(name: 'displayName')
  String displayName;

  @JsonKey(name: 'id')
  String id;

  Application(this.displayName,this.id,);

  factory Application.fromJson(Map<String, dynamic> srcJson) => _$ApplicationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ApplicationToJson(this);

}


  
@JsonSerializable()
  class LastModifiedBy extends Object {

  @JsonKey(name: 'application')
  Application application;

  @JsonKey(name: 'user')
  User user;

  LastModifiedBy(this.application,this.user,);

  factory LastModifiedBy.fromJson(Map<String, dynamic> srcJson) => _$LastModifiedByFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LastModifiedByToJson(this);

}

  

  
@JsonSerializable()
  class User extends Object {

  @JsonKey(name: 'displayName')
  String displayName;

  @JsonKey(name: 'id')
  String id;

  User(this.displayName,this.id,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

  
@JsonSerializable()
  class ParentReference extends Object {

  @JsonKey(name: 'driveId')
  String driveId;

  @JsonKey(name: 'driveType')
  String driveType;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'path')
  String path;

  ParentReference(this.driveId,this.driveType,this.id,this.name,this.path,);

  factory ParentReference.fromJson(Map<String, dynamic> srcJson) => _$ParentReferenceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParentReferenceToJson(this);

}

  
@JsonSerializable()
  class File extends Object {

  @JsonKey(name: 'mimeType')
  String mimeType;

  @JsonKey(name: 'hashes')
  Hashes hashes;

  File(this.mimeType,this.hashes,);

  factory File.fromJson(Map<String, dynamic> srcJson) => _$FileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FileToJson(this);

}

  
@JsonSerializable()
  class Hashes extends Object {

  @JsonKey(name: 'quickXorHash')
  String quickXorHash;

  @JsonKey(name: 'sha1Hash')
  String sha1Hash;

  Hashes(this.quickXorHash,this.sha1Hash,);

  factory Hashes.fromJson(Map<String, dynamic> srcJson) => _$HashesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HashesToJson(this);

}

  
@JsonSerializable()
  class FileSystemInfo extends Object {

  @JsonKey(name: 'createdDateTime')
  String createdDateTime;

  @JsonKey(name: 'lastModifiedDateTime')
  String lastModifiedDateTime;

  FileSystemInfo(this.createdDateTime,this.lastModifiedDateTime,);

  factory FileSystemInfo.fromJson(Map<String, dynamic> srcJson) => _$FileSystemInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FileSystemInfoToJson(this);

}

  
