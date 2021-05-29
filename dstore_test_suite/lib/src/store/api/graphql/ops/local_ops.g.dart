// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_ops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalOps_pingData _$LocalOps_pingDataFromJson(Map<String, dynamic> json) =>
    LocalOps_pingData(
      ping: json['ping'] as String?,
    );

Map<String, dynamic> _$LocalOps_pingDataToJson(LocalOps_pingData instance) =>
    <String, dynamic>{
      'ping': instance.ping,
    };

LocalOps_usersData _$LocalOps_usersDataFromJson(Map<String, dynamic> json) =>
    LocalOps_usersData(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : LocalOps_usersData_users.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalOps_usersDataToJson(LocalOps_usersData instance) =>
    <String, dynamic>{
      'users': instance.users?.map((e) => e?.toJson()).toList(),
    };

LocalOps_usersData_users _$LocalOps_usersData_usersFromJson(
        Map<String, dynamic> json) =>
    LocalOps_usersData_users(
      name: json['name'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      hello: LocalOps_usersData_users_hello.fromJson(
          json['hello'] as Map<String, dynamic>?),
      helloa: LocalOps_usersData_users_helloaListDeserializer(json['helloa']),
      address: json['address'] == null
          ? null
          : LocalOps_usersData_users_address.fromJson(
              json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalOps_usersData_usersToJson(
        LocalOps_usersData_users instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tags': instance.tags,
      'hello': LocalOps_usersData_users_hello.toJson(instance.hello),
      'helloa': LocalOps_usersData_users_helloaListSerializer(instance.helloa),
      'address': instance.address?.toJson(),
    };

LocalOps_usersData_users_hello_Hello1
    _$LocalOps_usersData_users_hello_Hello1FromJson(
            Map<String, dynamic> json) =>
        LocalOps_usersData_users_hello_Hello1(
          name: json['name'] as String?,
          one: json['one'] as String,
          d$___typeName: json['__typename'] as String,
        );

Map<String, dynamic> _$LocalOps_usersData_users_hello_Hello1ToJson(
        LocalOps_usersData_users_hello_Hello1 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'one': instance.one,
      '__typename': instance.d$___typeName,
    };

LocalOps_usersData_users_hello_Hello2
    _$LocalOps_usersData_users_hello_Hello2FromJson(
            Map<String, dynamic> json) =>
        LocalOps_usersData_users_hello_Hello2(
          name: json['name'] as String?,
          two: json['two'] as String,
          d$___typeName: json['__typename'] as String,
        );

Map<String, dynamic> _$LocalOps_usersData_users_hello_Hello2ToJson(
        LocalOps_usersData_users_hello_Hello2 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'two': instance.two,
      '__typename': instance.d$___typeName,
    };

LocalOps_usersData_users_helloa_Hello1
    _$LocalOps_usersData_users_helloa_Hello1FromJson(
            Map<String, dynamic> json) =>
        LocalOps_usersData_users_helloa_Hello1(
          name: json['name'] as String?,
          one: json['one'] as String,
          d$___typeName: json['__typename'] as String,
        );

Map<String, dynamic> _$LocalOps_usersData_users_helloa_Hello1ToJson(
        LocalOps_usersData_users_helloa_Hello1 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'one': instance.one,
      '__typename': instance.d$___typeName,
    };

LocalOps_usersData_users_helloa_Hello2
    _$LocalOps_usersData_users_helloa_Hello2FromJson(
            Map<String, dynamic> json) =>
        LocalOps_usersData_users_helloa_Hello2(
          name: json['name'] as String?,
          two: json['two'] as String,
          d$___typeName: json['__typename'] as String,
        );

Map<String, dynamic> _$LocalOps_usersData_users_helloa_Hello2ToJson(
        LocalOps_usersData_users_helloa_Hello2 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'two': instance.two,
      '__typename': instance.d$___typeName,
    };

LocalOps_usersData_users_address _$LocalOps_usersData_users_addressFromJson(
        Map<String, dynamic> json) =>
    LocalOps_usersData_users_address(
      street: json['street'] as String,
      zip: json['zip'] as String,
      country: LocalOps_usersData_users_address_country.fromJson(
          json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalOps_usersData_users_addressToJson(
        LocalOps_usersData_users_address instance) =>
    <String, dynamic>{
      'street': instance.street,
      'zip': instance.zip,
      'country': instance.country.toJson(),
    };

LocalOps_usersData_users_address_country
    _$LocalOps_usersData_users_address_countryFromJson(
            Map<String, dynamic> json) =>
        LocalOps_usersData_users_address_country(
          code: json['code'] as String,
          name: json['name'] as String,
        );

Map<String, dynamic> _$LocalOps_usersData_users_address_countryToJson(
        LocalOps_usersData_users_address_country instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
