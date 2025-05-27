import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:safe_driver_core/models/usuario.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onChanged});
  final ValueChanged<User> onChanged;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  double opacity = 0;
  bool signup = false;
  bool obscurePass = true;
  bool obscureRePass = true;
  bool loading = false;
  bool terms = false;
  String? error;
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerRePass = TextEditingController();
  final TextEditingController controllerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((e){
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(signup ? "Cadastro" : "Login"),
        ),
        body: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 200),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: 500,
                child: signup ?
                signupForm():
                signinForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signinForm(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Seja bem vindo ao Safe Driver",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          const SizedBox(height: 20,),
          const Text(
            "Para ter acesso à melhor plataforma de segurança de motoristas, comece fazendo seu login.",
            textAlign: TextAlign.center,
          ),
          errorWidget(),
          TextFormField(
            readOnly: loading,
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if(!value!.contains("@") || !value.contains(".")){
                return "E-mail inválido";
              } else {
                return null;
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(200)
            ],
            decoration: const InputDecoration(
              icon: Icon(Icons.email_outlined),
              labelText: "E-mail"
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            readOnly: loading,
            controller: controllerPass,
            validator: (value) {
              return value!.length < 6 ? "Senha Inválida" : null;
            },
            obscureText: obscurePass,
            decoration: InputDecoration(
              icon: const Icon(Ionicons.key_outline),
              labelText: "Senha",
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    obscurePass = !obscurePass;
                  });
                },
                icon: Icon(obscurePass ? Ionicons.eye_outline : Ionicons.eye_off_outline)
              ),
            ),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: loading ? (){} : (){},
            child: Text(
              "Esqueci minha senha",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: loading ? (){} : () async {
                if(formKey.currentState!.validate()){
                  try {
                    setState(() {
                      loading = true;
                      error = null;
                    });
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: controllerEmail.text.toLowerCase().replaceAll(" ", ""),
                      password: controllerPass.text,
                    );
                    widget.onChanged.call(FirebaseAuth.instance.currentUser!);
                  } catch (e){
                    setState(() {
                      loading = false;
                      error = e.toString();
                    });
                  }
                }
              },
              child: loading ?
                const CircularProgressIndicator():
                const Text("Entrar")
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Não possui conta? "),
              InkWell(
                onTap: loading ? (){} : (){
                  setState(() {
                    opacity = 0;
                  });
                  Future.delayed(const Duration(milliseconds: 300)).then((e){
                    setState(() {
                      signup = true;
                      opacity = 1;
                      error = null;
                      controllerPass.clear();
                      controllerRePass.clear();
                      formKey.currentState!.reset();
                    });
                  });
                  
                },
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget signupForm(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Seja bem vindo ao Safe Driver",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          const SizedBox(height: 20,),
          const Text(
            "Para ter acesso à melhor plataforma de segurança de motoristas, comece fazendo seu cadastro.",
            textAlign: TextAlign.center,
          ),
          errorWidget(),
          TextFormField(
            readOnly: loading,
            controller: controllerName,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if(value!.length < 6){
                return "Nome muito curto";
              } else {
                return null;
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(50)
            ],
            decoration: const InputDecoration(
              icon: Icon(Icons.person_outline),
              labelText: "Nome de Usuário"
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            readOnly: loading,
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if(!value!.contains("@") || !value.contains(".")){
                return "E-mail inválido";
              } else {
                return null;
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(200)
            ],
            decoration: const InputDecoration(
              icon: Icon(Icons.email_outlined),
              labelText: "E-mail"
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            readOnly: loading,
            controller: controllerPass,
            validator: (value) {
              return value!.length < 6 ? "Senha muito curta" : null;
            },
            obscureText: obscurePass,
            decoration: InputDecoration(
              icon: const Icon(Ionicons.key_outline),
              labelText: "Senha",
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    obscurePass = !obscurePass;
                  });
                },
                icon: Icon(obscurePass ? Ionicons.eye_outline : Ionicons.eye_off_outline)
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            readOnly: loading,
            controller: controllerRePass,
            validator: (value) {
              return value != controllerPass.text ? "Senhas Diferentes" : null;
            },
            obscureText: obscureRePass,
            decoration: InputDecoration(
              icon: const Icon(Ionicons.key_outline),
              labelText: "Repita sua senha",
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    obscureRePass = !obscureRePass;
                  });
                },
                icon: Icon(obscureRePass ? Ionicons.eye_outline : Ionicons.eye_off_outline)
              ),
            ),
          ),
          const SizedBox(height: 10,),
          FormField<bool>(
            initialValue: terms,
            validator: (value){
              return !terms ? "Você precisa concordar com os termos de uso" : null;
            },
            builder: (builder){
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: terms,
                        onChanged: (value){
                          setState(() {
                            terms = !terms;
                          });
                        }
                      ),
                      const Text("Condordo com os Termos de Uso.")
                    ],
                  ),
                  builder.hasError ?
                  Text(builder.errorText!, style: TextStyle(color: Colors.redAccent[700]),):
                  const SizedBox(),
                ],
              );
            }
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: loading ? (){} : () async {
                if(formKey.currentState!.validate()){
                  try {
                    setState(() {
                      loading = true;
                      error = null;
                    });
    
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: controllerEmail.text.toLowerCase().replaceAll(" ", ""),
                      password: controllerPass.text,
                    );
    
                    await userCredential.user!.updateDisplayName(controllerName.text);
    
                    await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid)
                    .set(
                      Usuario(
                        id: userCredential.user!.uid,
                        email: userCredential.user!.email,
                        username: controllerName.text,
                        created: Timestamp.now(),
                        working: false,
                      ).toMap()
                    );

                    widget.onChanged.call(FirebaseAuth.instance.currentUser!);
    
                  } catch (e){
                    setState(() {
                      loading = false;
                      error = e.toString();
                    });
                  }
                }
              },
              child: loading ?
                const CircularProgressIndicator():
                const Text("Cadastrar"),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Já possui conta? "),
              InkWell(
                onTap: loading ? null : (){
                  setState(() {
                      opacity = 0;
                  });
                  Future.delayed(const Duration(milliseconds: 300)).then((e){
                    setState(() {
                      signup = false;
                      opacity = 1;
                      error = null;
                      controllerPass.clear();
                      controllerRePass.clear();
                      formKey.currentState!.reset();
                    });
                  });
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget errorWidget(){
    return error == null ? const SizedBox(height: 20,):
    Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.redAccent[700],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(error!, style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }

}