# Actividad: Git y GitHub - Flujo de Trabajo Básico

## **Actividad Individual: Mi Portafolio Personal (`my-portfolio`)**

**Duración estimada:** 1 hora 30 minutos

**Objetivo:** Practicar los conceptos fundamentales de Git y GitHub mediante el desarrollo de un portafolio personal web. Aprenderás a: crear repositorios, hacer commits, trabajar con ramas, resolver conflictos, subir a GitHub y hacer tu primer Pull Request.

**Requisitos previos:**
- Git instalado en tu ordenador
- Cuenta de GitHub creada
- Editor de código (VS Code recomendado)
- Conocimientos básicos de HTML/CSS

---

## ⏱️ Distribución del Tiempo

| **Fase** | **Tiempo** | **Objetivo** |
|----------|-----------|--------------|
| Fase 1: Configuración y primeros commits | 20 min | Git local, staging, commits |
| Fase 2: Conectar con GitHub | 15 min | Repositorio remoto, push |
| Fase 3: Ramas y fusiones | 25 min | Branches, merge básico |
| Fase 4: Conflictos de merge | 20 min | Resolver conflictos manualmente |
| Fase 5: Pull Request | 10 min | Colaboración en GitHub |

**Total:** 90 minutos

---

## 🚀 FASE 1: Configuración y Primeros Commits (20 minutos)

### **Paso 1.1: Configurar tu identidad en Git**

**Objetivo:** Antes de empezar a usar Git, debes identificarte. Cada commit que hagas quedará registrado con tu nombre y email.

**Tareas:**
- Configura tu nombre de usuario en Git de forma global
- Configura tu dirección de email
- Verifica que la configuración se haya aplicado correctamente

**¿Qué comandos necesitas usar?** Piensa en el comando de Git que permite establecer opciones de configuración. Recuerda usar el flag `--global` para que se aplique a todos tus proyectos.

**Resultado esperado:** Al verificar tu configuración, deberías ver tu nombre y email listados.

---

### **Paso 1.2: Inicializar tu primer repositorio Git**

**Objetivo:** Crear un nuevo proyecto de portafolio y prepararlo para usar Git como sistema de control de versiones.

**Tareas:**
1. Crea un directorio llamado `my-portfolio` en tu sistema
2. Navega dentro de ese directorio
3. Inicializa un repositorio Git vacío en esa ubicación
4. Verifica el estado del repositorio

**¿Qué comando convierte una carpeta normal en un repositorio Git?**

**Resultado esperado:** 
- Deberías ver un mensaje confirmando que se ha creado un repositorio Git vacío
- Al verificar el estado, Git te dirá que estás en la rama `main` (o `master`) y que aún no hay commits

---

### **Paso 1.3: Crear la estructura base del portafolio**

**Objetivo:** Crear los archivos HTML y CSS iniciales para tu portafolio web.

**Tareas:**
1. Crea un archivo `index.html` con la estructura básica de una página web que incluya:
   - Cabecera (`<header>`) con el título "Mi Portafolio Personal"
   - Navegación (`<nav>`) con enlaces a tres secciones: Sobre Mí, Proyectos, Contacto
   - Área principal (`<main>`) con una sección "Sobre Mí" que de momento solo tenga el texto "Próximamente..."
   - Pie de página (`<footer>`) con el copyright de 2025
   - Un enlace a una hoja de estilos `style.css`

