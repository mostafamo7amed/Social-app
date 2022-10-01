import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../cubit/login_cubit/cubit.dart';
import '../../cubit/login_cubit/states.dart';
import '../../shared/components/component.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uid', data: state.uid);
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.getCubit(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            'To experience our great services',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            context: context,
                            label: 'Email Address',
                            prefix: const Icon(Icons.email),
                            controller: emailController,
                            validate: (value){
                              if(value!.isEmpty) {
                                return 'email can\'t be empty' ;
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              label: 'Password',
                              prefix: const Icon(Icons.lock),
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'password can\'t be empty';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              pressedShow: (){
                                cubit.changePasswordVisibility();
                              },
                              isPassword: cubit.isPassword,
                              type: TextInputType.visiblePassword
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            color: Colors.blue,
                            child: MaterialButton(
                              child: ConditionalBuilder(
                                condition: state is! SocialLoginLoadingState,
                                builder: (context) =>  const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                fallback: (context) => const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  cubit.shopLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text(
                                  'Register Now',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
