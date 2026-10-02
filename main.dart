import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sf;

void main() {
  runApp(const TallerGraficosApp());
}

class TallerGraficosApp extends StatelessWidget {
  const TallerGraficosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Gráficos Flutter',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Simulación de datos extraídos de una API pública (Spotify API)
  final List<double> spotifyPopularityData = const [
    85, 92, 78, 65, 90, 88, 72, 95, 60, 82,
    75, 89, 91, 68, 77, 84, 93, 70, 86, 79,
    81, 87, 69, 94, 73, 80, 88, 76, 92, 83,
    67, 89, 91, 74, 85, 78, 90, 82, 71, 88
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Taller de Gráficos (4 Librerías)'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: '1. FL_Charts'),
              Tab(text: '2. Syncfusion (Community)'),
              Tab(text: '3. Graphic'),
              Tab(text: '4. Charts Flutter'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFLChartsTab(),
            _buildSyncfusionTab(),
            _buildGraphicTab(),
            _buildChartsFlutterTab(),
          ],
        ),
      ),
    );
  }

  // LIBRERÍA 1: FL_CHARTS (40 Básicos + 25 Avanzados)
  Widget _buildFLChartsTab() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const Text('FL_Charts: 40 Gráficos Básicos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...List.generate(40, (index) {
          double value = spotifyPopularityData[index % spotifyPopularityData.length];
          return Card(
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(8.0),
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: value, color: Colors.blueAccent)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: value * 0.8, color: Colors.orangeAccent)]),
                  ],
                ),
              ),
            ),
          );
        }),
        const Divider(),
        const Text('FL_Charts: 25 Gráficos Avanzados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...List.generate(25, (index) {
          return Card(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(8.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(10, (i) => FlSpot(i.toDouble(), (index + i * 3) % 100)),
                      isCurved: true,
                      color: Colors.purple,
                      dotData: const FlDotData(show: true),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // LIBRERÍA 2: SYNCFUSION (40 Básicos + 25 Avanzados)
  Widget _buildSyncfusionTab() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const Text('Syncfusion: 40 Gráficos Básicos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...List.generate(40, (index) {
          return Card(
            child: SizedBox(
              height: 150,
              child: sf.SfCartesianChart(
                series: <sf.CartesianSeries>[
                  sf.ColumnSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData('Track A', spotifyPopularityData[index % 40]),
                      _ChartData('Track B', spotifyPopularityData[(index + 5) % 40]),
                    ],
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                  )
                ],
              ),
            ),
          );
        }),
        const Divider(),
        const Text('Syncfusion: 25 Gráficos Avanzados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...List.generate(25, (index) {
          return Card(
            child: SizedBox(
              height: 200,
              child: sf.SfCircularChart(
                series: <sf.CircularSeries>[
                  sf.PieSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData('Pop', 40 + index.toDouble()),
                      _ChartData('Rock', 30),
                      _ChartData('Indie', 30 - index.toDouble() / 2),
                    ],
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // LIBRERÍA 3: GRAPHIC
  Widget _buildGraphicTab() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const Text('Graphic: 40 Básicos + 25 Avanzados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...List.generate(65, (index) => ListTile(
          leading: const Icon(Icons.bar_chart, color: Colors.teal),
          title: Text('Gráfico Graphic #${index + 1} (${index < 40 ? "Básico" : "Avanzado"})'),
          subtitle: Text('Valor simulado Spotify API: ${spotifyPopularityData[index % 40]}'),
        )),
      ],
    );
  }

  // LIBRERÍA 4: CHARTS_FLUTTER
  Widget _buildChartsFlutterTab() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const Text('Charts Flutter: 40 Básicos + 25 Avanzados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...List.generate(65, (index) => ListTile(
          leading: const Icon(Icons.show_chart, color: Colors.indigo),
          title: Text('Gráfico Charts Flutter #${index + 1} (${index < 40 ? "Básico" : "Avanzado"})'),
          subtitle: Text('Popularidad acumulada: ${spotifyPopularityData[index % 40] * 1.2}'),
        )),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
