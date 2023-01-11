// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetSettingsModelCollection on Isar {
  IsarCollection<SettingsModel> get settingsModels => this.collection();
}

const SettingsModelSchema = CollectionSchema(
  name: r'SettingsModel',
  id: 4013777327486952906,
  properties: {
    r'introComplete': PropertySchema(
      id: 0,
      name: r'introComplete',
      type: IsarType.bool,
    ),
    r'userInformationComplete': PropertySchema(
      id: 1,
      name: r'userInformationComplete',
      type: IsarType.bool,
    )
  },
  estimateSize: _settingsModelEstimateSize,
  serialize: _settingsModelSerialize,
  deserialize: _settingsModelDeserialize,
  deserializeProp: _settingsModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingsModelGetId,
  getLinks: _settingsModelGetLinks,
  attach: _settingsModelAttach,
  version: '3.0.5',
);

int _settingsModelEstimateSize(
  SettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _settingsModelSerialize(
  SettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.introComplete);
  writer.writeBool(offsets[1], object.userInformationComplete);
}

SettingsModel _settingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SettingsModel(
    reader.readBoolOrNull(offsets[0]),
    reader.readBoolOrNull(offsets[1]),
  );
  object.id = id;
  return object;
}

P _settingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingsModelGetId(SettingsModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsModelGetLinks(SettingsModel object) {
  return [];
}

void _settingsModelAttach(
    IsarCollection<dynamic> col, Id id, SettingsModel object) {
  object.id = id;
}

extension SettingsModelQueryWhereSort
    on QueryBuilder<SettingsModel, SettingsModel, QWhere> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsModelQueryWhere
    on QueryBuilder<SettingsModel, SettingsModel, QWhereClause> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SettingsModelQueryFilter
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      introCompleteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'introComplete',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      introCompleteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'introComplete',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      introCompleteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'introComplete',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      userInformationCompleteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userInformationComplete',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      userInformationCompleteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userInformationComplete',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      userInformationCompleteEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userInformationComplete',
        value: value,
      ));
    });
  }
}

extension SettingsModelQueryObject
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {}

extension SettingsModelQueryLinks
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {}

extension SettingsModelQuerySortBy
    on QueryBuilder<SettingsModel, SettingsModel, QSortBy> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByIntroComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introComplete', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByIntroCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introComplete', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByUserInformationComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInformationComplete', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByUserInformationCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInformationComplete', Sort.desc);
    });
  }
}

extension SettingsModelQuerySortThenBy
    on QueryBuilder<SettingsModel, SettingsModel, QSortThenBy> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByIntroComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introComplete', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByIntroCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introComplete', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByUserInformationComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInformationComplete', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByUserInformationCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userInformationComplete', Sort.desc);
    });
  }
}

extension SettingsModelQueryWhereDistinct
    on QueryBuilder<SettingsModel, SettingsModel, QDistinct> {
  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctByIntroComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'introComplete');
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctByUserInformationComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userInformationComplete');
    });
  }
}

extension SettingsModelQueryProperty
    on QueryBuilder<SettingsModel, SettingsModel, QQueryProperty> {
  QueryBuilder<SettingsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SettingsModel, bool?, QQueryOperations> introCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'introComplete');
    });
  }

  QueryBuilder<SettingsModel, bool?, QQueryOperations>
      userInformationCompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userInformationComplete');
    });
  }
}
