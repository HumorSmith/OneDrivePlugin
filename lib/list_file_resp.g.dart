// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_file_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFileResp _$ListFileRespFromJson(Map<String, dynamic> json) {
  return ListFileResp(
    json['@odata.context'] as String,
    json['@odata.count'] as int,
    (json['value'] as List)
        ?.map(
            (e) => e == null ? null : Value.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListFileRespToJson(ListFileResp instance) =>
    <String, dynamic>{
      '@odata.context': instance.context,
      '@odata.count': instance.count,
      'value': instance.value,
    };

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
    json['@microsoft.graph.downloadUrl'] as String,
    json['createdDateTime'] as String,
    json['cTag'] as String,
    json['eTag'] as String,
    json['id'] as String,
    json['lastModifiedDateTime'] as String,
    json['name'] as String,
    json['size'] as int,
    json['webUrl'] as String,
    json['reactions'] == null
        ? null
        : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
    json['createdBy'] == null
        ? null
        : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
    json['lastModifiedBy'] == null
        ? null
        : LastModifiedBy.fromJson(
            json['lastModifiedBy'] as Map<String, dynamic>),
    json['parentReference'] == null
        ? null
        : ParentReference.fromJson(
            json['parentReference'] as Map<String, dynamic>),
    json['file'] == null
        ? null
        : DriveFile.fromJson(json['file'] as Map<String, dynamic>),
    json['fileSystemInfo'] == null
        ? null
        : FileSystemInfo.fromJson(
            json['fileSystemInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      '@microsoft.graph.downloadUrl': instance.downloadUrl,
      'createdDateTime': instance.createdDateTime,
      'cTag': instance.cTag,
      'eTag': instance.eTag,
      'id': instance.id,
      'lastModifiedDateTime': instance.lastModifiedDateTime,
      'name': instance.name,
      'size': instance.size,
      'webUrl': instance.webUrl,
      'reactions': instance.reactions,
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'parentReference': instance.parentReference,
      'file': instance.file,
      'fileSystemInfo': instance.fileSystemInfo,
    };

Reactions _$ReactionsFromJson(Map<String, dynamic> json) {
  return Reactions(
    json['commentCount'] as int,
  );
}

Map<String, dynamic> _$ReactionsToJson(Reactions instance) => <String, dynamic>{
      'commentCount': instance.commentCount,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) {
  return CreatedBy(
    json['application'] == null
        ? null
        : Application.fromJson(json['application'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'application': instance.application,
      'user': instance.user,
    };

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return Application(
    json['displayName'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'id': instance.id,
    };

LastModifiedBy _$LastModifiedByFromJson(Map<String, dynamic> json) {
  return LastModifiedBy(
    json['application'] == null
        ? null
        : Application.fromJson(json['application'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LastModifiedByToJson(LastModifiedBy instance) =>
    <String, dynamic>{
      'application': instance.application,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['displayName'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'id': instance.id,
    };

ParentReference _$ParentReferenceFromJson(Map<String, dynamic> json) {
  return ParentReference(
    json['driveId'] as String,
    json['driveType'] as String,
    json['id'] as String,
    json['name'] as String,
    json['path'] as String,
  );
}

Map<String, dynamic> _$ParentReferenceToJson(ParentReference instance) =>
    <String, dynamic>{
      'driveId': instance.driveId,
      'driveType': instance.driveType,
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
    };

DriveFile _$FileFromJson(Map<String, dynamic> json) {
  return DriveFile(
    json['mimeType'] as String,
    json['hashes'] == null
        ? null
        : Hashes.fromJson(json['hashes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FileToJson(DriveFile instance) => <String, dynamic>{
      'mimeType': instance.mimeType,
      'hashes': instance.hashes,
    };

Hashes _$HashesFromJson(Map<String, dynamic> json) {
  return Hashes(
    json['quickXorHash'] as String,
    json['sha1Hash'] as String,
  );
}

Map<String, dynamic> _$HashesToJson(Hashes instance) => <String, dynamic>{
      'quickXorHash': instance.quickXorHash,
      'sha1Hash': instance.sha1Hash,
    };

FileSystemInfo _$FileSystemInfoFromJson(Map<String, dynamic> json) {
  return FileSystemInfo(
    json['createdDateTime'] as String,
    json['lastModifiedDateTime'] as String,
  );
}

Map<String, dynamic> _$FileSystemInfoToJson(FileSystemInfo instance) =>
    <String, dynamic>{
      'createdDateTime': instance.createdDateTime,
      'lastModifiedDateTime': instance.lastModifiedDateTime,
    };
