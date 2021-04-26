// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'product_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ProductSearchResultTearOff {
  const _$ProductSearchResultTearOff();

// ignore: unused_element
  Data call(StoreModel storeModel) {
    return Data(
      storeModel,
    );
  }

// ignore: unused_element
  Error error(CartvorieApiError error) {
    return Error(
      error,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ProductSearchResult = _$ProductSearchResultTearOff();

/// @nodoc
mixin _$ProductSearchResult {
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    @required TResult error(CartvorieApiError error),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    TResult error(CartvorieApiError error),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult error(Error value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult error(Error value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ProductSearchResultCopyWith<$Res> {
  factory $ProductSearchResultCopyWith(
          ProductSearchResult value, $Res Function(ProductSearchResult) then) =
      _$ProductSearchResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProductSearchResultCopyWithImpl<$Res>
    implements $ProductSearchResultCopyWith<$Res> {
  _$ProductSearchResultCopyWithImpl(this._value, this._then);

  final ProductSearchResult _value;
  // ignore: unused_field
  final $Res Function(ProductSearchResult) _then;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  $Res call({StoreModel storeModel});
}

/// @nodoc
class _$DataCopyWithImpl<$Res> extends _$ProductSearchResultCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object storeModel = freezed,
  }) {
    return _then(Data(
      storeModel == freezed ? _value.storeModel : storeModel as StoreModel,
    ));
  }
}

/// @nodoc
class _$Data implements Data {
  const _$Data(this.storeModel) : assert(storeModel != null);

  @override
  final StoreModel storeModel;

  @override
  String toString() {
    return 'ProductSearchResult(storeModel: $storeModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.storeModel, storeModel) ||
                const DeepCollectionEquality()
                    .equals(other.storeModel, storeModel)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(storeModel);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    @required TResult error(CartvorieApiError error),
  }) {
    assert($default != null);
    assert(error != null);
    return $default(storeModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    TResult error(CartvorieApiError error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(storeModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult error(Error value),
  }) {
    assert($default != null);
    assert(error != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult error(Error value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Data implements ProductSearchResult {
  const factory Data(StoreModel storeModel) = _$Data;

  StoreModel get storeModel;
  $DataCopyWith<Data> get copyWith;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({CartvorieApiError error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$ProductSearchResultCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(Error(
      error == freezed ? _value.error : error as CartvorieApiError,
    ));
  }
}

/// @nodoc
class _$Error implements Error {
  const _$Error(this.error) : assert(error != null);

  @override
  final CartvorieApiError error;

  @override
  String toString() {
    return 'ProductSearchResult.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    @required TResult error(CartvorieApiError error),
  }) {
    assert($default != null);
    assert(error != null);
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(StoreModel storeModel), {
    TResult error(CartvorieApiError error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(Data value), {
    @required TResult error(Error value),
  }) {
    assert($default != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(Data value), {
    TResult error(Error value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements ProductSearchResult {
  const factory Error(CartvorieApiError error) = _$Error;

  CartvorieApiError get error;
  $ErrorCopyWith<Error> get copyWith;
}
