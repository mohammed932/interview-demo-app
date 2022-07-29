part of 'home.imports.dart';

class HomeData {
  GenericCubit<List<UserModel>> usersCubit = GenericCubit([]);
  List<PostModel> posts = [];

  init({required BuildContext context}) {
    getUsers(context: context);
    getPosts(context: context);
  }

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
      posts = await HomeRepo.getPosts(context: context);
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
