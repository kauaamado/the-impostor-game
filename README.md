# O Impostor - Jogo Flutter

Um aplicativo interativo do jogo "O Impostor" com tema de objetos, desenvolvido em Flutter.

## Descrição

Este é um jogo de dedução social onde:
- Um jogador é escolhido aleatoriamente como o **Impostor**
- Todos os outros jogadores recebem o nome de um **Objeto Secreto**
- O Impostor não sabe qual é o objeto
- Durante o debate, os jogadores tentam descobrir quem é o Impostor
- No final, há uma votação secreta para eliminar o suspeito

## Funcionalidades

### 1. Tela Inicial
- Interface para adicionar nomes dos jogadores
- Validação mínima de 3 jogadores
- Lista de jogadores com opção de remover

### 2. Distribuição de Cartas
- Cada jogador vira sua carta individualmente
- Revelação privada do objeto ou status de Impostor
- Botão "Próximo" para passar para o próximo jogador
- Indicador de progresso

### 3. Modo Debate
- Cronômetro para a fase de debate (5 minutos)
- Lista de todos os jogadores
- Botão para iniciar votação

### 4. Votação Secreta
- Interface de votação com checkboxes
- Seleção de quem é o Impostor
- Resultado final com revelação

### 5. Tela de Resultado
- Exibe se o grupo acertou ou não
- Mostra quem era o Impostor
- Mostra em quem votaram (se erraram)
- Botão para novo jogo

## Requisitos

- Flutter SDK (versão estável)
- Dart SDK (incluído no Flutter)
- Android Studio ou VS Code com extensão Flutter
- Um dispositivo ou emulador Android/iOS

## Instalação e Compilação

### 1. Instalar Flutter

Se ainda não tem Flutter instalado:

```bash
# Clone o Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable

# Adicione ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verifique a instalação
flutter doctor
```

### 2. Compilar o Projeto

```bash
# Entre no diretório do projeto
cd jogo_impostor

# Obtenha as dependências
flutter pub get

# Execute em um dispositivo/emulador
flutter run

# Ou compile para APK (Android)
flutter build apk --release

# Ou compile para iOS
flutter build ios --release
```

### 3. Usando uma IDE

**Android Studio:**
1. Abra Android Studio
2. Selecione "Open an existing Android Studio project"
3. Navegue até a pasta `jogo_impostor`
4. Aguarde a sincronização do Gradle
5. Clique em "Run" (Shift + F10)

**VS Code:**
1. Abra VS Code
2. Abra a pasta `jogo_impostor`
3. Execute `Flutter: Run` na paleta de comandos (Ctrl+Shift+P)

## Estrutura do Projeto

```
jogo_impostor/
├── lib/
│   └── main.dart          # Código principal da aplicação
├── android/               # Configurações Android
├── ios/                   # Configurações iOS
├── pubspec.yaml          # Dependências do projeto
└── README.md             # Este arquivo
```

## Como Jogar

1. **Adicione os Jogadores**: Na tela inicial, digite os nomes de todos os jogadores (mínimo 3)
2. **Inicie o Jogo**: Clique em "Iniciar Jogo"
3. **Vire as Cartas**: Cada jogador clica em sua carta para revelar seu papel
4. **Debate**: Todos discutem quem é o Impostor (5 minutos)
5. **Votação**: Votam secretamente em quem acham que é o Impostor
6. **Resultado**: Veja quem acertou

## Objetos Disponíveis

O jogo escolhe aleatoriamente entre os seguintes objetos:
- Relógio
- Cadeira
- Lanterna
- Espelho
- Livro
- Telefone
- Caneta
- Mochila
- Óculos
- Chave
- Moeda
- Copo
- Prato
- Garfo
- Colher
- Faca
- Pente
- Escova de dentes
- Sabonete
- Toalha

## Personalização

Para adicionar mais objetos, edite a lista em `lib/main.dart` na classe `_TelaCartasState`:

```dart
const objetos = [
  'Seu Objeto Aqui',
  // ... mais objetos
];
```

## Licença

Este projeto é de código aberto e pode ser usado livremente.

## Suporte

Para dúvidas ou problemas, consulte a documentação oficial do Flutter:
https://flutter.dev/docs
