part of "../user.dart";

class RoleNotifier extends StateNotifier<TypeUser?> {
  final UserApi userApi;
  final SecureStorage storage;

  RoleNotifier(this.storage, this.userApi) : super(null);

  void getRole() async {
    final result = await userApi.getUserData();
    result.fold(
      (error) async => await storage.delete('role'),
      (data) async => await storage.write("role", data.id!.split("-").first),
    );
    final role = await storage.read("role");
    if (role == "usr") {
      state = TypeUser.employee;
    } else if (role == "com") {
      state = TypeUser.company;
    }
  }
}

// state notifier get user data
class UserNotifier extends StateNotifier<States<UserData>> {
  final UserApi userApi;

  UserNotifier(this.userApi) : super(States.noState());

  void get() async {
    state = States.loading();
    try {
      final result = await userApi.getUserData();
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// state notifier edit user data
class EditUserNotifier extends StateNotifier<States<bool>> {
  final UserApi userApi;
  final Ref ref;

  EditUserNotifier(this.userApi, this.ref) : super(States.noState());

  Future<bool> edit({
    String? name,
    String? email,
    File? image,
  }) async {
    state = States.loading();
    try {
      final result = await userApi.editProfile(
        name: name,
        email: email,
        image: image,
      );
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          ref.read(userNotifier.notifier).get();
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// get address notifier
class AddressNotifier extends StateNotifier<States<Address>> {
  final UserApi userApi;

  AddressNotifier(this.userApi) : super(States.noState());

  void get() async {
    state = States.loading();
    try {
      final result = await userApi.getUserAddress();
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// change user address notifier
class EditAddressNotifier extends StateNotifier<States<bool>> {
  final UserApi userApi;
  final Ref ref;

  EditAddressNotifier(this.userApi, this.ref) : super(States.noState());

  Future<bool> edit(Address address) async {
    state = States.loading();
    try {
      final result = await userApi.editUserAddress(address);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          ref.read(addressNotifier.notifier).get();
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// change user password notifier
class EditPasswordNotifier extends StateNotifier<States<bool>> {
  final UserApi userApi;

  EditPasswordNotifier(this.userApi) : super(States.noState());

  Future<bool> edit(String password, String newPassword) async {
    state = States.loading();
    try {
      final result = await userApi.editPassword(password, newPassword);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          state = States.finished(true);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
