<!-- ---
title: "UD 6 - P2: CI/CD, documentación y GitHub Pages"
description: "Automatizar documentación con GitHub Actions y publicarla en GitHub Pages"
summary: "Actividad práctica para automatizar documentación HTML y publicarla en GitHub Pages, con generación multi-formato opcional."
authors:
  - Eduardo Fdez
date: 2025-12-01
icon:
permalink: /deaw/unidad6/p1.2
categories:
  - DAWeb
tags:
  - CI/CD
  - GitHub Actions
  - Documentación
  - GitHub Pages
--- -->
# UD 1 - P02: CI/CD, documentación y GitHub Pages

## Relación 2

### Descripción

**Actividad:** *Documentación Automatizada y Publicación en GitHub Pages*

Vas a partir de este **[repositorio base](https://github.com/revilofe/2526_DAW_u1_action)** que contiene:

* `main.py` — programa sencillo.
* `test_main.py` — test unitario.
* `update_readme.py` — ejecuta los tests y actualiza el `README.md`.
* `.github/workflows/ci.yml` — *workflow* básico que ejecuta el script y realiza *commit* automático usando `git-auto-commit-action`.

#### Objetivo general

Aprender, de forma incremental, a:

* Generar documentación **en formato HTML** de forma automática.
* **Publicar** la documentación en **GitHub Pages**.
* Automatizar todo el proceso con **GitHub Actions** (CI/CD).
* (Opcional) Generar documentación en **formatos adicionales** (PDF, Markdown, etc.).

---

### Contexto de trabajo

En la primera parte, trabajarás **sobre tu *fork*** del repositorio base. Deberás ejecutar y **entender** el script y el *workflow* inicial, y después **mejorarlo**. 

Para la segunda y tercera parte, debes usar **tu propio proyecto**, el que usarás para desarrollar el proyecto intermodular que se realizará durante el ciclo.

Se espera un nivel mínimo común obligatorio (Parte 1 y 2) y la posibilidad de profundizar con formatos adicionales (Parte 3 opcional).

---

### 🔹 Parte 1: Workflow básico (comprensión y validación)

1. **Clona** tu *fork* del repositorio base.
2. **Lee y comprende**:

    * Qué hace `update_readme.py`.
    * Qué hace el *job* definido en `.github/workflows/ci.yml`.

3. **Ejecuta el workflow manualmente** (evento `workflow_dispatch` desde la pestaña *Actions*):

    * Fuerza **tests correctos** para ver el mensaje ✅ en `README.md`.
    * Fuerza **tests fallidos** para ver el mensaje ❌ en `README.md`.

4. Observa el ciclo: **evento → ejecución → modificación → *commit* automático** y confirma en el historial de *commits*.

> Esta parte te ha servido para tener una primera toma de contacto y entender todo el proceso o preguntar las dudas para llegar a entenderlo. No se entrega. 

---

### 🔹 Parte 2: Documentación HTML y publicación en GitHub Pages (nivel básico - OBLIGATORIO)

#### A. Trabajo técnico: generación automática de documentación HTML y publicación

Prepara tu proyecto intermodular para **la generación de documentación en HTML** de forma automática con GitHub Actions y **publica el resultado en GitHub Pages**.

**Sugerencias para Python:**

* Formato / Estilo de documentación: **reStructuredText** o **Google Style**.
* Herramienta: **Sphinx** o **pdoc** para generar HTML.
* Comandos ejemplo:
  * Sphinx: `sphinx-build -b html docs/source docs/build/html`
  * pdoc: `pdoc --html -o docs/ src/`

**Sugerencias para Java:**

* Formato / Estilo de documentación: **JavaDoc** (estándar de Java).
* Herramienta: **Javadoc** (incluido en el JDK).
* Comandos ejemplo:
  * Comando directo: `javadoc -d docs/javadoc -sourcepath src -subpackages com.tuempresa`
  * Maven: `mvn javadoc:javadoc`
  * Gradle: `./gradlew javadoc`

**Sugerencias para JavaScript/TypeScript:**

* Formato / Estilo de documentación: **JSDoc** o **TSDoc**.
* Herramienta: **JSDoc** o **TypeDoc**.
* Comandos ejemplo:
  * JSDoc: `jsdoc src/ -d docs/`
  * TypeDoc: `typedoc --out docs/ src/`

**Requisitos mínimos obligatorios:**

1. **Documenta tu código** según el estilo del lenguaje elegido (JavaDoc, docstrings, JSDoc, etc.).
2. **Genera documentación HTML localmente** y verifica que funciona correctamente.
3. **Crea un workflow** en `.github/workflows/` que:
   * Instale las dependencias necesarias (JDK, Python, Node.js, etc.).
   * **Genere la documentación HTML** automáticamente.
   * **Publique el resultado en GitHub Pages** usando la acción `peaceiris/actions-gh-pages@v3`.
4. **Configura GitHub Pages** en tu repositorio:
   * Ve a **Settings** → **Pages**.
   * Selecciona como fuente: **Deploy from a branch** → **gh-pages**.
5. **Verifica** que la documentación es accesible públicamente en:
   * `https://TU-USUARIO.github.io/TU-REPOSITORIO/`

**Ejemplo de workflow básico:**

```yaml
name: Generar y Publicar Documentación

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout del código
        uses: actions/checkout@v4
      
      - name: Configurar entorno (Java/Python/Node)
        uses: actions/setup-java@v4  # o setup-python, setup-node
        with:
          distribution: 'temurin'
          java-version: '17'
      
      - name: Generar documentación HTML
        run: |
          javadoc -d docs -sourcepath src -subpackages com.example
      
      - name: Publicar en GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

> **Entregables de esta parte:** 
> - Enlace al repositorio con el workflow funcionando.
> - **Enlace público a GitHub Pages** con la documentación HTML visible.
> - El profesor verificará que la documentación está publicada y accesible.

---

#### B. Documentación del proceso y preguntas (evidencias)

**Actualiza tu `README.md`** para que incluya, con enlaces, **toda** esta información:

Ten en cuenta que el `README.md` es la **carta de presentación** de tu proyecto, y debe ser claro y completo.

* a) **Herramienta** usada para generar documentación HTML y **comandos** ejecutados.
* b) **Ejemplos de código documentado** (enlace a la fuente) y fragmento con las etiquetas/estructura usadas:
  * Para Python: docstrings, `:param`, `:return`, reStructuredText o Google Style
  * Para Java: JavaDoc con `@param`, `@return`, `@throws`, `@author`, `@version`
  * Para JavaScript/TypeScript: JSDoc/TSDoc con `@param`, `@returns`, `@throws`
* c) **Enlace público a GitHub Pages** donde se puede ver la documentación HTML.
* d) **Explicación del workflow** de publicación (pasos del job, eventos que lo disparan, acción `peaceiris/actions-gh-pages`).
* e) **Mensajes de *commit*** que evidencien la mejora: claros, descriptivos, en imperativo.
* f) **Cómo clonar/usar** el repositorio y regenerar la documentación localmente.

##### Cuestionario a responder (inclúyelo al final del `README.md`)

Las preguntas son obligatorias y clave para la evaluación, por tanto responde de forma clara, concisa y coherente.

|   CE  | Pregunta de evaluación asociada a la actividad                                                                                                                                                                                                                                          |
| :---: |:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **a** | **Identificación de herramientas de generación de documentación.** ¿Qué herramienta o generador (p. ej., Sphinx, pdoc, Javadoc, JSDoc, TypeDoc) utilizaste para crear la documentación HTML?                                                                                          |
| **b** | **Documentación de componentes.** Muestra un fragmento del código con comentarios/docstrings estructurados (p. ej., `:param`, `:return:`, `@param`, `@return`) que haya sido procesado por la herramienta. Comenta qué estilo de documentación has utilizado.                         |
| **c** | **Publicación en GitHub Pages.** ¿Qué **configuración** del workflow y del repositorio utilizaste para publicar la documentación en GitHub Pages? Explica los pasos clave (acción `peaceiris/actions-gh-pages`, configuración de Pages en Settings).                                  |
| **d** | **Colaboración.** Explica cómo **GitHub Pages** facilita compartir documentación actualizada con el equipo y usuarios externos. ¿Qué ventajas tiene frente a solo tener los archivos HTML en el repositorio?                                                                           |
| **e** | **Control de versiones.** Muestra **mensajes de *commit*** que evidencien la configuración del workflow de publicación. ¿Son claros y descriptivos? Justifícalo.                                                                                                                       |
| **f** | **Accesibilidad y seguridad.** ¿Cómo garantizas que la documentación en GitHub Pages es accesible públicamente pero el código fuente solo es accesible para personal autorizado? (repositorio privado vs. Pages público, configuración de visibilidad).                                |
| **g** | **Instalación/uso documentados.** Indica **dónde** en el `README.md` explicas cómo acceder a la documentación publicada en GitHub Pages y **dónde** detallas las herramientas y comandos usados para generarla.                                                                        |
| **h** | **Integración continua y despliegue continuo (CI/CD).** Justifica por qué el workflow utilizado implementa **CI/CD**. ¿Qué **evento** dispara automáticamente la generación y publicación de la documentación? ¿Por qué esto es despliegue continuo?                                   |

> Sugerencia: añade una sección final de **Conclusiones** en tu `README.md` resumiendo qué aprendiste sobre publicación automática, GitHub Pages y CI/CD.

---

### 🔹 Parte 3 (opcional, nivel intermedio)

**Generación de documentación en múltiples formatos**

Además de la documentación HTML publicada en GitHub Pages, genera documentación en **al menos un formato adicional** (PDF, Markdown, etc.).

**Sugerencias de herramientas:**

* **PDF**: Doxygen + LaTeX, wkhtmltopdf, Pandoc, sphinxcontrib-pdf
* **Markdown**: Dokka (Java/Kotlin), pdoc (Python), JSDoc con plugins
* **Otros**: XML, JSON, reStructuredText

**Requisitos:**

1. Extiende el workflow para generar el formato adicional.
2. **Sube el archivo como artefacto** del workflow usando `actions/upload-artifact@v4`.
3. O **haz commit del archivo** en una carpeta `docs/` del repositorio.
4. Documenta en el `README.md`:
   * Qué formato adicional generaste.
   * Qué herramienta y comandos usaste.
   * Dónde se puede acceder al archivo (artefacto o ruta en el repositorio).

**Ejemplo de extensión del workflow:**

```yaml
- name: Generar documentación en PDF
  run: |
    sudo apt-get install -y doxygen texlive-latex-base
    doxygen Doxyfile
    cd latex && make pdf
    cp refman.pdf ../docs/documentation.pdf

- name: Subir PDF como artefacto
  uses: actions/upload-artifact@v4
  with:
    name: documentacion-pdf
    path: docs/documentation.pdf
```

**Actualiza el cuestionario** con esta pregunta adicional:

|   CE  | Pregunta de evaluación asociada a la actividad                                                                                                                                                                    |
| :---: |:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **i** | **Multiformato (opcional).** ¿Qué **segundo formato** (además de HTML) generaste? Explica la **herramienta**, **configuración** y **comandos** utilizados. ¿Dónde se puede acceder a este formato?               |

---

## Entregables

1. **Enlace a tu repositorio** con el *workflow* funcionando (Runs visibles en *Actions*). Si el repositorio es privado, añade al profesor como colaborador.
2. **Enlace público a GitHub Pages** con la documentación HTML accesible.
3. **`README.md` actualizado** con:  
    * Herramienta y comandos utilizados.
    * Explicación del workflow de publicación.
    * **Enlace a GitHub Pages**.
    * Respuestas al **cuestionario (a–h)**.
    * Evidencias de *commits*.
4. (Opcional) **Formato adicional** (PDF, Markdown, etc.) accesible como artefacto o en el repositorio, con la pregunta **i** respondida.

---

### Evaluación

Se evaluará:

* **Documentación HTML** correctamente generada y **publicada en GitHub Pages** (obligatorio).
* **Workflow funcional** que automatiza la generación y publicación.
* **README.md completo** con todas las respuestas al cuestionario.
* **Calidad de los commits** (mensajes descriptivos y estructura lógica).
* (Opcional) **Formato adicional** correctamente generado y documentado.

---

### Condiciones de entrega

Las publicadas en la moodle del curso.

---

### Apoyo

* GitHub Actions (documentación): [https://docs.github.com/actions](https://docs.github.com/actions)
* Acciones útiles:
    * `actions/checkout`: [https://github.com/actions/checkout](https://github.com/actions/checkout)
    * `actions/setup-python`: [https://github.com/actions/setup-python](https://github.com/actions/setup-python)
    * `actions/setup-java`: [https://github.com/actions/setup-java](https://github.com/actions/setup-java)
    * `actions/setup-node`: [https://github.com/actions/setup-node](https://github.com/actions/setup-node)
    * `actions/upload-artifact`: [https://github.com/actions/upload-artifact](https://github.com/actions/upload-artifact)
    * `peaceiris/actions-gh-pages`: [https://github.com/peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages)

* Generadores de documentación:
    * **Sphinx** (Python): [https://www.sphinx-doc.org](https://www.sphinx-doc.org)
    * **pdoc** (Python): [https://pdoc.dev](https://pdoc.dev)
    * **Javadoc** (Java): [https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html)
    * **Dokka** (Kotlin/Java): [https://kotlinlang.org/docs/dokka-overview.html](https://kotlinlang.org/docs/dokka-overview.html)
    * **Doxygen** (multi-lenguaje): [https://www.doxygen.nl](https://www.doxygen.nl)
    * **JSDoc** (JavaScript): [https://jsdoc.app/](https://jsdoc.app/)
    * **TypeDoc** (TypeScript): [https://typedoc.org/](https://typedoc.org/)
    * **Pandoc** (multi-formato): [https://pandoc.org](https://pandoc.org)

* GitHub Pages:
    * Documentación oficial: [https://docs.github.com/pages](https://docs.github.com/pages)
    * Configuración: [https://docs.github.com/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site](https://docs.github.com/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)

* Ejemplos de proyectos en el repositorio: [Ver carpeta practica-u01-java-doc](../../practica-u01-java-doc/)
