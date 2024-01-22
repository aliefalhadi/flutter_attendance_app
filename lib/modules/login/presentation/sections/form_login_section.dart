part of '../login_page.dart';

class _FormLoginSection extends StatelessWidget {
  const _FormLoginSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        ),
      ),
      child: ListView(
        children: [
          TextFormWidget(
            label: 'Email',
            hint: "test@gmail.com",
            keyboardType: TextInputType.emailAddress,
            onChange: (value) {
              context
                  .read<LoginBloc>()
                  .add(LoginEvent.emailChanged(email: value));
            },
          ),
          SizedBox(height: 16.h),
          TextFormWidget(
            label: 'Kata Sandi',
            hint: "Contoh: Sandi12!",
            obscure: true,
            onChange: (value) {
              context
                  .read<LoginBloc>()
                  .add(LoginEvent.passwordChanged(password: value));
            },
          ),
          SizedBox(height: 32.h),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SizedBox(
                width: 1.sw,
                child: ElevatedButton(
                  onPressed: state.isValid
                      ? () {
                          FocusScope.of(context).unfocus();

                          context
                              .read<LoginBloc>()
                              .add(const LoginEvent.login());
                        }
                      : null,
                  child: const Text("Masuk"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
