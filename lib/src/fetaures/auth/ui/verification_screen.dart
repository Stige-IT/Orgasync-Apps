part of "../auth.dart";

class VerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final TypeVerification type;

  const VerificationScreen(this.email, this.type, {super.key});

  @override
  ConsumerState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _codeCtrl;

  @override
  void initState() {
    _codeCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(verificationNotifier).isLoading;

    ref.listen(resendCodeNotifier, (previous, next) {
      if(next.isLoading){
        showSnackbar(context, "Loading...");
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("verification".tr()),
      ),
      body: Row(
        children: [
          Flexible(
            child: Center(
              child: SizedBox(
                width: context.isDesktop ? 600 : null,
                child: SingleChildScrollView(
                      padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "verification".tr(),
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "verification_message".tr(namedArgs: {"email": widget.email}),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 50),
                        FieldInput(
                          textAlign: TextAlign.center,
                          hintText: "input_code".tr(),
                          controllers: _codeCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: _handleVerification,
                          child: isLoading
                              ? const LoadingWidget()
                              : Text("verification".tr()),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("not_receive_code".tr()),
                            TextButton(
                              onPressed: _handleResendCode,
                              child: Text("resend".tr()),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleVerification() {
    final verify = ref.watch(verificationNotifier);
    if (formKey.currentState!.validate() && !verify.isLoading) {
      final code = _codeCtrl.text;
      ref
          .read(verificationNotifier.notifier)
          .verification(email: widget.email, code: code, type: widget.type)
          .then(
        (success) {
          if (success) {
            showSnackbar(context, "verification_success".tr(),
                type: SnackBarType.success);
            nextPage(context, "/login");
          } else {
            showSnackbar(context, verify.error!, type: SnackBarType.error);
          }
        },
      );
    }
  }

  void _handleResendCode(){
    final resend = ref.watch(resendCodeNotifier);
    if(!resend.isLoading){
      ref.read(resendCodeNotifier.notifier).resendCode(widget.email).then((success) {
        if(success){
          showSnackbar(context, "resend_code_success".tr(), type: SnackBarType.success);
        }else{
          showSnackbar(context, resend.error!, type: SnackBarType.error);
        }
      });
    }
  }
}
