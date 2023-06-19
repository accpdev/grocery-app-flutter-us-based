import 'package:egrocer/helper/utils/generalImports.dart';

class WebViewScreen extends StatefulWidget {
  final String dataFor;

  const WebViewScreen({Key? key, required this.dataFor}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool privacyPolicyExpanded = false;
  bool returnExchangePolicyExpanded = false;
  bool shippingPolicyExpanded = false;
  bool cancellationPolicyExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    String htmlContent = "";
    if (widget.dataFor ==
        getTranslatedValue(
          context,
          "lblContactUs",
        )) {
      htmlContent = Constant.contactUs;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "lblAboutUs",
        )) {
      htmlContent = Constant.aboutUs;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "lblTermsAndConditions",
        )) {
      htmlContent = Constant.termsConditions;
    } else if (widget.dataFor ==
        getTranslatedValue(
          context,
          "lblPrivacyPolicy",
        )) {
      htmlContent = Constant.privacyPolicy;
    }

    return Scaffold(
      appBar: getAppBar(
          title: Text(
            widget.dataFor,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          context: context),
      body: SingleChildScrollView(
        child: widget.dataFor ==
                getTranslatedValue(
                  context,
                  "lblPolicies",
                )
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: privacyPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => privacyPolicyExpanded = expanded);
                      },
                      title: Text(
                        getTranslatedValue(
                          context,
                          "lblPrivacyPolicy",
                        ),
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        privacyPolicyExpanded ? Icons.remove : Icons.add,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: Constant.size30, top: Constant.size5, bottom: Constant.size10, end: Constant.size10),
                          child: _getHtmlContainer(Constant.privacyPolicy),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: returnExchangePolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => returnExchangePolicyExpanded = expanded);
                      },
                      title: Text(
                        getTranslatedValue(
                          context,
                          "lblReturnsAndExchangesPolicy",
                        ),
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        returnExchangePolicyExpanded ? Icons.remove : Icons.add,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: Constant.size30, top: Constant.size5, bottom: Constant.size10, end: Constant.size10),
                          child: _getHtmlContainer(Constant.returnAndExchangesPolicy),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: shippingPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => shippingPolicyExpanded = expanded);
                      },
                      title: Text(
                        getTranslatedValue(
                          context,
                          "lblShippingPolicy",
                        ),
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        shippingPolicyExpanded ? Icons.remove : Icons.add,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: Constant.size30, top: Constant.size5, bottom: Constant.size10, end: Constant.size10),
                          child: _getHtmlContainer(Constant.shippingPolicy),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      10,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: cancellationPolicyExpanded,
                      onExpansionChanged: (bool expanded) {
                        setState(() => cancellationPolicyExpanded = expanded);
                      },
                      title: Text(
                        getTranslatedValue(
                          context,
                          "lblCancellationPolicy",
                        ),
                        style: TextStyle(color: ColorsRes.mainTextColor),
                      ),
                      trailing: Icon(
                        cancellationPolicyExpanded ? Icons.remove : Icons.add,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: Constant.size30, top: Constant.size5, bottom: Constant.size10, end: Constant.size10),
                          child: _getHtmlContainer(Constant.cancellationPolicy),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(Constant.size10),
                child: _getHtmlContainer(htmlContent),
              ),
      ),
    );
  }

  Widget _getHtmlContainer(String htmlContent) {
    return HtmlWidget(
      htmlContent,
      enableCaching: true,
    );
  }
}
