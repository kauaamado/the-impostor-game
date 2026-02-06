# Funcionalidades do Jogo "O Impostor"

## 1. Tela Inicial

**Objetivo:** Capturar os nomes de todos os jogadores antes de iniciar o jogo.

**Componentes:**
- Campo de texto para entrada do nome do jogador
- Botão "+" para adicionar jogador
- Lista de jogadores adicionados
- Botão de remover (X) para cada jogador
- Botão "Iniciar Jogo" (desabilitado se menos de 3 jogadores)

**Validações:**
- Mínimo de 3 jogadores obrigatório
- Mensagem de erro se tentar iniciar com menos de 3 jogadores

---

## 2. Distribuição de Cartas (Privacidade)

**Objetivo:** Revelar o papel de cada jogador de forma privada.

**Fluxo:**
1. Exibe o nome do jogador atual
2. Mostra uma carta virada (azul/índigo)
3. Jogador clica para virar a carta
4. Carta se abre com animação (amarela/ouro)
5. Revelação:
   - Se Inocente: Mostra o nome do objeto em verde
   - Se Impostor: Mostra "VOCÊ É O IMPOSTOR" em vermelho
6. Botão "Próximo" aparece após virar a carta
7. Ao clicar "Próximo":
   - Se não for o último jogador: Limpa a tela e mostra a próxima carta
   - Se for o último jogador: Vai para o Modo Debate

**Indicadores:**
- Mostra "Jogador X de Y" na parte inferior

---

## 3. Modo Debate

**Objetivo:** Permitir que os jogadores discutam e identifiquem o impostor.

**Componentes:**
- Título "Fase de Debate"
- Cronômetro (5 minutos = 300 segundos)
- Lista de todos os jogadores
- Botão "Iniciar Votação"

**Funcionalidade do Cronômetro:**
- Exibe tempo em formato MM:SS
- Cor amarela para destaque
- Apenas visual (não para automaticamente)

---

## 4. Votação Secreta

**Objetivo:** Permitir votação anônima em quem é o impostor.

**Componentes:**
- Título "Votação Secreta"
- Lista de jogadores com checkboxes
- Botão "Finalizar Votação"

**Funcionalidade:**
- Cada jogador pode selecionar um checkbox
- Apenas um checkbox pode estar marcado por vez
- Ao clicar em um novo checkbox, o anterior é desmarcado

---

## 5. Tela de Resultado

**Objetivo:** Revelar o resultado do jogo.

**Exibições:**
1. Ícone de vitória (✓) ou derrota (✗)
2. Mensagem: "Vocês Venceram!" ou "O Impostor Venceu!"
3. Caixa com "O Impostor era: [Nome]" em destaque
4. Se erraram na votação: Caixa vermelha com "Votaram em: [Nome]"
5. Botão "Novo Jogo" para reiniciar

**Cores:**
- Verde para vitória
- Vermelho para derrota
- Amarelo para destaque do impostor

---

## Mecânica do Jogo

### Seleção do Impostor
- Aleatória entre todos os jogadores
- Cada jogo tem um impostor diferente

### Seleção do Objeto
- Aleatória entre 20 objetos comuns
- O impostor nunca sabe qual é o objeto

### Objetos Disponíveis
1. Relógio
2. Cadeira
3. Lanterna
4. Espelho
5. Livro
6. Telefone
7. Caneta
8. Mochila
9. Óculos
10. Chave
11. Moeda
12. Copo
13. Prato
14. Garfo
15. Colher
16. Faca
17. Pente
18. Escova de dentes
19. Sabonete
20. Toalha

### Condições de Vitória
- **Grupo vence:** Se votarem no impostor
- **Impostor vence:** Se o grupo votar em alguém inocente

---

## Design Visual

### Paleta de Cores
- **Fundo:** Gradiente roxo (deepPurple.shade900 → deepPurple.shade600)
- **Cartas Viradas:** Azul/Índigo (antes de virar)
- **Cartas Abertas:** Amarelo/Ouro (depois de virar)
- **Texto Inocente:** Verde
- **Texto Impostor:** Vermelho
- **Botões Primários:** Âmbar
- **Botões Secundários:** Verde/Laranja/Vermelho

### Animações
- Transição suave da carta ao virar (500ms)
- Mudança de cor do gradiente
- Ícones animados (warning, check_circle)

---

## Fluxo Completo do Jogo

```
Tela Inicial
    ↓
[Adicionar Jogadores]
    ↓
[Iniciar Jogo]
    ↓
Distribuição de Cartas
    ↓
[Cada jogador vira sua carta]
    ↓
[Clica Próximo até o último]
    ↓
Modo Debate
    ↓
[Discutem por 5 minutos]
    ↓
[Clica Iniciar Votação]
    ↓
Votação Secreta
    ↓
[Votam em quem é o impostor]
    ↓
[Clica Finalizar Votação]
    ↓
Tela de Resultado
    ↓
[Veem quem era o impostor]
    ↓
[Clica Novo Jogo]
    ↓
Volta para Tela Inicial
```

---

## Notas Técnicas

- **Linguagem:** Dart com Flutter
- **Estado:** Gerenciado com StatefulWidget
- **Navegação:** MaterialPageRoute
- **Randomização:** Classe Random do Dart
- **Sem dependências externas:** Usa apenas Flutter Material

