part of 'home.imports.dart';

class HomeData {
  GenericCubit<List<UserModel>> usersCubit = GenericCubit([]);

  getUsers({required BuildContext context}) async {
    try {
      usersCubit.onLoadingState();
      List<UserModel> users = await HomeRepo.getUsers(context: context);
      List<PostModel> posts = await getPosts(context: context);
      users.forEach((user) => user.posts = posts.where((post) => post.userId == user.userId).toList());
      usersCubit.onUpdateData(users);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> getPosts({required BuildContext context}) async {
    try {
      return await HomeRepo.getPosts(context: context);
    } catch (e) {
      rethrow;
    }
  }
}
