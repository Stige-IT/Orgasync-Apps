// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseState<T> {
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get lastPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BaseStateCopyWith<T, BaseState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseStateCopyWith<T, $Res> {
  factory $BaseStateCopyWith(
          BaseState<T> value, $Res Function(BaseState<T>) then) =
      _$BaseStateCopyWithImpl<T, $Res, BaseState<T>>;
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic isLoadingMore,
      String? error,
      T? data,
      int page,
      int lastPage,
      int total});
}

/// @nodoc
class _$BaseStateCopyWithImpl<T, $Res, $Val extends BaseState<T>>
    implements $BaseStateCopyWith<T, $Res> {
  _$BaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isLoadingMore = freezed,
    Object? error = freezed,
    Object? data = freezed,
    Object? page = null,
    Object? lastPage = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isLoadingMore: freezed == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as dynamic,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseStateImplCopyWith<T, $Res>
    implements $BaseStateCopyWith<T, $Res> {
  factory _$$BaseStateImplCopyWith(
          _$BaseStateImpl<T> value, $Res Function(_$BaseStateImpl<T>) then) =
      __$$BaseStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic isLoadingMore,
      String? error,
      T? data,
      int page,
      int lastPage,
      int total});
}

/// @nodoc
class __$$BaseStateImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$BaseStateImpl<T>>
    implements _$$BaseStateImplCopyWith<T, $Res> {
  __$$BaseStateImplCopyWithImpl(
      _$BaseStateImpl<T> _value, $Res Function(_$BaseStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isLoadingMore = freezed,
    Object? error = freezed,
    Object? data = freezed,
    Object? page = null,
    Object? lastPage = null,
    Object? total = null,
  }) {
    return _then(_$BaseStateImpl<T>(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      isLoadingMore:
          freezed == isLoadingMore ? _value.isLoadingMore! : isLoadingMore,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      lastPage: null == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BaseStateImpl<T> implements _BaseState<T> {
  const _$BaseStateImpl(
      {this.isLoading = false,
      this.isLoadingMore = false,
      this.error,
      this.data,
      this.page = 1,
      this.lastPage = 1,
      this.total = 0});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic isLoadingMore;
  @override
  final String? error;
  @override
  final T? data;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int lastPage;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'BaseState<$T>(isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, data: $data, page: $page, lastPage: $lastPage, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseStateImpl<T> &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isLoadingMore, isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isLoadingMore),
      error,
      const DeepCollectionEquality().hash(data),
      page,
      lastPage,
      total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseStateImplCopyWith<T, _$BaseStateImpl<T>> get copyWith =>
      __$$BaseStateImplCopyWithImpl<T, _$BaseStateImpl<T>>(this, _$identity);
}

abstract class _BaseState<T> implements BaseState<T> {
  const factory _BaseState(
      {final dynamic isLoading,
      final dynamic isLoadingMore,
      final String? error,
      final T? data,
      final int page,
      final int lastPage,
      final int total}) = _$BaseStateImpl<T>;

  @override
  dynamic get isLoading;
  @override
  dynamic get isLoadingMore;
  @override
  String? get error;
  @override
  T? get data;
  @override
  int get page;
  @override
  int get lastPage;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$BaseStateImplCopyWith<T, _$BaseStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