2. Crea un archivo `style.css` con estilos básicos:
   - Reset de márgenes y padding
   - Fuente sans-serif para el body
   - Fondo gris claro (#f0f0f0)
   - Cabecera con fondo oscuro (#2c3e50), texto blanco y centrado
   - Enlaces de navegación en blanco sin subrayado
   - Contenido principal centrado con ancho máximo de 1200px

**Resultado esperado:** Deberías poder abrir `index.html` en un navegador y ver una página web básica con cabecera oscura, contenido centrado y estilos aplicados.

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Portafolio</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Mi Portafolio Personal</h1>
        <nav>
            <a href="#sobre-mi">Sobre Mí</a>
            <a href="#proyectos">Proyectos</a>
            <a href="#contacto">Contacto</a>
        </nav>
    </header>
    <main>
        <section id="sobre-mi">
            <h2>Sobre Mí</h2>
            <p>Próximamente...</p>
        </section>
    </main>
    <footer>
        <p>&copy; 2025 Mi Portafolio</p>
    </footer>
</body>
</html>
```

Crea un archivo `style.css`:

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    color: #333;
}

header {
    background-color: #2c3e50;
    color: white;
    padding: 2rem;
    text-align: center;
}

nav a {
    color: white;
    margin: 0 1rem;
    text-decoration: none;
}

main {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 2rem;
}
```
---

### **Paso 1.4: Preparar archivos para el primer commit**

**Objetivo:** Entender el concepto de "staging area" y crear tu primera instantánea del proyecto.

**Tareas:**
1. Verifica el estado actual de tu repositorio. ¿Qué archivos aparecen?
2. Los archivos deberían aparecer como "Untracked files" (archivos sin rastrear). Añade TODOS los archivos al área de preparación (staging area)
3. Vuelve a verificar el estado. ¿Cómo han cambiado los archivos?
4. Crea tu primera instantánea (commit) con un mensaje descriptivo que indique que has creado la estructura base

**Resultado esperado:** 
- Los archivos deben pasar de "Untracked" (rojo) a "Changes to be committed" (verde)
- Después del commit, el directorio de trabajo debe estar limpio
- Al ver el historial con `git log --oneline`, debes ver tu commit

---

### **Paso 1.5: Modificar contenido y practicar el staging**

**Objetivo:** Practicar el ciclo completo: modificar → staging → commit. Entender la diferencia entre `git diff` y `git diff --staged`.

**Tareas:**
1. Modifica `index.html`: reemplaza el texto "Próximamente..." en la sección "Sobre Mí" por:
   - Un párrafo que diga "Hola, soy estudiante de Desarrollo de Aplicaciones Web."
   - Otro párrafo que diga "Apasionado por la tecnología y el desarrollo web."

2. **ANTES de añadir al staging**, usa el comando adecuado para ver las diferencias de lo que has modificado

3. Añade SOLO el archivo `index.html` al staging area (no uses `git add .`, sé específico)

4. Usa el comando que muestra las diferencias de los archivos que YA están en el staging area

5. Crea un commit con el mensaje: `"feat: Añadir sección Sobre Mí"`

6. Visualiza el historial de commits de forma compacta

**Preguntas de reflexión:**
- ¿Cuál es la diferencia entre `git diff` y `git diff --staged`?
- ¿Por qué es útil el staging area en vez de commitear directamente?

**Resultado esperado:** Debes tener 2 commits en tu rama `main`, y al abrir `index.html` en el navegador deberías ver el contenido actualizado.

**✅ Checkpoint 1:** Tienes 2 commits en `main` y entiendes el flujo: Working Directory → Staging Area → Repository.

---

## 🌐 FASE 2: Conectar con GitHub (15 minutos)

### **Paso 2.1: Crear repositorio remoto en GitHub**

**Objetivo:** Crear un repositorio remoto en GitHub para alojar tu código y compartirlo.

**Tareas:**
1. Accede a [github.com](https://github.com) con tu cuenta
2. Crea un nuevo repositorio con estas características:
   - **Nombre:** `my-portfolio`
   - **Descripción:** "Mi portafolio personal web"
   - **Visibilidad:** Público (para que otros puedan verlo)
   - ⚠️ **MUY IMPORTANTE:** NO marques "Add a README file" (ya tienes archivos en tu repositorio local)
3. Una vez creado, copia la URL HTTPS del repositorio

**Resultado esperado:** Deberías ver una página con instrucciones para "push an existing repository from the command line". Esta es la que necesitamos.

---

### **Paso 2.2: Vincular tu repositorio local con GitHub**

**Objetivo:** Conectar tu repositorio local con el remoto de GitHub y subir tus commits.

**Tareas:**
1. Añade una referencia remota llamada `origin` que apunte a la URL de tu repositorio de GitHub
2. Verifica que el remoto se ha configurado correctamente
3. Sube tu rama `main` al repositorio remoto. Usa el flag `-u` para establecer el tracking

**Nota:** GitHub puede pedirte autenticación. Si usa token de acceso personal, necesitarás generarlo en Configuración → Developer settings → Personal access tokens.

**Resultado esperado:** Deberías ver un progreso de subida y un mensaje confirmando que tu rama `main` ha sido enviada a `origin/main`.

---

### **Paso 2.3: Verificar en la interfaz de GitHub**

**Objetivo:** Confirmar que tu código está correctamente subido y explorar la interfaz de GitHub.

**Tareas:**
1. Actualiza la página de tu repositorio en GitHub (F5)
2. Verifica que aparecen tus archivos: `index.html` y `style.css`
3. Haz clic en la pestaña "Commits" o en el número de commits (debería decir "2 commits")
4. Explora cada commit: fecha, autor, mensaje, archivos cambiados
5. Haz clic en un archivo para ver su contenido

**Preguntas de reflexión:**
- ¿Qué información puedes ver en GitHub sobre cada commit?
- ¿Cómo se visualizan los cambios (diff) en GitHub?

**✅ Checkpoint 2:** Tu código está en GitHub, es público y accesible desde cualquier lugar. Tienes tu primera "copia de seguridad" en la nube.

---

## 🌿 FASE 3: Trabajar con Ramas (25 minutos)

### **Paso 3.1: Crear rama para nueva funcionalidad (proyectos)**

**Objetivo:** Entender el concepto de ramas como líneas de desarrollo paralelas. Las ramas permiten trabajar en nuevas características sin afectar el código principal.

**Tareas:**
1. Visualiza qué ramas existen actualmente (solo debería existir `main`)
2. Crea una nueva rama llamada `feature-proyectos` y cámbiate a ella en un solo comando
3. Verifica en qué rama estás trabajando ahora


**Resultado esperado:** Deberías ver `* feature-proyectos` al listar las ramas.

---

### **Paso 3.2: Desarrollar funcionalidad en la rama**

**Objetivo:** Realizar cambios en una rama aislada sin afectar `main`.

**Tareas:**
1. Modifica `index.html`: añade una nueva sección `<section id="proyectos">` DESPUÉS de la sección "Sobre Mí"
   - Título `<h2>Mis Proyectos</h2>`
   - Dos proyectos dentro de `<div class="proyecto">`:
     * **Proyecto 1:** "Blog Personal" - descripción: "Un blog desarrollado con HTML, CSS y JavaScript."
     * **Proyecto 2:** "Calculadora" - descripción: "Calculadora web interactiva."

2. Añade estilos en `style.css` para la clase `.proyecto`:
   - Fondo blanco
   - Padding de 1.5rem
   - Margen vertical de 1rem
   - Bordes redondeados (border-radius: 8px)
   - Sombra sutil: `box-shadow: 0 2px 4px rgba(0,0,0,0.1)`

3. Añade los cambios al staging y crea un commit con mensaje: `"feat: Añadir sección de proyectos"`

4. Visualiza el historial de commits en formato compacto

**Resultado esperado:** Un nuevo commit en la rama `feature-proyectos`. Si abres `index.html` verás la sección de proyectos estilizada.

---

### **Paso 3.3: Crear segunda rama desde main**

**Objetivo:** Practicar el trabajo con múltiples ramas paralelas.

**Tareas:**
1. Vuelve a la rama `main`
2. ⚠️ **MUY IMPORTANTE:** Abre `index.html` y verifica que NO aparece la sección de proyectos (porque ese cambio está solo en la rama `feature-proyectos`)
3. Desde `main`, crea una nueva rama llamada `feature-contacto` y cámbiate a ella

**Pregunta de reflexión:** ¿Por qué al volver a `main` desaparecen los cambios de la rama `feature-proyectos`?

**Resultado esperado:** Estás en `feature-contacto`, que es idéntica a `main` (sin la sección de proyectos).

---

### **Paso 3.4: Desarrollar formulario de contacto**

**Objetivo:** Añadir una nueva funcionalidad en una rama separada.

**Tareas:**
1. En `index.html`, añade una nueva sección `<section id="contacto">` al final del body:
   - Título: `<h2>Contacto</h2>`
   - Un formulario `<form>` con:
     * Input text para nombre (placeholder: "Tu nombre", required)
     * Input email (placeholder: "Tu email", required)
     * Textarea para mensaje (placeholder: "Tu mensaje", 5 filas, required)
     * Botón submit con texto "Enviar"

2. En `style.css`, añade estilos para el formulario:
   - Display flex, dirección columna
   - Ancho máximo 500px
   - Gap de 1rem entre elementos
   - Para inputs y textarea: padding 0.8rem, borde 1px gris claro (#ddd), bordes redondeados
   - Para el botón: fondo oscuro (#2c3e50), texto blanco, padding 0.8rem, sin borde, cursor pointer
   - Efecto hover en botón: fondo un poco más claro (#34495e)

3. Commitea los cambios con el mensaje: `"feat: Añadir formulario de contacto"`

**Resultado esperado:** La rama `feature/contacto` tiene el formulario, pero la rama `main` y `feature/proyectos` NO lo tienen.

---

### **Paso 3.5: Fusionar ramas en main**

**Objetivo:** Integrar las funcionalidades desarrolladas en ramas al código principal mediante merge.

**Tareas:**
1. Vuelve a la rama `main`
2. **ANTES de fusionar**, visualiza el contenido de `index.html` (puedes usar `cat`, `type` o abrirlo en VS Code). Verifica que NO tiene ni proyectos ni contacto
3. Fusiona la rama `feature/proyectos` en `main`
4. Visualiza nuevamente `index.html`. ¿Qué ha cambiado?
5. Fusiona la rama `feature/contacto` en `main`
6. Visualiza el historial completo con un gráfico visual de las ramas

**Preguntas de reflexión:**
- ¿Qué tipo de merge se ha producido en cada caso? (fast-forward o merge commit)
- ¿Por qué `main` ahora tiene ambas funcionalidades?

**Resultado esperado:** La rama `main` tiene ahora AMBAS secciones (proyectos y contacto). El historial muestra las dos ramas fusionadas.

**✅ Checkpoint 3:** Tienes al menos 5 commits en `main` y comprendes cómo las ramas permiten desarrollo paralelo.

---

## ⚠️ FASE 4: Gestionar Conflictos (20 minutos)

### **Paso 4.1: Simular desarrollo paralelo en main**

**Objetivo:** Crear la situación que genera un conflicto: dos ramas modificando las mismas líneas del mismo archivo.

**Tareas:**
1. Asegúrate de estar en la rama `main`
2. Abre `style.css` y modifica las propiedades del `body`:
   - Cambia el `font-family` a: `'Arial', sans-serif`
   - Cambia el `background-color` a: `#ffffff` (blanco)
   - Cambia el `color` a: `#333` (gris oscuro)
3. Añade y commitea con el mensaje: `"style: Actualizar diseño base"`

**Resultado esperado:** Un nuevo commit en `main` que modifica `style.css`.

---

### **Paso 4.2: Desarrollar en rama paralela**

**Objetivo:** Crear otra rama que también modifique las MISMAS líneas de `style.css`.

**Tareas:**
1. Crea una nueva rama llamada `feature-estilos` DESDE el commit ANTERIOR al que acabas de hacer
   - **Pista:** Usa `git log --oneline` para ver los commits
   - Necesitarás usar `git checkout -b feature-estilos HEAD~1` (HEAD~1 significa "un commit antes del actual")
   
2. En `style.css`, modifica las MISMAS propiedades del `body` pero con valores diferentes:
   - Cambia `font-family` a: `'Segoe UI', Tahoma, Geneva, Verdana, sans-serif`
   - Cambia `background-color` a: `#e8f4f8` (azul claro)
   - Cambia `color` a: `#2c3e50` (azul oscuro)

3. Añade solo `style.css` al staging y commitea con mensaje: `"style: Cambiar colores y tipografía"`

**Pregunta de reflexión:** ¿Por qué estamos modificando intencionalmente las mismas líneas que en `main`?

**Resultado esperado:** Dos ramas (`main` y `feature-estilos`) con cambios diferentes en las mismas líneas de `style.css`. Esto garantiza un conflicto.

---

### **Paso 4.3: Provocar el conflicto**

**Objetivo:** Intentar fusionar una rama cuando hay cambios conflictivos.

**Tareas:**
1. Vuelve a la rama `main`
2. Intenta fusionar la rama `feature-estilos` en `main`

**¿Qué ocurre?**
Deberías ver un mensaje de error:
```
Auto-merging style.css
CONFLICT (content): Merge conflict in style.css
Automatic merge failed; fix conflicts and then commit the result.
```

3. Ejecuta `git status`. Verás que `style.css` aparece como "both modified"

**Resultado esperado:** Git no puede fusionar automáticamente porque las mismas líneas han sido modificadas de formas diferentes. Necesitas intervención manual.

---

### **Paso 4.4: Entender los marcadores de conflicto**

**Objetivo:** Aprender a leer e interpretar los marcadores de conflicto de Git.

**Tareas:**
1. Abre `style.css` en tu editor de código
2. Busca las líneas que contienen marcadores especiales:
   - `<<<<<<< HEAD` (inicio de los cambios en la rama actual)
   - `=======` (separador)
   - `>>>>>>> feature/estilos` (cambios de la rama que intentas fusionar)

**Pregunta de reflexión:** ¿Cuáles son los cambios de cada rama? ¿Qué version prefieres mantener?

---

### **Paso 4.5: Resolver el conflicto manualmente**

**Objetivo:** Decidir qué cambios mantener y completar el merge.

**Tareas:**
1. Edita manualmente `style.css` para quedarte con la versión que prefieras (o combinación de ambas):
   - **Opción recomendada:** Mantener los valores de `feature/estilos` (más modernos)
   - Elimina TODOS los marcadores de conflicto: `<<<<<<<`, `=======`, `>>>>>>>`
   - El resultado final debe ser código CSS válido, sin marcadores

2. Guarda el archivo

3. Marca el conflicto como resuelto añadiendo el archivo al staging

4. Completa el merge con un commit. Git propondrá un mensaje por defecto, puedes usarlo o cambiarlo a: `"Merge: Resolver conflicto de estilos"`

5. Visualiza el historial con gráfico para ver el merge

**¿Qué comandos necesitas?**
- `git add` para marcar como resuelto
- `git commit` para completar el merge
- `git log --oneline --graph --all` para visualizar

**Resultado esperado:** El archivo `style.css` tiene un solo conjunto de valores (sin marcadores), el merge está completo, y el historial muestra la fusión de ambas ramas.

---

### **Paso 4.6: Sincronizar con GitHub**

**Objetivo:** Subir los cambios incluyendo el merge con conflicto resuelto.

**Tareas:**
1. Sube la rama `main` actualizada a GitHub
2. Verifica en GitHub que aparece el commit del merge

**Resultado esperado:** GitHub muestra el historial completo con el merge de resolución de conflicto.

**✅ Checkpoint 4:** Has experimentado, entendido y resuelto tu primer conflicto de merge. Comprendes que los conflictos ocurren cuando dos ramas modifican las mismas líneas.

---

## 🔄 FASE 5: Pull Request Básico (10 minutos)

### **Paso 5.1: Crear funcionalidad en nueva rama**

**Objetivo:** Practicar el flujo de trabajo con Pull Requests, la forma profesional de integrar código.

**Tareas:**
1. Asegúrate de estar en `main` y que esté actualizada con `git pull origin main`
2. Crea una nueva rama llamada `feature-social-links` y cámbiate a ella
3. Modifica el `<footer>` en `index.html`:
   - Añade un nuevo párrafo con el texto "Sígueme en:"
   - Añade dos enlaces:
     * GitHub: `<a href="https://github.com/tu-usuario">GitHub</a>`
     * LinkedIn: `<a href="https://linkedin.com/in/tu-usuario">LinkedIn</a>`
   - Separa los enlaces con el símbolo `|`
4. Commitea con mensaje: `"feat: Añadir enlaces a redes sociales en footer"`
5. Sube ESTA RAMA a GitHub (no `main`)

**Resultado esperado:** La rama `feature-social-links` existe en GitHub pero AÚN NO se ha fusionado en `main`.

---

### **Paso 5.2: Interactuando con la interfz de Github**

**Objetivo:** Usar la interfaz de GitHub para proponer cambios mediante un Pull Request.

**Tareas:**
1. Ve a tu repositorio en GitHub y actualiza la página (F5)
2. Deberías ver un banner amarillo indicando: **"feature-social-links had recent pushes"**
3. Haz clic en el botón verde **"Compare & pull request"**
4. Completa el formulario del Pull Request:
   - **Título:** `Añadir enlaces a redes sociales`
   - **Descripción:** Escribe un texto breve explicando qué has añadido:
     ```
     ## Descripción
     Añadidos enlaces a GitHub y LinkedIn en el footer del portafolio.
     
     ## Tipo de cambio
     - [x] Nueva funcionalidad
     
     ## Checklist
     - [x] El código está probado
     - [x] Los enlaces son correctos
     ```
5. Verifica que la base es `main` y el compare es `feature-social-links`
6. Haz clic en **"Create pull request"**

**Resultado esperado:** Un Pull Request abierto, visible en la pestaña "Pull requests" de tu repositorio.

---

### **Paso 5.3: Revisar y aprobar el Pull Request**

**Objetivo:** Entender el proceso de revisión de código antes de fusionar.

**Tareas:**
1. Haz clic en la pestaña **"Files changed"** dentro del Pull Request
2. Observa las líneas añadidas (en verde) y eliminadas (en rojo, si las hubiera)
3. Puedes añadir comentarios haciendo clic en el símbolo `+` junto a una línea
4. Vuelve a la pestaña **"Conversation"**
5. Haz clic en el botón verde **"Merge pull request"**
6. Confirma haciendo clic en **"Confirm merge"**
7. Opcionalmente, haz clic en **"Delete branch"** para limpiar la rama remota

**Preguntas de reflexión:**
- ¿Por qué es útil el Pull Request en lugar de fusionar directamente?
- ¿En qué situaciones es importante que otra persona revise tu código?

**Resultado esperado:** El Pull Request aparece como "Merged" y los cambios están ahora en la rama `main` de GitHub.

---

### **Paso 5.4: Sincronizar cambios localmente**

**Objetivo:** Traer a tu repositorio local los cambios que acabas de fusionar en GitHub.

**Tareas:**
1. Vuelve a la rama `main` en tu terminal local
2. Trae los cambios desde GitHub
3. Verifica que ahora `index.html` tiene los enlaces a redes sociales
4. Elimina tu rama local `feature-social-links` (ya está fusionada)

**Resultado esperado:** Tu repositorio local está sincronizado con GitHub. La rama `feature-social-links` ya no existe (ni local ni remotamente).

**✅ Checkpoint 5:** Has completado tu primer flujo completo de Pull Request: crear rama → desarrollar → subir → crear PR → revisar → fusionar → sincronizar.

---

## 🎯 Resumen Final

**¡Felicidades!** Has completado la práctica simplificada de Git y GitHub. Has aprendido a:

✅ **Configurar Git** y crear repositorios locales  
✅ **Hacer commits** y entender el staging area  
✅ **Conectar con GitHub** y sincronizar tu código  
✅ **Trabajar con ramas** para desarrollo paralelo  
✅ **Resolver conflictos** de merge manualmente  
✅ **Crear Pull Requests** para colaboración profesional  

### 📊 Contador de Commits

Al finalizar, deberías tener aproximadamente **8 commits** en tu rama `main`:
1. Initial commit: Estructura base
2. feat: Añadir sección Sobre Mí
3. feat: Añadir sección de proyectos (merge)
4. feat: Añadir formulario de contacto (merge)
5. style: Actualizar diseño base
6. Merge: Resolver conflicto de estilos
7. feat: Añadir enlaces a redes sociales (merge via PR)

## 📝 Entrega de la actividad

**Para completar la actividad, debes entregar:**

1. **URL de tu repositorio de GitHub** (público)
2. **Respuestas a las preguntas de reflexión** planteadas a lo largo de la práctica. Para ello crea en tu propio repositorio un archivo llamado "preguntas_reflexion.md" donde esten las preguntas y respuestas a las mismas.

---

## 🆘 Solución de Problemas Comunes

### Problema 1: "fatal: not a git repository"
**Solución:** Olvidaste hacer `git init`. Ejecuta el comando en la carpeta correcta.

### Problema 2: "Permission denied" al hacer push
**Solución:** 
- Verifica tu token de acceso personal de GitHub
- O usa SSH en vez de HTTPS

### Problema 3: "Your branch is behind 'origin/main'"
**Solución:** Haz `git pull origin main` antes de hacer push.

### Problema 4: No sé en qué rama estoy
**Solución:** Ejecuta `git branch` (la rama con `*` es la actual).

### Problema 5: Conflicto de merge y no sé qué hacer
**Solución:**
1. Abre el archivo conflictivo
2. Busca los marcadores `<<<<<<<`, `=======`, `>>>>>>>`
3. Edita manualmente dejando solo el código que quieres
4. Elimina los marcadores
5. Guarda el archivo
6. Ejecuta `git add <archivo>` y luego `git commit`

---

## 📚 Recursos Adicionales

- [Pro Git Book (Español)](https://git-scm.com/book/es/v2)
- [Learn Git Branching (Interactive)](https://learngitbranching.js.org/?locale=es_ES)
- [GitHub Skills](https://skills.github.com/)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

---

**Fecha de creación:** 16 de noviembre de 2025  
**Módulo:** Despliegue de Aplicaciones Web (DAW)  
**Unidad:** UD1 - Git, GitHub y Documentación  
**Duración:** 90 minutos  
**Tipo:** Actividad individual práctica
