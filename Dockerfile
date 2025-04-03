FROM groad/mcpo:latest

ENV NODE_VERSION 18.19.1
ENV NVM_DIR /usr/local/nvm
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar NVM (Node Version Manager)
RUN mkdir -p $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Instalar Node.js e configurar
RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Verificar instalação
RUN node --version && \
    npm --version && \
    npx --version

# Configurar diretório de trabalho
WORKDIR /app

# Adicionar permissões para o diretório de trabalho
RUN mkdir -p /app && \
    chmod 777 /app
