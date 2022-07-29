part of 'details.imports.dart';

class DetailsScreen extends StatefulWidget {
  final UserModel userModel;
  DetailsScreen({required this.userModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final DetailsData _detailsData = DetailsData();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: widget.userModel.name),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.userModel.thumbnailUrl), fit: BoxFit.cover)),
            ),
            GeneralWidget.sizeBoxVertical(20.0),
            ListView.builder(
                itemCount: widget.userModel.posts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  PostModel post = widget.userModel.posts[index];
                  return Card(
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(10.0),
                      title: MyText(title: post.title, fontWeight: FontWeight.bold),
                      subtitle: MyText(title: post.body, size: 13.0),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
