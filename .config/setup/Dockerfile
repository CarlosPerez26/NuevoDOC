# ================================
# 1️⃣ Imagen base
# ================================
FROM ubuntu:24.04

# Evita prompts interactivos en apt
ENV DEBIAN_FRONTEND=noninteractive

# Soporte correcto de colores en terminal
ENV TERM=xterm-256color


# ================================
# 2️⃣ Paquetes base del sistema
# ================================
RUN apt-get update \
    && apt-get install -y \
        curl \
        wget \
        git \
        tmux \
        ripgrep \
        fd-find \
        zsh \
        ca-certificates \
        python3 \
        python3-pip \
        python3-venv \
        build-essential \
        unzip \
        locales \
        dos2unix \
    && pip install --break-system-packages fastapi "uvicorn[standard]" \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ================================
# 3️⃣ Configuración de locale UTF-8
# ================================
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8


# ================================
# 4️⃣ Ajustes de utilidades
# ================================
# fd-find se llama fdfind en Ubuntu → creamos alias global
RUN ln -s $(which fdfind) /usr/local/bin/fd

# ================================
# 5️⃣ Crear usuario de desarrollo (ANTES de usarlo)
# ================================
RUN useradd -m -s /usr/bin/zsh dev \
    && mkdir -p /workspace \
    && mkdir -p /home/dev/.config/nvim \
    && mkdir -p /home/dev/go/bin \
    && chown -R dev:dev /workspace /home/dev

# ================================
# 5️⃣ Node.js LTS (requerido por gemini-cli)
# ================================
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && node -v \
    && npm -v

# ================================
# 5.1️⃣ Go & Gentle AI
# ================================
# Instalar Go (Binario oficial)
RUN curl -fsSL https://go.dev/dl/go1.24.0.linux-amd64.tar.gz -o /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz

# Configurar PATH para Go global y para binarios de usuario
ENV PATH=$PATH:/usr/local/go/bin:/home/dev/go/bin
ENV GOPATH=/home/dev/go

# Instalar gentle-ai como usuario dev
USER dev
RUN /usr/local/go/bin/go install github.com/gentleman-programming/gentle-ai/cmd/gentle-ai@latest
USER root

# ================================
# 6️⃣➕ Gemini CLI (Google)
# ================================
RUN npm install -g @google/gemini-cli \
    && gemini --version

# ================================
# 6️⃣➕ Herramientas adicionales
# ================================
RUN npm install -g tree-sitter-cli

# ================================
# 6️⃣ Neovim moderno (binario oficial)
# ================================
RUN NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4) \
    && curl -fSL https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz \
        -o /tmp/nvim.tar.gz \
    && tar xzf /tmp/nvim.tar.gz -C /opt \
    && ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim \
    && rm /tmp/nvim.tar.gz \
    && nvim --version

# ================================
# 7️⃣ Fastfetch (info del sistema)
# ================================
RUN curl -fSL https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb \
        -o /tmp/fastfetch.deb \
    && apt-get update \
    && apt-get install -y /tmp/fastfetch.deb \
    && rm /tmp/fastfetch.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ================================
# 8️⃣ Copiar dotfiles del usuario
# ================================
COPY dotfiles/.zshrc /home/dev/.zshrc
COPY dotfiles/.tmux.conf /home/dev/.tmux.conf
COPY dotfiles/.gitconfig /home/dev/.gitconfig
COPY dotfiles/.git-credentials /home/dev/.git-credentials
COPY dotfiles/init.lua /home/dev/.config/nvim/init.lua
COPY dotfiles/GEMINI.md /home/dev/.gemini/GEMINI.md
COPY PENDING_TASKS.md /workspace/PENDING_TASKS.md

# ================================
# 9️⃣ Normalizar archivos Windows → Linux
# ================================
RUN dos2unix \
      /home/dev/.zshrc \
      /home/dev/.tmux.conf \
      /home/dev/.gitconfig \
      /home/dev/.git-credentials \
      /home/dev/.config/nvim/init.lua \
      /home/dev/.gemini/GEMINI.md \
      /workspace/PENDING_TASKS.md \
    && mkdir -p /home/dev/.gemini/skills \
    && chown -R dev:dev /home/dev /workspace


# ================================
# 1️⃣0️⃣ Cambiar a usuario dev
# ================================
USER dev
WORKDIR /workspace

# ================================
# Oh My Zsh (usuario dev)
# ================================
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# ================================
# Powerlevel10k
# ================================
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    /home/dev/.oh-my-zsh/custom/themes/powerlevel10k
# después de USER dev
RUN curl -fsSL https://bun.sh/install | bash

# ================================
# 1️⃣1️⃣ Comando de entrada
# ================================
CMD ["tmux", "new-session", "-A", "-s", "BUFF1", "zsh"]

# como seria un ejemplo de montar carpeta en windows powershell
# docker build -t d-env .
# docker run -it --name cp-env -p 8000:8000 -p 5173:5173 -v "C:\Users\Recimetal\Proyectos:/workspace" d-env
# docker start -ai cp-env
