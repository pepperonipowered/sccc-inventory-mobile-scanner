// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LocalUserTable extends LocalUser
    with TableInfo<$LocalUserTable, LocalUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, token];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_user';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUserData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      token:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}token'],
          )!,
    );
  }

  @override
  $LocalUserTable createAlias(String alias) {
    return $LocalUserTable(attachedDatabase, alias);
  }
}

class LocalUserData extends DataClass implements Insertable<LocalUserData> {
  final int id;
  final String token;
  const LocalUserData({required this.id, required this.token});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['token'] = Variable<String>(token);
    return map;
  }

  LocalUserCompanion toCompanion(bool nullToAbsent) {
    return LocalUserCompanion(id: Value(id), token: Value(token));
  }

  factory LocalUserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserData(
      id: serializer.fromJson<int>(json['id']),
      token: serializer.fromJson<String>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'token': serializer.toJson<String>(token),
    };
  }

  LocalUserData copyWith({int? id, String? token}) =>
      LocalUserData(id: id ?? this.id, token: token ?? this.token);
  LocalUserData copyWithCompanion(LocalUserCompanion data) {
    return LocalUserData(
      id: data.id.present ? data.id.value : this.id,
      token: data.token.present ? data.token.value : this.token,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserData(')
          ..write('id: $id, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, token);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserData &&
          other.id == this.id &&
          other.token == this.token);
}

class LocalUserCompanion extends UpdateCompanion<LocalUserData> {
  final Value<int> id;
  final Value<String> token;
  const LocalUserCompanion({
    this.id = const Value.absent(),
    this.token = const Value.absent(),
  });
  LocalUserCompanion.insert({
    this.id = const Value.absent(),
    required String token,
  }) : token = Value(token);
  static Insertable<LocalUserData> custom({
    Expression<int>? id,
    Expression<String>? token,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (token != null) 'token': token,
    });
  }

  LocalUserCompanion copyWith({Value<int>? id, Value<String>? token}) {
    return LocalUserCompanion(id: id ?? this.id, token: token ?? this.token);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserCompanion(')
          ..write('id: $id, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }
}

class $EquipmentCopyTable extends EquipmentCopy
    with TableInfo<$EquipmentCopyTable, EquipmentCopyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentCopyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _copyNumMeta = const VerificationMeta(
    'copyNum',
  );
  @override
  late final GeneratedColumn<int> copyNum = GeneratedColumn<int>(
    'copy_num',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _equipmentIdMeta = const VerificationMeta(
    'equipmentId',
  );
  @override
  late final GeneratedColumn<int> equipmentId = GeneratedColumn<int>(
    'equipment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentNameMeta = const VerificationMeta(
    'equipmentName',
  );
  @override
  late final GeneratedColumn<String> equipmentName = GeneratedColumn<String>(
    'equipment_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentDescriptionMeta =
      const VerificationMeta('equipmentDescription');
  @override
  late final GeneratedColumn<String> equipmentDescription =
      GeneratedColumn<String>(
        'equipment_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    id,
    itemId,
    isAvailable,
    copyNum,
    createdAt,
    updatedAt,
    equipmentId,
    equipmentName,
    equipmentDescription,
    imagePath,
    categoryId,
    categoryName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment_copy';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentCopyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('copy_num')) {
      context.handle(
        _copyNumMeta,
        copyNum.isAcceptableOrUnknown(data['copy_num']!, _copyNumMeta),
      );
    } else if (isInserting) {
      context.missing(_copyNumMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
        _equipmentIdMeta,
        equipmentId.isAcceptableOrUnknown(
          data['equipment_id']!,
          _equipmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    if (data.containsKey('equipment_name')) {
      context.handle(
        _equipmentNameMeta,
        equipmentName.isAcceptableOrUnknown(
          data['equipment_name']!,
          _equipmentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentNameMeta);
    }
    if (data.containsKey('equipment_description')) {
      context.handle(
        _equipmentDescriptionMeta,
        equipmentDescription.isAcceptableOrUnknown(
          data['equipment_description']!,
          _equipmentDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  EquipmentCopyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentCopyData(
      localId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}local_id'],
          )!,
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      itemId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}item_id'],
          )!,
      isAvailable:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_available'],
          )!,
      copyNum:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}copy_num'],
          )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      equipmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}equipment_id'],
          )!,
      equipmentName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}equipment_name'],
          )!,
      equipmentDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_description'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      categoryName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category_name'],
          )!,
    );
  }

  @override
  $EquipmentCopyTable createAlias(String alias) {
    return $EquipmentCopyTable(attachedDatabase, alias);
  }
}

