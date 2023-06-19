import 'package:egrocer/helper/utils/generalImports.dart';

class DefaultBlankItemMessageScreen extends StatefulWidget {
  final String image, title, description;
  final Function? callback;
  final String? btntext;

  const DefaultBlankItemMessageScreen({Key? key, this.callback, this.btntext, required this.image, required this.title, required this.description}) : super(key: key);

  @override
  State<DefaultBlankItemMessageScreen> createState() => DefaultBlankItemMessageScreenState();
}

class DefaultBlankItemMessageScreenState extends State<DefaultBlankItemMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsetsDirectional.all(Constant.size30),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.only(bottom: 50),
            decoration: ShapeDecoration(
              color: ColorsRes.defaultPageInnerCircle,
              shape: CircleBorder(
                side: BorderSide(width: 20, color: ColorsRes.defaultPageOuterCircle),
              ),
            ),
            child: Center(
              child: Widgets.defaultImg(
                image: widget.image,
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),
          Text(
            widget.title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  TextStyle(
                    color: ColorsRes.appColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
          ),
          SizedBox(height: Constant.size10),
          Text(
            widget.description,
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  const TextStyle(
                    letterSpacing: 0.5,
                  ),
                ),
          ),
          if (widget.callback != null) const SizedBox(height: 20),
          if (widget.callback != null)
            ElevatedButton(
              onPressed: () {
                widget.callback!();
              },
              child: Text(
                widget.btntext!,
                softWrap: true,
              ),
            )
        ],
      ),
    );
  }
}
