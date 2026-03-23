# Mi Stack de Desarrollo

Este documento detalla las tecnologías y dependencias esenciales para el entorno de desarrollo, sirviendo como referencia para verificar la configuración de futuros contenedores.

## 1. Entorno General

*   **Sistema Operativo:** Ubuntu (versión 24.04 o similar).
*   **Shell:** Zsh (con Oh My Zsh y Powerlevel10k para una mejor experiencia de terminal).
*   **Terminal:** Soporte para colores `xterm-256color`.
*   **Locale:** Configuración a `en_US.UTF-8`.

## 2. Herramientas Base del Sistema

Las siguientes herramientas deben estar presentes y accesibles globalmente:

*   `curl`
*   `git`
*   `tmux`
*   `ripgrep` (para búsquedas rápidas de archivos)
*   `fd-find` (para búsquedas rápidas de archivos, con alias `fd`)
*   `zsh`
*   `ca-certificates`
*   `build-essential` (para compilar software)
*   `unzip`
*   `locales`
*   `dos2unix` (para normalizar finales de línea)
*   `fastfetch` (para información del sistema)

## 3. Desarrollo Python (Backend)

Para el desarrollo de backend con Python:

*   **Entorno Python:**
    *   `python3` (versión 3.x, preferiblemente 3.10+)
    *   `python3-pip` (gestor de paquetes de Python)
    *   `python3-venv` (para gestión de entornos virtuales)
*   **Dependencias Globales de Python (instaladas en el entorno del contenedor):**
    *   `FastAPI` (framework web para construir APIs)
    *   `uvicorn[standard]` (servidor ASGI para ejecutar FastAPI, con extras para desarrollo como el auto-reinicio)
    *   `python-lsp-server` (servidor de lenguaje para Python, útil para Neovim).
*   **Dependencias Típicas a Nivel de Proyecto (instalar en virtualenv según el proyecto):**
    *   `Strawberry` (para GraphQL, si se elige esa arquitectura)
    *   `google-api-python-client` (para interactuar con APIs de Google)
    *   `argon2-cffi`, `passlib[argon2]`, `pyjwt` (para funcionalidades de autenticación y autorización)

## 4. Desarrollo JavaScript/TypeScript (Frontend)

Para el desarrollo de frontend con JavaScript/TypeScript:

*   **Entorno JavaScript/TypeScript:**
    *   `nodejs` (versión LTS)
    *   `npm` (gestor de paquetes de Node.js)
    *   `bun` (runtime y gestor de paquetes alternativo)
*   **Dependencias Globales de Node.js/TypeScript (instaladas en el entorno del contenedor):**
    *   `typescript` (compilador de TypeScript)
    *   `typescript-language-server` (servidor de lenguaje para TypeScript en Neovim).
    *   `svelte-language-server` (servidor de lenguaje para Svelte en Neovim).
*   **Dependencias Típicas a Nivel de Proyecto (instalar con npm/bun según el proyecto):**
    *   `SvelteKit` (framework para construir aplicaciones Svelte)
    *   `TailwindCSS` (framework CSS)
    *   `prettier` (para formateo de código)

## 5. Editor de Código

*   **NeoVim:**
    *   `NeoVim` (versión v0.11.4 o superior).
    *   **Configuración LSP:** Se requiere una configuración adecuada de NeoVim (ej. `nvim-lspconfig`, `mason.nvim`) para integrar y utilizar los servidores de lenguaje instalados (`python-lsp-server`, `typescript-language-server`, `svelte-language-server`). Los dotfiles (`init.lua`) deben estar copiados en `/home/dev/.config/nvim`.

## 6. Herramientas Adicionales

*   `@google/gemini-cli` (interfaz de línea de comandos de Gemini).
*   **Dotfiles:** `~/.zshrc`, `~/.tmux.conf`, `/home/dev/.config/nvim/init.lua` para la configuración del usuario `dev`.