class EquipmentCopyData extends DataClass
    implements Insertable<EquipmentCopyData> {
  final int localId;
  final int id;
  final int itemId;
  final bool isAvailable;
  final int copyNum;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int equipmentId;
  final String equipmentName;
  final String? equipmentDescription;
  final String? imagePath;
  final int categoryId;
  final String categoryName;
  const EquipmentCopyData({
    required this.localId,
    required this.id,
    required this.itemId,
    required this.isAvailable,
    required this.copyNum,
    this.createdAt,
    this.updatedAt,
    required this.equipmentId,
    required this.equipmentName,
    this.equipmentDescription,
    this.imagePath,
    required this.categoryId,
    required this.categoryName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['is_available'] = Variable<bool>(isAvailable);
    map['copy_num'] = Variable<int>(copyNum);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['equipment_id'] = Variable<int>(equipmentId);
    map['equipment_name'] = Variable<String>(equipmentName);
    if (!nullToAbsent || equipmentDescription != null) {
      map['equipment_description'] = Variable<String>(equipmentDescription);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['category_id'] = Variable<int>(categoryId);
    map['category_name'] = Variable<String>(categoryName);
    return map;
  }

  EquipmentCopyCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCopyCompanion(
      localId: Value(localId),
      id: Value(id),
      itemId: Value(itemId),
      isAvailable: Value(isAvailable),
      copyNum: Value(copyNum),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
      updatedAt:
          updatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(updatedAt),
      equipmentId: Value(equipmentId),
      equipmentName: Value(equipmentName),
      equipmentDescription:
          equipmentDescription == null && nullToAbsent
              ? const Value.absent()
              : Value(equipmentDescription),
      imagePath:
          imagePath == null && nullToAbsent
              ? const Value.absent()
              : Value(imagePath),
      categoryId: Value(categoryId),
      categoryName: Value(categoryName),
    );
  }

  factory EquipmentCopyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentCopyData(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      copyNum: serializer.fromJson<int>(json['copyNum']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      equipmentId: serializer.fromJson<int>(json['equipmentId']),
      equipmentName: serializer.fromJson<String>(json['equipmentName']),
      equipmentDescription: serializer.fromJson<String?>(
        json['equipmentDescription'],
      ),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'copyNum': serializer.toJson<int>(copyNum),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'equipmentId': serializer.toJson<int>(equipmentId),
      'equipmentName': serializer.toJson<String>(equipmentName),
      'equipmentDescription': serializer.toJson<String?>(equipmentDescription),
      'imagePath': serializer.toJson<String?>(imagePath),
      'categoryId': serializer.toJson<int>(categoryId),
      'categoryName': serializer.toJson<String>(categoryName),
    };
  }

  EquipmentCopyData copyWith({
    int? localId,
    int? id,
    int? itemId,
    bool? isAvailable,
    int? copyNum,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    int? equipmentId,
    String? equipmentName,
    Value<String?> equipmentDescription = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    int? categoryId,
    String? categoryName,
  }) => EquipmentCopyData(
    localId: localId ?? this.localId,
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    isAvailable: isAvailable ?? this.isAvailable,
    copyNum: copyNum ?? this.copyNum,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    equipmentId: equipmentId ?? this.equipmentId,
    equipmentName: equipmentName ?? this.equipmentName,
    equipmentDescription:
        equipmentDescription.present
            ? equipmentDescription.value
            : this.equipmentDescription,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
  );
  EquipmentCopyData copyWithCompanion(EquipmentCopyCompanion data) {
    return EquipmentCopyData(
      localId: data.localId.present ? data.localId.value : this.localId,
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      isAvailable:
          data.isAvailable.present ? data.isAvailable.value : this.isAvailable,
      copyNum: data.copyNum.present ? data.copyNum.value : this.copyNum,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      equipmentId:
          data.equipmentId.present ? data.equipmentId.value : this.equipmentId,
      equipmentName:
          data.equipmentName.present
              ? data.equipmentName.value
              : this.equipmentName,
      equipmentDescription:
          data.equipmentDescription.present
              ? data.equipmentDescription.value
              : this.equipmentDescription,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      categoryName:
          data.categoryName.present
              ? data.categoryName.value
              : this.categoryName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCopyData(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('copyNum: $copyNum, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('equipmentName: $equipmentName, ')
          ..write('equipmentDescription: $equipmentDescription, ')
          ..write('imagePath: $imagePath, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    id,
    itemId,
    isAvailable,
    copyNum,
    createdAt,
    updatedAt,
    equipmentId,
    equipmentName,
    equipmentDescription,
    imagePath,
    categoryId,
    categoryName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentCopyData &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.isAvailable == this.isAvailable &&
          other.copyNum == this.copyNum &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.equipmentId == this.equipmentId &&
          other.equipmentName == this.equipmentName &&
          other.equipmentDescription == this.equipmentDescription &&
          other.imagePath == this.imagePath &&
          other.categoryId == this.categoryId &&
          other.categoryName == this.categoryName);
}

class EquipmentCopyCompanion extends UpdateCompanion<EquipmentCopyData> {
  final Value<int> localId;
  final Value<int> id;
  final Value<int> itemId;
  final Value<bool> isAvailable;
  final Value<int> copyNum;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> equipmentId;
  final Value<String> equipmentName;
  final Value<String?> equipmentDescription;
  final Value<String?> imagePath;
  final Value<int> categoryId;
  final Value<String> categoryName;
  const EquipmentCopyCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.copyNum = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.equipmentName = const Value.absent(),
    this.equipmentDescription = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
  });
  EquipmentCopyCompanion.insert({
    this.localId = const Value.absent(),
    required int id,
    required int itemId,
    this.isAvailable = const Value.absent(),
    required int copyNum,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int equipmentId,
    required String equipmentName,
    this.equipmentDescription = const Value.absent(),
    this.imagePath = const Value.absent(),
    required int categoryId,
    required String categoryName,
  }) : id = Value(id),
       itemId = Value(itemId),
       copyNum = Value(copyNum),
       equipmentId = Value(equipmentId),
       equipmentName = Value(equipmentName),
       categoryId = Value(categoryId),
       categoryName = Value(categoryName);
  static Insertable<EquipmentCopyData> custom({
    Expression<int>? localId,
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<bool>? isAvailable,
    Expression<int>? copyNum,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? equipmentId,
    Expression<String>? equipmentName,
    Expression<String>? equipmentDescription,
    Expression<String>? imagePath,
    Expression<int>? categoryId,
    Expression<String>? categoryName,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (isAvailable != null) 'is_available': isAvailable,
      if (copyNum != null) 'copy_num': copyNum,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (equipmentName != null) 'equipment_name': equipmentName,
      if (equipmentDescription != null)
        'equipment_description': equipmentDescription,
      if (imagePath != null) 'image_path': imagePath,
      if (categoryId != null) 'category_id': categoryId,
      if (categoryName != null) 'category_name': categoryName,
    });
  }

  EquipmentCopyCompanion copyWith({
    Value<int>? localId,
    Value<int>? id,
    Value<int>? itemId,
    Value<bool>? isAvailable,
    Value<int>? copyNum,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? equipmentId,
    Value<String>? equipmentName,
    Value<String?>? equipmentDescription,
    Value<String?>? imagePath,
    Value<int>? categoryId,
    Value<String>? categoryName,
  }) {
    return EquipmentCopyCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      isAvailable: isAvailable ?? this.isAvailable,
      copyNum: copyNum ?? this.copyNum,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      equipmentId: equipmentId ?? this.equipmentId,
      equipmentName: equipmentName ?? this.equipmentName,
      equipmentDescription: equipmentDescription ?? this.equipmentDescription,
      imagePath: imagePath ?? this.imagePath,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (copyNum.present) {
      map['copy_num'] = Variable<int>(copyNum.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<int>(equipmentId.value);
    }
    if (equipmentName.present) {
      map['equipment_name'] = Variable<String>(equipmentName.value);
    }
    if (equipmentDescription.present) {
      map['equipment_description'] = Variable<String>(
        equipmentDescription.value,
      );
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCopyCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('copyNum: $copyNum, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('equipmentName: $equipmentName, ')
          ..write('equipmentDescription: $equipmentDescription, ')
          ..write('imagePath: $imagePath, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }
}

class $SuppliesTable extends Supplies with TableInfo<$SuppliesTable, Supply> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplyNameMeta = const VerificationMeta(
    'supplyName',
  );
  @override
  late final GeneratedColumn<String> supplyName = GeneratedColumn<String>(
    'supply_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplyDescriptionMeta = const VerificationMeta(
    'supplyDescription',
  );
  @override
  late final GeneratedColumn<String> supplyDescription =
      GeneratedColumn<String>(
        'supply_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplyQuantityMeta = const VerificationMeta(
    'supplyQuantity',
  );
  @override
  late final GeneratedColumn<int> supplyQuantity = GeneratedColumn<int>(
    'supply_quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    id,
    supplyName,
    supplyDescription,
    serialNumber,
    supplyQuantity,
    imagePath,
    createdAt,
    updatedAt,
    categoryId,
    categoryName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supply> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supply_name')) {
      context.handle(
        _supplyNameMeta,
        supplyName.isAcceptableOrUnknown(data['supply_name']!, _supplyNameMeta),
      );
    }
    if (data.containsKey('supply_description')) {
      context.handle(
        _supplyDescriptionMeta,
        supplyDescription.isAcceptableOrUnknown(
          data['supply_description']!,
          _supplyDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('supply_quantity')) {
      context.handle(
        _supplyQuantityMeta,
        supplyQuantity.isAcceptableOrUnknown(
          data['supply_quantity']!,
          _supplyQuantityMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Supply map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supply(
      localId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}local_id'],
          )!,
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      supplyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supply_name'],
      ),
      supplyDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supply_description'],
      ),
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      ),
      supplyQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supply_quantity'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      ),
    );
  }

  @override
  $SuppliesTable createAlias(String alias) {
    return $SuppliesTable(attachedDatabase, alias);
  }
}

class Supply extends DataClass implements Insertable<Supply> {
  final int localId;
  final int id;
  final String? supplyName;
  final String? supplyDescription;
  final String? serialNumber;
  final int? supplyQuantity;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? categoryId;
  final String? categoryName;
  const Supply({
    required this.localId,
    required this.id,
    this.supplyName,
    this.supplyDescription,
    this.serialNumber,
    this.supplyQuantity,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.categoryName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || supplyName != null) {
      map['supply_name'] = Variable<String>(supplyName);
    }
    if (!nullToAbsent || supplyDescription != null) {
      map['supply_description'] = Variable<String>(supplyDescription);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || supplyQuantity != null) {
      map['supply_quantity'] = Variable<int>(supplyQuantity);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    return map;
  }

  SuppliesCompanion toCompanion(bool nullToAbsent) {
    return SuppliesCompanion(
      localId: Value(localId),
      id: Value(id),
      supplyName:
          supplyName == null && nullToAbsent
              ? const Value.absent()
              : Value(supplyName),
      supplyDescription:
          supplyDescription == null && nullToAbsent
              ? const Value.absent()
              : Value(supplyDescription),
      serialNumber:
          serialNumber == null && nullToAbsent
              ? const Value.absent()
              : Value(serialNumber),
      supplyQuantity:
          supplyQuantity == null && nullToAbsent
              ? const Value.absent()
              : Value(supplyQuantity),
      imagePath:
          imagePath == null && nullToAbsent
              ? const Value.absent()
              : Value(imagePath),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
      updatedAt:
          updatedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(updatedAt),
      categoryId:
          categoryId == null && nullToAbsent
              ? const Value.absent()
              : Value(categoryId),
      categoryName:
          categoryName == null && nullToAbsent
              ? const Value.absent()
              : Value(categoryName),
    );
  }

  factory Supply.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supply(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<int>(json['id']),
      supplyName: serializer.fromJson<String?>(json['supplyName']),
      supplyDescription: serializer.fromJson<String?>(
        json['supplyDescription'],
      ),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      supplyQuantity: serializer.fromJson<int?>(json['supplyQuantity']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      categoryName: serializer.fromJson<String?>(json['categoryName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<int>(id),
      'supplyName': serializer.toJson<String?>(supplyName),
      'supplyDescription': serializer.toJson<String?>(supplyDescription),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'supplyQuantity': serializer.toJson<int?>(supplyQuantity),
      'imagePath': serializer.toJson<String?>(imagePath),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'categoryId': serializer.toJson<int?>(categoryId),
      'categoryName': serializer.toJson<String?>(categoryName),
    };
  }

  Supply copyWith({
    int? localId,
    int? id,
    Value<String?> supplyName = const Value.absent(),
    Value<String?> supplyDescription = const Value.absent(),
    Value<String?> serialNumber = const Value.absent(),
    Value<int?> supplyQuantity = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<String?> categoryName = const Value.absent(),
  }) => Supply(
    localId: localId ?? this.localId,
    id: id ?? this.id,
    supplyName: supplyName.present ? supplyName.value : this.supplyName,
    supplyDescription:
        supplyDescription.present
            ? supplyDescription.value
            : this.supplyDescription,
    serialNumber: serialNumber.present ? serialNumber.value : this.serialNumber,
    supplyQuantity:
        supplyQuantity.present ? supplyQuantity.value : this.supplyQuantity,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    categoryName: categoryName.present ? categoryName.value : this.categoryName,
  );
  Supply copyWithCompanion(SuppliesCompanion data) {
    return Supply(
      localId: data.localId.present ? data.localId.value : this.localId,
      id: data.id.present ? data.id.value : this.id,
      supplyName:
          data.supplyName.present ? data.supplyName.value : this.supplyName,
      supplyDescription:
          data.supplyDescription.present
              ? data.supplyDescription.value
              : this.supplyDescription,
      serialNumber:
          data.serialNumber.present
              ? data.serialNumber.value
              : this.serialNumber,
      supplyQuantity:
          data.supplyQuantity.present
              ? data.supplyQuantity.value
              : this.supplyQuantity,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      categoryName:
          data.categoryName.present
              ? data.categoryName.value
              : this.categoryName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supply(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('supplyName: $supplyName, ')
          ..write('supplyDescription: $supplyDescription, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('supplyQuantity: $supplyQuantity, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    id,
    supplyName,
    supplyDescription,
    serialNumber,
    supplyQuantity,
    imagePath,
    createdAt,
    updatedAt,
    categoryId,
    categoryName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supply &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.supplyName == this.supplyName &&
          other.supplyDescription == this.supplyDescription &&
          other.serialNumber == this.serialNumber &&
          other.supplyQuantity == this.supplyQuantity &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.categoryId == this.categoryId &&
          other.categoryName == this.categoryName);
}

class SuppliesCompanion extends UpdateCompanion<Supply> {
  final Value<int> localId;
  final Value<int> id;
  final Value<String?> supplyName;
  final Value<String?> supplyDescription;
  final Value<String?> serialNumber;
  final Value<int?> supplyQuantity;
  final Value<String?> imagePath;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int?> categoryId;
  final Value<String?> categoryName;
  const SuppliesCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.supplyName = const Value.absent(),
    this.supplyDescription = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.supplyQuantity = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
  });
  SuppliesCompanion.insert({
    this.localId = const Value.absent(),
    required int id,
    this.supplyName = const Value.absent(),
    this.supplyDescription = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.supplyQuantity = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Supply> custom({
    Expression<int>? localId,
    Expression<int>? id,
    Expression<String>? supplyName,
    Expression<String>? supplyDescription,
    Expression<String>? serialNumber,
    Expression<int>? supplyQuantity,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? categoryId,
    Expression<String>? categoryName,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (supplyName != null) 'supply_name': supplyName,
      if (supplyDescription != null) 'supply_description': supplyDescription,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (supplyQuantity != null) 'supply_quantity': supplyQuantity,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (categoryId != null) 'category_id': categoryId,
      if (categoryName != null) 'category_name': categoryName,
    });
  }

  SuppliesCompanion copyWith({
    Value<int>? localId,
    Value<int>? id,
    Value<String?>? supplyName,
    Value<String?>? supplyDescription,
    Value<String?>? serialNumber,
    Value<int?>? supplyQuantity,
    Value<String?>? imagePath,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int?>? categoryId,
    Value<String?>? categoryName,
  }) {
    return SuppliesCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      supplyName: supplyName ?? this.supplyName,
      supplyDescription: supplyDescription ?? this.supplyDescription,
      serialNumber: serialNumber ?? this.serialNumber,
      supplyQuantity: supplyQuantity ?? this.supplyQuantity,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplyName.present) {
      map['supply_name'] = Variable<String>(supplyName.value);
    }
    if (supplyDescription.present) {
      map['supply_description'] = Variable<String>(supplyDescription.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (supplyQuantity.present) {
      map['supply_quantity'] = Variable<int>(supplyQuantity.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliesCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('supplyName: $supplyName, ')
          ..write('supplyDescription: $supplyDescription, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('supplyQuantity: $supplyQuantity, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalUserTable localUser = $LocalUserTable(this);
  late final $EquipmentCopyTable equipmentCopy = $EquipmentCopyTable(this);
  late final $SuppliesTable supplies = $SuppliesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localUser,
    equipmentCopy,
    supplies,
  ];
}

typedef $$LocalUserTableCreateCompanionBuilder =
    LocalUserCompanion Function({Value<int> id, required String token});
typedef $$LocalUserTableUpdateCompanionBuilder =
    LocalUserCompanion Function({Value<int> id, Value<String> token});

class $$LocalUserTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUserTable> {
  $$LocalUserTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalUserTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUserTable> {
  $$LocalUserTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUserTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUserTable> {
  $$LocalUserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);
}

class $$LocalUserTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUserTable,
          LocalUserData,
          $$LocalUserTableFilterComposer,
          $$LocalUserTableOrderingComposer,
          $$LocalUserTableAnnotationComposer,
          $$LocalUserTableCreateCompanionBuilder,
          $$LocalUserTableUpdateCompanionBuilder,
          (
            LocalUserData,
            BaseReferences<_$AppDatabase, $LocalUserTable, LocalUserData>,
          ),
          LocalUserData,
          PrefetchHooks Function()
        > {
  $$LocalUserTableTableManager(_$AppDatabase db, $LocalUserTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LocalUserTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LocalUserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LocalUserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> token = const Value.absent(),
              }) => LocalUserCompanion(id: id, token: token),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String token}) =>
                  LocalUserCompanion.insert(id: id, token: token),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalUserTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUserTable,
      LocalUserData,
      $$LocalUserTableFilterComposer,
      $$LocalUserTableOrderingComposer,
      $$LocalUserTableAnnotationComposer,
      $$LocalUserTableCreateCompanionBuilder,
      $$LocalUserTableUpdateCompanionBuilder,
      (
        LocalUserData,
        BaseReferences<_$AppDatabase, $LocalUserTable, LocalUserData>,
      ),
      LocalUserData,
      PrefetchHooks Function()
    >;
typedef $$EquipmentCopyTableCreateCompanionBuilder =
    EquipmentCopyCompanion Function({
      Value<int> localId,
      required int id,
      required int itemId,
      Value<bool> isAvailable,
      required int copyNum,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      required int equipmentId,
      required String equipmentName,
      Value<String?> equipmentDescription,
      Value<String?> imagePath,
      required int categoryId,
      required String categoryName,
    });
typedef $$EquipmentCopyTableUpdateCompanionBuilder =
    EquipmentCopyCompanion Function({
      Value<int> localId,
      Value<int> id,
      Value<int> itemId,
      Value<bool> isAvailable,
      Value<int> copyNum,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> equipmentId,
      Value<String> equipmentName,
      Value<String?> equipmentDescription,
      Value<String?> imagePath,
      Value<int> categoryId,
      Value<String> categoryName,
    });

class $$EquipmentCopyTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentCopyTable> {
  $$EquipmentCopyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get copyNum => $composableBuilder(
    column: $table.copyNum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentName => $composableBuilder(
    column: $table.equipmentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentDescription => $composableBuilder(
    column: $table.equipmentDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EquipmentCopyTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentCopyTable> {
  $$EquipmentCopyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get copyNum => $composableBuilder(
    column: $table.copyNum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentName => $composableBuilder(
    column: $table.equipmentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentDescription => $composableBuilder(
    column: $table.equipmentDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentCopyTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentCopyTable> {
  $$EquipmentCopyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get copyNum =>
      $composableBuilder(column: $table.copyNum, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipmentName => $composableBuilder(
    column: $table.equipmentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipmentDescription => $composableBuilder(
    column: $table.equipmentDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );
}

class $$EquipmentCopyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipmentCopyTable,
          EquipmentCopyData,
          $$EquipmentCopyTableFilterComposer,
          $$EquipmentCopyTableOrderingComposer,
          $$EquipmentCopyTableAnnotationComposer,
          $$EquipmentCopyTableCreateCompanionBuilder,
          $$EquipmentCopyTableUpdateCompanionBuilder,
          (
            EquipmentCopyData,
            BaseReferences<
              _$AppDatabase,
              $EquipmentCopyTable,
              EquipmentCopyData
            >,
          ),
          EquipmentCopyData,
          PrefetchHooks Function()
        > {
  $$EquipmentCopyTableTableManager(_$AppDatabase db, $EquipmentCopyTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EquipmentCopyTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$EquipmentCopyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EquipmentCopyTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
                Value<int> copyNum = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> equipmentId = const Value.absent(),
                Value<String> equipmentName = const Value.absent(),
                Value<String?> equipmentDescription = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> categoryName = const Value.absent(),
              }) => EquipmentCopyCompanion(
                localId: localId,
                id: id,
                itemId: itemId,
                isAvailable: isAvailable,
                copyNum: copyNum,
                createdAt: createdAt,
                updatedAt: updatedAt,
                equipmentId: equipmentId,
                equipmentName: equipmentName,
                equipmentDescription: equipmentDescription,
                imagePath: imagePath,
                categoryId: categoryId,
                categoryName: categoryName,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int id,
                required int itemId,
                Value<bool> isAvailable = const Value.absent(),
                required int copyNum,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                required int equipmentId,
                required String equipmentName,
                Value<String?> equipmentDescription = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                required int categoryId,
                required String categoryName,
              }) => EquipmentCopyCompanion.insert(
                localId: localId,
                id: id,
                itemId: itemId,
                isAvailable: isAvailable,
                copyNum: copyNum,
                createdAt: createdAt,
                updatedAt: updatedAt,
                equipmentId: equipmentId,
                equipmentName: equipmentName,
                equipmentDescription: equipmentDescription,
                imagePath: imagePath,
                categoryId: categoryId,
                categoryName: categoryName,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EquipmentCopyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipmentCopyTable,
      EquipmentCopyData,
      $$EquipmentCopyTableFilterComposer,
      $$EquipmentCopyTableOrderingComposer,
      $$EquipmentCopyTableAnnotationComposer,
      $$EquipmentCopyTableCreateCompanionBuilder,
      $$EquipmentCopyTableUpdateCompanionBuilder,
      (
        EquipmentCopyData,
        BaseReferences<_$AppDatabase, $EquipmentCopyTable, EquipmentCopyData>,
      ),
      EquipmentCopyData,
      PrefetchHooks Function()
    >;
typedef $$SuppliesTableCreateCompanionBuilder =
    SuppliesCompanion Function({
      Value<int> localId,
      required int id,
      Value<String?> supplyName,
      Value<String?> supplyDescription,
      Value<String?> serialNumber,
      Value<int?> supplyQuantity,
      Value<String?> imagePath,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int?> categoryId,
      Value<String?> categoryName,
    });
typedef $$SuppliesTableUpdateCompanionBuilder =
    SuppliesCompanion Function({
      Value<int> localId,
      Value<int> id,
      Value<String?> supplyName,
      Value<String?> supplyDescription,
      Value<String?> serialNumber,
      Value<int?> supplyQuantity,
      Value<String?> imagePath,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int?> categoryId,
      Value<String?> categoryName,
    });

class $$SuppliesTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliesTable> {
  $$SuppliesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplyName => $composableBuilder(
    column: $table.supplyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplyDescription => $composableBuilder(
    column: $table.supplyDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get supplyQuantity => $composableBuilder(
    column: $table.supplyQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliesTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliesTable> {
  $$SuppliesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplyName => $composableBuilder(
    column: $table.supplyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplyDescription => $composableBuilder(
    column: $table.supplyDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get supplyQuantity => $composableBuilder(
    column: $table.supplyQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliesTable> {
  $$SuppliesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get supplyName => $composableBuilder(
    column: $table.supplyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplyDescription => $composableBuilder(
    column: $table.supplyDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get supplyQuantity => $composableBuilder(
    column: $table.supplyQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );
}

class $$SuppliesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliesTable,
          Supply,
          $$SuppliesTableFilterComposer,
          $$SuppliesTableOrderingComposer,
          $$SuppliesTableAnnotationComposer,
          $$SuppliesTableCreateCompanionBuilder,
          $$SuppliesTableUpdateCompanionBuilder,
          (Supply, BaseReferences<_$AppDatabase, $SuppliesTable, Supply>),
          Supply,
          PrefetchHooks Function()
        > {
  $$SuppliesTableTableManager(_$AppDatabase db, $SuppliesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SuppliesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SuppliesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SuppliesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String?> supplyName = const Value.absent(),
                Value<String?> supplyDescription = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<int?> supplyQuantity = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
              }) => SuppliesCompanion(
                localId: localId,
                id: id,
                supplyName: supplyName,
                supplyDescription: supplyDescription,
                serialNumber: serialNumber,
                supplyQuantity: supplyQuantity,
                imagePath: imagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                categoryId: categoryId,
                categoryName: categoryName,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int id,
                Value<String?> supplyName = const Value.absent(),
                Value<String?> supplyDescription = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<int?> supplyQuantity = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
              }) => SuppliesCompanion.insert(
                localId: localId,
                id: id,
                supplyName: supplyName,
                supplyDescription: supplyDescription,
                serialNumber: serialNumber,
                supplyQuantity: supplyQuantity,
                imagePath: imagePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                categoryId: categoryId,
                categoryName: categoryName,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliesTable,
      Supply,
      $$SuppliesTableFilterComposer,
      $$SuppliesTableOrderingComposer,
      $$SuppliesTableAnnotationComposer,
      $$SuppliesTableCreateCompanionBuilder,
      $$SuppliesTableUpdateCompanionBuilder,
      (Supply, BaseReferences<_$AppDatabase, $SuppliesTable, Supply>),
      Supply,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUserTableTableManager get localUser =>
      $$LocalUserTableTableManager(_db, _db.localUser);
  $$EquipmentCopyTableTableManager get equipmentCopy =>
      $$EquipmentCopyTableTableManager(_db, _db.equipmentCopy);
  $$SuppliesTableTableManager get supplies =>
      $$SuppliesTableTableManager(_db, _db.supplies);
}
