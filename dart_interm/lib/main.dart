import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  //condicionais

  double nota = 7.0;
  if(nota < 5.0){
    print("Exame! :(");
  }else if(nota == 10.0){
    print("Sucesso Total!");
  }else if(nota == 9.9){
    print("Quase sucesso Total!");
  }else{
    print("Sucesso! :)");
  }

  bool aprovado = true;
  String info;

  /*if(aprovado){
    info = "Aprovado!!!";
  }else{
    info = "Reprovado!!!";
  }*/

  info = aprovado ? "Aprovado" : "Reprovado...";
  print(info);

  String nome = "Luan";
  String info2 = nome ?? "Não informado!";
  print(info2);

  print("Fim");

  //switch

  String linguagem = "Dart";

  switch(linguagem){
    case "Dart":
      print("Dart!");
      break;

    case "Java":
      print("Java :(");
      break;

    case "Swift":
      print("Swift :(");
      break;

    default:
      print("Outra");
  }

  //Loops

  /*for(int i = 0; i <=10; i++){
   print(i);
  }*/

  /*for(int i = 0; i <=10; i+= 2){
   print(i);
  }*/

  /*for(int i = 100; i >=10; i-= 10){
   print(i);
  }*/

  int j = 0;

  while(j < 10){
    print(j);
    j++;
  }

  int k = 0;

  do{
    print(k);
    k++;
  }while(k<10);

  //funções

  printIntro();
  printIntro();

  calcSoma(10.0, 15.0);

  double resMult = calcMult(10.0, 15.0);
  print(resMult);

  print(calcAreaCirculo(5.0));

  criarBotao("BotaoSair", botaoCriado);

  criarBotao("BotaoCamera",(){
    print("Botao criado por func anonima");
  });

}

void printIntro(){

  print("Seja bem-vindo(a)");
  print("Escolha a opção!");

}

void calcSoma(double a, double b){
  double res = a + b;
  print(res);
}

double calcMult(double a, double b){
  double res = a * b;
  return res;
}

/*double calcAreaCirculo(double raio){
  return 3.14 * raio * raio;
}*/

double calcAreaCirculo(double raio) => 3.14 * raio * raio;

void botaoCriado(){

  print("Botão criado!!!");

}

void criarBotao(String texto, Function criadoFunc, /*{String cor, double largura}*/){

  print(texto);
  //print(cor ?? "Preto");
  //print(largura ?? 10.0);
  criadoFunc();

}





























class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
