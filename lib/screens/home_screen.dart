import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int goal = 2000; // Meta diária
  int current = 0; // Começa com 0 ml
  int cupSize = 200; // Tamanho do copo padrão

  List<Map<String, dynamic>> records = []; // lista de registros vazia

  void addCup() {
    setState(() {
      current += cupSize;
      final now = TimeOfDay.now();
      String time = "${now.hour}:${now.minute.toString().padLeft(2, "0")}";
      records.insert(0, {"time": time, "amount": cupSize});
    });
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = MediaQuery.of(context).size.width * 0.40;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              //---------------------------------------
              // NOVA BARRA SUPERIOR IGUAL AO DA IMAGEM
              //---------------------------------------
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 6),
                color: Colors.blue.shade700,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        // HOME selecionado
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.water_drop, color: Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: 60,
                              height: 3,
                              color: Colors.white,
                            )
                          ],
                        ),

                        // HISTORY clicável
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/history');
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.history, color: Colors.white70),
                                  SizedBox(width: 6),
                                  Text(
                                    "History",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              //---------------------------------------
              // MENSAGEM DE DICA
              //---------------------------------------
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Do not drink cold water immediately after hot drinks like tea or coffee",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),

              //---------------------------------------
              // CÍRCULO DE PROGRESSO
              //---------------------------------------
              SizedBox(height: 20),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: current / goal),
                duration: Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, animatedProgress, child) {
                  return CustomPaint(
                    size: Size(circleSize, circleSize),
                    painter: WaterPainter(animatedProgress),
                    child: SizedBox(
                      width: circleSize,
                      height: circleSize,
                      child: Center(child: child),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$current/$goal ml",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Daily Drink Target",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              //---------------------------------------
              // BOTÃO ADICIONAR COPO
              //---------------------------------------
              SizedBox(height: 10),
              GestureDetector(
                onTap: addCup,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$cupSize ml",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.local_drink, size: 50, color: Colors.blue),
                        Icon(Icons.add, size: 28, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Confirm that you have just drunk water",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              //---------------------------------------
              // LISTA DE REGISTROS
              //---------------------------------------
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Today's records",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add, size: 24),
                  ],
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final item = records[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_drink, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("${item['time']}"),
                        Spacer(),
                        Text("${item['amount']} ml"),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------
// DESENHO DO CÍRCULO DE PROGRESSO
//----------------------------------------------------
class WaterPainter extends CustomPainter {
  final double progress;

  WaterPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 14;
    double radius = size.width / 2 - strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);

    Paint backgroundCircle = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint progressCircle = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi,
      false,
      backgroundCircle,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
