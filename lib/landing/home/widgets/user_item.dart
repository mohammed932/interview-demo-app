part of 'home_widgets.import.dart';

class UserItem extends StatelessWidget {
  final UserModel user;

  UserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.thumbnailUrl),
          backgroundColor: Colors.transparent,
          radius: 30,
        ),
        title: MyText(
          title: 'Name : ${user.name}',
        ),
        subtitle: MyText(
          title: 'Post count : ${user.posts.length}',
          size: 12.0,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        dense: true,
        contentPadding: const EdgeInsets.all(10.0),
        onTap: () => AutoRouter.of(context).push(DetailsScreenRoute(userModel: user)),
      ),
    );
  }
}
