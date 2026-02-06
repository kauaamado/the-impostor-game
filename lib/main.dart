import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const JogoImpostorApp());
}

class JogoImpostorApp extends StatelessWidget {
  const JogoImpostorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O Impostor',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== TELA INICIAL ====================
class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final TextEditingController _nomeController = TextEditingController();
  final List<String> _jogadores = [];

  void _adicionarJogador() {
    if (_nomeController.text.isNotEmpty) {
      setState(() {
        _jogadores.add(_nomeController.text);
        _nomeController.clear();
      });
    }
  }

  void _removerJogador(int index) {
    setState(() {
      _jogadores.removeAt(index);
    });
  }

  void _iniciarJogo() {
    if (_jogadores.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mínimo 3 jogadores necessários!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCartas(jogadores: _jogadores),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('O Impostor'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Bem-vindo ao Jogo do Impostor!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Adicione os nomes dos jogadores abaixo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Input de nome
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      hintText: 'Digite o nome do jogador',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _adicionarJogador,
                      ),
                    ),
                    onSubmitted: (_) => _adicionarJogador(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Lista de jogadores
              Expanded(
                child: _jogadores.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum jogador adicionado',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _jogadores.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(_jogadores[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removerJogador(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              // Botão iniciar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _iniciarJogo,
                  child: const Text(
                    'Iniciar Jogo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }
}

// ==================== TELA DE CARTAS ====================
class TelaCartas extends StatefulWidget {
  final List<String> jogadores;

  const TelaCartas({Key? key, required this.jogadores}) : super(key: key);

  @override
  State<TelaCartas> createState() => _TelaCartasState();
}

class _TelaCartasState extends State<TelaCartas> {
  late List<String> _objetos;
  late int _impostorIndex;
  late int _jogadorAtual;
  late Map<int, String> _revelacoesJogadores;
  bool _cartaVirada = false;

  @override
  void initState() {
    super.initState();
    _inicializarJogo();
  }

  void _inicializarJogo() {
    // Lista de objetos comuns
    const objetos = [
      'Relógio',
      'Cadeira',
      'Lanterna',
      'Espelho',
      'Livro',
      'Telefone',
      'Caneta',
      'Mochila',
      'Óculos',
      'Chave',
      'Moeda',
      'Copo',
      'Prato',
      'Garfo',
      'Colher',
      'Faca',
      'Pente',
      'Escova de dentes',
      'Sabonete',
      'Toalha',
    ];

    // Selecionar objeto aleatório
    final objetoSelecionado = objetos[Random().nextInt(objetos.length)];

    // Selecionar impostor aleatório
    _impostorIndex = Random().nextInt(widget.jogadores.length);

    // Inicializar revelações
    _revelacoesJogadores = {};
    for (int i = 0; i < widget.jogadores.length; i++) {
      if (i == _impostorIndex) {
        _revelacoesJogadores[i] = 'VOCÊ É O IMPOSTOR';
      } else {
        _revelacoesJogadores[i] = objetoSelecionado;
      }
    }

    _jogadorAtual = 0;
    _cartaVirada = false;
  }

  void _virarCarta() {
    setState(() {
      _cartaVirada = true;
    });
  }

  void _proximoJogador() {
    setState(() {
      if (_jogadorAtual < widget.jogadores.length - 1) {
        _jogadorAtual++;
        _cartaVirada = false;
      } else {
        // Todos os jogadores viram suas cartas, ir para modo debate
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDebate(
              jogadores: widget.jogadores,
              impostorIndex: _impostorIndex,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distribuição de Cartas'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Jogador: ${widget.jogadores[_jogadorAtual]}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            // Carta
            GestureDetector(
              onTap: _virarCarta,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  gradient: _cartaVirada
                      ? LinearGradient(
                          colors: [Colors.amber.shade700, Colors.amber.shade400],
                        )
                      : LinearGradient(
                          colors: [Colors.indigo.shade700, Colors.indigo.shade500],
                        ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: _cartaVirada
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_revelacoesJogadores[_jogadorAtual] ==
                                  'VOCÊ É O IMPOSTOR')
                                const Icon(
                                  Icons.warning_rounded,
                                  size: 60,
                                  color: Colors.red,
                                )
                              else
                                const Icon(
                                  Icons.check_circle,
                                  size: 60,
                                  color: Colors.green,
                                ),
                              const SizedBox(height: 20),
                              Text(
                                _revelacoesJogadores[_jogadorAtual]!,
                                style: TextStyle(
                                  fontSize: _revelacoesJogadores[_jogadorAtual] ==
                                          'VOCÊ É O IMPOSTOR'
                                      ? 20
                                      : 24,
                                  fontWeight: FontWeight.bold,
                                  color: _revelacoesJogadores[_jogadorAtual] ==
                                          'VOCÊ É O IMPOSTOR'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              size: 60,
                              color: Colors.white,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Clique para\nVirar a Carta',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Botão próximo
            if (_cartaVirada)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _proximoJogador,
                    child: Text(
                      _jogadorAtual == widget.jogadores.length - 1
                          ? 'Ir para Debate'
                          : 'Próximo',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 40),
            // Progresso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Jogador ${_jogadorAtual + 1} de ${widget.jogadores.length}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== TELA DE DEBATE ====================
class TelaDebate extends StatefulWidget {
  final List<String> jogadores;
  final int impostorIndex;

  const TelaDebate({
    Key? key,
    required this.jogadores,
    required this.impostorIndex,
  }) : super(key: key);

  @override
  State<TelaDebate> createState() => _TelaDebateState();
}

class _TelaDebateState extends State<TelaDebate> {
  late int _tempoRestante;
  late bool _debateAtivo;
  late List<bool> _votosRecebidos;

  @override
  void initState() {
    super.initState();
    _tempoRestante = 300; // 5 minutos
    _debateAtivo = true;
    _votosRecebidos = List.filled(widget.jogadores.length, false);
  }

  void _iniciarVotacao() {
    setState(() {
      _debateAtivo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Debate'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
          ),
        ),
        child: _debateAtivo ? _construirDebate() : _construirVotacao(),
      ),
    );
  }

  Widget _construirDebate() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Fase de Debate',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              const Text(
                'Tempo de Debate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${(_tempoRestante ~/ 60).toString().padLeft(2, '0')}:${(_tempoRestante % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Discutam quem vocês acham que é o Impostor!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.jogadores.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(widget.jogadores[index]),
                  trailing: const Icon(Icons.person),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _iniciarVotacao,
              child: const Text(
                'Iniciar Votação',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _construirVotacao() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Votação Secreta',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Quem vocês acham que é o Impostor?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.jogadores.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(widget.jogadores[index]),
                  trailing: Checkbox(
                    value: _votosRecebidos[index],
                    onChanged: (value) {
                      setState(() {
                        _votosRecebidos[index] = value ?? false;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaResultado(
                      jogadores: widget.jogadores,
                      impostorIndex: widget.impostorIndex,
                      votosRecebidos: _votosRecebidos,
                    ),
                  ),
                );
              },
              child: const Text(
                'Finalizar Votação',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ==================== TELA DE RESULTADO ====================
class TelaResultado extends StatelessWidget {
  final List<String> jogadores;
  final int impostorIndex;
  final List<bool> votosRecebidos;

  const TelaResultado({
    Key? key,
    required this.jogadores,
    required this.impostorIndex,
    required this.votosRecebidos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Encontrar quem recebeu mais votos
    int maiorVotos = 0;
    for (int i = 0; i < votosRecebidos.length; i++) {
      if (votosRecebidos[i]) maiorVotos++;
    }

    int indiceMaiorVotos = votosRecebidos.indexOf(true);

    bool acertaram = indiceMaiorVotos == impostorIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                acertaram ? Icons.check_circle : Icons.cancel,
                size: 100,
                color: acertaram ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 30),
              Text(
                acertaram ? 'Vocês Venceram!' : 'O Impostor Venceu!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: acertaram ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'O Impostor era:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      jogadores[impostorIndex],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (indiceMaiorVotos != impostorIndex)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Votaram em:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        jogadores[indiceMaiorVotos],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaInicial(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Novo Jogo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
