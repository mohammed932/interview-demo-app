part of 'home.imports.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeData _homeData = HomeData();
  @override
  void initState() {
    super.initState();
    _homeData.getUsers(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Home', hideBackButton: true),
      body: BlocBuilder<GenericCubit<List<UserModel>>, GenericCubitState<List<UserModel>>>(
        bloc: _homeData.usersCubit,
        builder: (context, state) {
          if (state is GenericLoadingState) {
            return LoadingDialog.showLoadingView();
          } else if (state is GenericUpdatedState) {
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: ((context, index) {
                  return UserItem(user: state.data[index]);
                }));
          } else if (state is GenericErrorState) {
            return Center(
              child: MyText(title: 'error occur'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
