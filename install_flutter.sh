#!/bin/bash

# Define caminhos (ajustado para usar o HOME do usuário atual)
INSTALL_DIR="$HOME/Android/develop"
FLUTTER_PATH="$INSTALL_DIR/flutter"

echo "🚀 Iniciando instalação do Flutter..."

# 1. Cria diretórios necessários
mkdir -p "$INSTALL_DIR"

# 2. Clona o Flutter apenas se não existir
if [ ! -d "$FLUTTER_PATH" ]; then
    echo "📥 Clonando Flutter SDK (stable)..."
    git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_PATH"
else
    echo "✅ Flutter já está clonado em $FLUTTER_PATH"
fi

# 3. Adiciona ao PATH no .bashrc se ainda não estiver lá
if ! grep -q "flutter/bin" ~/.bashrc; then
    echo "🔧 Adicionando Flutter ao PATH no .bashrc..."
    echo "" >> ~/.bashrc
    echo "# Flutter SDK" >> ~/.bashrc
    echo "export PATH=\"\$PATH:$FLUTTER_PATH/bin\"" >> ~/.bashrc
    echo "✅ PATH configurado!"
else
    echo "✅ PATH já configurado no .bashrc"
fi

# 4. Tenta configurar o Android SDK se ele existir no local padrão
if [ -d "$HOME/Android/Sdk" ]; then
    echo "🤖 Android SDK detectado. Configurando variáveis..."
    if ! grep -q "ANDROID_HOME" ~/.bashrc; then
        echo "export ANDROID_HOME=\$HOME/Android/Sdk" >> ~/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator" >> ~/.bashrc
    fi
fi

echo "✨ Instalação concluída!"
echo "👉 Rode: 'source ~/.bashrc' para ativar o comando flutter neste terminal."
echo "👉 Depois rode: 'flutter doctor' para verificar o ambiente."
