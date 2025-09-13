import 'package:flutter/material.dart';
import 'package:painel_administrativo/data/service/data_service.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/engagement_section.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/projects_section.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DataService _dataService = DataService();

  List<String> _colaboradores = [];
  bool _loadingColaboradores = true;
  String? _colaboradorSelecionado;

  // Estados gerais
  // int _mesSelecionadoIndex = 8; // grafico de meses
  // int _projetoSelecionadoIndex = -1; // grafco de projetos
  // int _engajamentoGeralIndex = -1; // grafico geral
  // String _periodoSelecionado = "semana"; //semana ou mês
  // int _touchedMissionsIndex = -1; // grafico horizontal de missoes

  List<Map<String, dynamic>> _engajamento = [];
  List<Map<String, dynamic>> _projetos = []; // NOVO ESTADO
  List<Map<String, dynamic>> _engajamentoGeral = [];

  @override
  void initState() {
    super.initState();
    _loadColaboradores();
    _loadEngajamentoGeral();
  }

  Future<void> _loadEngajamentoGeral() async {
    final engajamentoGeral = await _dataService.fetchEngajamentoGeral();
    setState(() {
      _engajamentoGeral = engajamentoGeral;
    });
  }

  Future<void> _loadColaboradores() async {
    setState(() => _loadingColaboradores = true);
    final colaboradores = await _dataService.fetchColaboradores();
    setState(() {
      _colaboradores = colaboradores;
      _loadingColaboradores = false;
      if (_colaboradores.isNotEmpty) {
        _colaboradorSelecionado = _colaboradores[0];
        _loadEngajamento(_colaboradorSelecionado!);
        _loadProjetos(_colaboradorSelecionado!); 
      }
    });
  }

  Future<void> _loadEngajamento(String colaboradorNome) async {
    final eng = await _dataService.fetchEngajamentoPorColaborador(
      colaboradorNome: colaboradorNome,
    );
    setState(() {
      _engajamento = eng;
    });
  }

  Future<void> _loadProjetos(String colaboradorNome) async {
    final proj = await _dataService.fetchProjetosPorMes(
      colaboradorNome: colaboradorNome,
    );
    setState(() {
      _projetos = proj;
    });
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyles.white,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: larguraTela * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Dashboard de Engajamento",
                    style: AppStyles.kufam(
                      30,
                      AppStyles.black,
                      AppStyles.semiBold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Filtrar",
                      style: AppStyles.kufam(
                        18,
                        AppStyles.black,
                        AppStyles.semiBold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: larguraTela * 0.2,
                      child: _loadingColaboradores
                          ? const Center(
                              heightFactor: 1,
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : (_colaboradores.isEmpty
                                ? const Text('Nenhum colaborador')
                                : DropdownButton<String>(
                                    value: _colaboradorSelecionado,
                                    isExpanded: true,
                                    hint: const Text("Colaborador"),
                                    items: _colaboradores.map((colab) {
                                      return DropdownMenuItem(
                                        value: colab,
                                        child: Text(colab),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      if (value != null) {
                                        setState(
                                          () => _colaboradorSelecionado = value,
                                        );
                                        await _loadEngajamento(value);
                                        await _loadProjetos(
                                          value,
                                        ); 
                                      }
                                    },
                                  )),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

             
                EngagementSection(
                  engajamento: _engajamento,
                  projetos: _projetos,
                  engajamentoGeral: _engajamentoGeral,
                ),

                const SizedBox(height: 40),
                const ProjectsSection(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
