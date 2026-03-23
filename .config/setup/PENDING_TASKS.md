# 🚀 Tareas Pendientes: Finalizar Setup Gentle AI

Para que todo el "ecosistema" funcione al 100%, ejecutá estos comandos dentro de la terminal de tu contenedor.

## 1. Instalar MCPs (Contexto y Memoria)
Estos habilitan el uso de documentación externa y memoria persistente (Engram).

```bash
# Registrar Engram (Memoria)
gemini config add mcp engram npx -y @gentleman-programming/engram

# Registrar Context7 (Documentación)
gemini config add mcp context7 npx -y @gentleman-programming/context7
```

## 2. Instalar Skills (Las 11 Fundamentales)
  - sdd-apply
  - sdd-archive
  - sdd-design
  - sdd-explore
  - sdd-init
  - sdd-propose
  - sdd-spec
  - sdd-tasks
  - sdd-verify
  - skill-creator

> [!TIP]
> Podés usar `/sdd-init` para que yo mismo te ayude a configurar el flujo SDD en cualquier proyecto nuevo.

## 3. Verificar Configuración
Una vez ejecutados los comandos, podés chequear que todo esté en orden con:

```bash
gemini config list
```

---
**¡Dale, loco! Con esto ya tenés el setup de un Senior Architect listo.**
