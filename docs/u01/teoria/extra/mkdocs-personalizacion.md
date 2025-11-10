# Guía de Personalización de MkDocs

## Introducción

MkDocs es un generador de sitios estáticos orientado a documentación de proyectos. Se configura mediante el archivo `mkdocs.yml` en la raíz del proyecto. Esta guía explica las opciones de configuración, personalización de temas y extensiones disponibles.

---

## Estructura Básica del Proyecto

```
mi-proyecto/
├── mkdocs.yml          # Archivo de configuración
├── docs/               # Carpeta con documentación en Markdown
│   ├── index.md        # Página de inicio (obligatoria)
│   ├── guia.md
│   └── api.md
└── site/               # Carpeta generada con el HTML (no tocar)
```

---

## Configuración Básica

### Metadatos del Sitio

```yaml
site_name: Mi Proyecto
site_description: Documentación técnica del proyecto
site_author: Juan Pérez
site_url: https://mi-proyecto.com
```

| Campo | Descripción | Obligatorio |
|-------|-------------|-------------|
| `site_name` | Nombre del sitio web | ✅ Sí |
| `site_description` | Descripción para SEO | ❌ No |
| `site_author` | Autor del sitio | ❌ No |
| `site_url` | URL de producción | ❌ No |

### Directorios

```yaml
docs_dir: docs          # Carpeta con archivos Markdown (por defecto: docs)
site_dir: site          # Carpeta de salida HTML (por defecto: site)
```

---

## Navegación

### Navegación Automática

Si no defines `nav`, MkDocs genera la navegación automáticamente basándose en los archivos `.md` en la carpeta `docs/`.

### Navegación Manual

```yaml
nav:
  - 'Inicio': 'index.md'
  - 'Guía de Usuario': 'guia-usuario.md'
  - 'API':
      - 'Introducción': 'api/intro.md'
      - 'Referencia': 'api/referencia.md'
  - 'Acerca de': 'about.md'
```

**Características:**
- Soporta jerarquía multinivel
- Usa emojis para mejorar la navegación: `'📚 Documentación'`
- Las rutas son relativas a la carpeta `docs/`

### Enlazar Archivos Externos

```yaml
nav:
  - 'Javadoc': 'api/index.html'  # Archivo HTML generado externamente
```

---

## Temas

### Temas Incluidos por Defecto

MkDocs incluye dos temas base:

#### 1. **mkdocs** (tema por defecto)

```yaml
theme:
  name: mkdocs
```

Simple y básico, ideal para documentación rápida.

#### 2. **readthedocs**

```yaml
theme:
  name: readthedocs
```

Inspirado en Read the Docs, más completo que el tema por defecto.

### Tema Material (Recomendado)

El tema más popular y personalizable para MkDocs.

**Instalación:**
```bash
python -m pip install --user mkdocs-material
```

**Configuración básica:**
```yaml
theme:
  name: material
```

---

## Personalización del Tema Material

### Esquema de Colores

#### Colores Primarios y de Acento

```yaml
theme:
  name: material
  palette:
    primary: indigo      # Color principal del encabezado
    accent: pink         # Color de los elementos interactivos
```

**Colores disponibles:**
- `red`, `pink`, `purple`, `deep purple`
- `indigo`, `blue`, `light blue`, `cyan`
- `teal`, `green`, `light green`, `lime`
- `yellow`, `amber`, `orange`, `deep orange`
- `brown`, `grey`, `blue grey`
- `black`, `white`

#### Modo Oscuro / Claro

**Modo fijo:**
```yaml
theme:
  name: material
  palette:
    scheme: default     # Modo claro (default)
    # scheme: slate     # Modo oscuro
```

**Alternar entre modos:**
```yaml
theme:
  name: material
  palette:
    # Modo claro
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: blue
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Cambiar a modo oscuro
    
    # Modo oscuro
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: blue grey
      accent: teal
      toggle:
        icon: material/brightness-4
        name: Cambiar a modo claro
```

### Fuentes

```yaml
theme:
  name: material
  font:
    text: Roboto          # Fuente del texto
    code: Roboto Mono     # Fuente del código
```

**Fuentes populares de Google Fonts:**
- `Roboto`, `Open Sans`, `Lato`, `Montserrat`
- `Ubuntu`, `Raleway`, `Noto Sans`
- Código: `Roboto Mono`, `Fira Code`, `JetBrains Mono`

**Desactivar Google Fonts (usar fuentes locales):**
```yaml
theme:
  name: material
  font: false
```

### Idioma

```yaml
theme:
  name: material
  language: es  # Español
```

**Idiomas soportados:** `en` (inglés), `es` (español), `fr` (francés), `de` (alemán), `it` (italiano), `pt` (portugués), `ja` (japonés), `zh` (chino), entre otros.

### Logo e Icono

```yaml
theme:
  name: material
  logo: assets/logo.png           # Logo personalizado
  favicon: assets/favicon.ico     # Icono de la pestaña del navegador
```

**Usar iconos de Material Design:**
```yaml
theme:
  name: material
  icon:
    logo: material/library
    repo: fontawesome/brands/github
```

[Buscar iconos aquí](https://squidfunk.github.io/mkdocs-material/reference/icons-emojis/)

### Características (Features)

```yaml
theme:
  name: material
  features:
    # Navegación
    - navigation.tabs              # Pestañas en el encabezado
    - navigation.tabs.sticky       # Pestañas fijas al hacer scroll
    - navigation.sections          # Secciones expandibles
    - navigation.expand            # Expandir secciones por defecto
    - navigation.indexes           # Páginas índice en secciones
    - navigation.top               # Botón "volver arriba"
    - toc.integrate                # Tabla de contenidos en la barra lateral
    
    # Búsqueda
    - search.suggest               # Sugerencias de búsqueda
    - search.highlight             # Resaltar términos buscados
    - search.share                 # Compartir enlaces de búsqueda
    
    # Encabezado
    - header.autohide              # Ocultar encabezado al hacer scroll
    
    # Contenido
    - content.code.copy            # Botón copiar en bloques de código
    - content.code.annotate        # Anotaciones en código
```

### Ejemplo Completo de Tema Material

```yaml
theme:
  name: material
  language: es
  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: blue
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Modo oscuro
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: blue grey
      accent: teal
      toggle:
        icon: material/brightness-4
        name: Modo claro
  font:
    text: Roboto
    code: Roboto Mono
  logo: assets/logo.png
  favicon: assets/favicon.ico
  features:
    - navigation.tabs
    - navigation.tabs.sticky
    - navigation.sections
    - navigation.top
    - search.suggest
    - search.highlight
    - content.code.copy
```

---

## Plugins

Los plugins extienden la funcionalidad de MkDocs.

### Plugin de Búsqueda

**Incluido por defecto en MkDocs:**
```yaml
plugins:
  - search
```

**Configuración avanzada:**
```yaml
plugins:
  - search:
      lang: 
        - es
        - en
      separator: '[\s\-\.]+'
```

### Otros Plugins Útiles

#### 1. **minify** - Minificar HTML

**Instalación:**
```bash
python -m pip install --user mkdocs-minify-plugin
```

**Uso:**
```yaml
plugins:
  - search
  - minify:
      minify_html: true
```

#### 2. **git-revision-date-localized** - Fechas de modificación

**Instalación:**
```bash
python -m pip install --user mkdocs-git-revision-date-localized-plugin
```

**Uso:**
```yaml
plugins:
  - search
  - git-revision-date-localized:
      type: datetime
      locale: es
```

Muestra cuándo fue modificada cada página.

#### 3. **awesome-pages** - Navegación simplificada

**Instalación:**
```bash
python -m pip install --user mkdocs-awesome-pages-plugin
```

**Uso:**
```yaml
plugins:
  - search
  - awesome-pages
```

Permite definir la navegación en archivos `.pages` en cada carpeta.

#### 4. **pdf-export** - Exportar a PDF

**Instalación:**
```bash
python -m pip install --user mkdocs-pdf-export-plugin
```

**Uso:**
```yaml
plugins:
  - search
  - pdf-export
```

---

## Extensiones de Markdown

Las extensiones añaden funcionalidades al procesamiento de Markdown.

### Extensiones Básicas

```yaml
markdown_extensions:
  - admonition              # Cajas de advertencia/nota
  - codehilite              # Resaltado de sintaxis
  - footnotes               # Notas al pie
  - toc:                    # Tabla de contenidos
      permalink: true       # Añadir anclas a encabezados
  - meta                    # Metadatos en archivos Markdown
```

### Extensiones Avanzadas

```yaml
markdown_extensions:
  # Advertencias y notas
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  
  # Bloques de código mejorados
  - pymdownx.highlight:
      anchor_linenums: true
      line_spans: __span
      pygments_lang_class: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  
  # Listas de tareas
  - pymdownx.tasklist:
      custom_checkbox: true
  
  # Emojis e iconos
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  
  # Tablas mejoradas
  - tables
  
  # Abreviaciones
  - abbr
  - pymdownx.snippets
  
  # Formato de texto
  - pymdownx.mark           # ==texto resaltado==
  - pymdownx.caret          # ^^subrayado^^
  - pymdownx.tilde          # ~~tachado~~
  - pymdownx.keys           # ++ctrl+alt+del++
  
  # Matemáticas
  - pymdownx.arithmatex:
      generic: true
```

### Ejemplos de Uso de Extensiones

#### Admonitions (Cajas de Advertencia)

```markdown
!!! note "Nota"
    Esto es una nota informativa.

!!! warning "Advertencia"
    Ten cuidado con esto.

!!! danger "Peligro"
    Esto puede causar problemas graves.

!!! tip "Consejo"
    Un consejo útil.

!!! info "Información"
    Información adicional.
```

#### Bloques de Código con Resaltado

````markdown
```python title="ejemplo.py" linenums="1"
def saludar(nombre):
    """Función que saluda a una persona."""
    return f"Hola, {nombre}!"

print(saludar("Mundo"))
```
````

#### Listas de Tareas

```markdown
- [x] Tarea completada
- [ ] Tarea pendiente
- [ ] Otra tarea pendiente
```

#### Tablas

```markdown
| Columna 1 | Columna 2 | Columna 3 |
|-----------|-----------|-----------|
| Dato 1    | Dato 2    | Dato 3    |
| Dato 4    | Dato 5    | Dato 6    |
```

#### Formato de Texto

```markdown
==Texto resaltado==
^^Texto insertado^^
~~Texto tachado~~
++ctrl+c++ para copiar
```

---

## CSS y JavaScript Personalizados

### Añadir CSS Personalizado

**1. Crear archivo CSS:**
```
docs/
├── stylesheets/
│   └── extra.css
```

**2. Referenciar en `mkdocs.yml`:**
```yaml
extra_css:
  - stylesheets/extra.css
```

**Ejemplo de `extra.css`:**
```css
/* Cambiar color de los encabezados */
.md-typeset h1 {
    color: #ff5722;
}

/* Personalizar bloques de código */
.highlight {
    border-left: 4px solid #2196f3;
    padding-left: 1rem;
}
```

### Añadir JavaScript Personalizado

**1. Crear archivo JS:**
```
docs/
├── javascripts/
│   └── extra.js
```

**2. Referenciar en `mkdocs.yml`:**
```yaml
extra_javascript:
  - javascripts/extra.js
```

**Ejemplo de `extra.js`:**
```javascript
// Añadir funcionalidad personalizada
document.addEventListener('DOMContentLoaded', function() {
    console.log('Documentación cargada');
});
```

---

## Variables Extra

Definir variables personalizadas reutilizables.

```yaml
extra:
  version: 1.0.0
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/usuario
      name: GitHub
    - icon: fontawesome/brands/twitter
      link: https://twitter.com/usuario
      name: Twitter
  analytics:
    provider: google
    property: G-XXXXXXXXXX
```

**Usar variables en Markdown:**
```markdown
Versión actual: {{ version }}
```

---

## Configuración del Copyright

```yaml
copyright: Copyright &copy; 2025 Mi Empresa
```

**Con enlaces:**
```yaml
copyright: |
  Copyright &copy; 2025 <a href="https://mi-empresa.com">Mi Empresa</a>
```

---

## Configuración de Repositorio

```yaml
repo_name: usuario/mi-repo
repo_url: https://github.com/usuario/mi-repo
edit_uri: edit/main/docs/  # Enlace para editar páginas
```

Añade un enlace al repositorio en el encabezado y permite editar páginas directamente en GitHub.

---

## Ejemplo de `mkdocs.yml` Completo

```yaml
# Metadatos
site_name: Mi Proyecto Profesional
site_description: Documentación técnica completa
site_author: Equipo de Desarrollo
site_url: https://mi-proyecto.com

# Repositorio
repo_name: usuario/mi-proyecto
repo_url: https://github.com/usuario/mi-proyecto
edit_uri: edit/main/docs/

# Copyright
copyright: Copyright &copy; 2025 Mi Empresa

# Tema
theme:
  name: material
  language: es
  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: blue
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Cambiar a modo oscuro
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: blue grey
      accent: teal
      toggle:
        icon: material/brightness-4
        name: Cambiar a modo claro
  font:
    text: Roboto
    code: Fira Code
  logo: assets/logo.png
  favicon: assets/favicon.ico
  features:
    - navigation.tabs
    - navigation.tabs.sticky
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.suggest
    - search.highlight
    - content.code.copy
    - content.code.annotate

# Navegación
nav:
  - 'Inicio': 'index.md'
  - 'Guía de Usuario':
      - 'Introducción': 'guia/intro.md'
      - 'Instalación': 'guia/instalacion.md'
      - 'Configuración': 'guia/config.md'
  - 'API':
      - 'Referencia': 'api/referencia.md'
      - 'Ejemplos': 'api/ejemplos.md'
  - 'Acerca de': 'about.md'

# Plugins
plugins:
  - search:
      lang: 
        - es
        - en
  - git-revision-date-localized:
      type: datetime
      locale: es
  - minify:
      minify_html: true

# Extensiones Markdown
markdown_extensions:
  # Contenido
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - toc:
      permalink: true
  
  # Código
  - pymdownx.highlight:
      anchor_linenums: true
      line_spans: __span
      pygments_lang_class: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  
  # Formato
  - pymdownx.mark
  - pymdownx.caret
  - pymdownx.tilde
  - pymdownx.keys
  
  # Listas
  - pymdownx.tasklist:
      custom_checkbox: true
  
  # Tablas
  - tables
  
  # Emojis
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  
  # Matemáticas
  - pymdownx.arithmatex:
      generic: true

# CSS y JavaScript extra
extra_css:
  - stylesheets/extra.css

extra_javascript:
  - javascripts/extra.js
  - javascripts/mathjax.js
  - https://polyfill.io/v3/polyfill.min.js?features=es6
  - https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js

# Variables extra
extra:
  version: 1.0.0
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/usuario/mi-proyecto
    - icon: fontawesome/brands/twitter
      link: https://twitter.com/usuario
  analytics:
    provider: google
    property: G-XXXXXXXXXX
```

---

## Comandos de MkDocs

### Desarrollo

```bash
# Iniciar servidor de desarrollo
python -m mkdocs serve

# En puerto personalizado
python -m mkdocs serve -a localhost:8080
```

### Construcción

```bash
# Generar sitio estático
python -m mkdocs build

# Limpiar y regenerar
python -m mkdocs build --clean

# Modo estricto (falla si hay advertencias)
python -m mkdocs build --strict
```

### Despliegue

```bash
# Desplegar a GitHub Pages
python -m mkdocs gh-deploy

# Desplegar con mensaje personalizado
python -m mkdocs gh-deploy -m "Actualización de documentación"
```

---

## Solución de Problemas Comunes

### 1. Tema Material no encontrado

**Error:** `ERROR - Config value 'theme': Unrecognised theme name: 'material'`

**Solución:**
```bash
python -m pip install --user mkdocs-material
```

### 2. Plugin no encontrado

**Error:** `ERROR - Config value 'plugins': Plugin 'nombre-plugin' not found`

**Solución:**
```bash
python -m pip install --user mkdocs-nombre-plugin
```

### 3. Archivos CSS/JS no se cargan

**Problema:** Los archivos extra no aparecen en el sitio.

**Solución:**
- Verificar que las rutas sean relativas a `docs/`
- Comprobar que los archivos existan
- Limpiar caché: `python -m mkdocs build --clean`

### 4. Cambios no se reflejan en el servidor

**Solución:**
- Reiniciar el servidor: `Ctrl+C` y `python -m mkdocs serve`
- Limpiar caché del navegador: `Ctrl+Shift+R`

---

## Recursos Adicionales

- **Documentación oficial MkDocs:** [https://www.mkdocs.org](https://www.mkdocs.org)
- **Material for MkDocs:** [https://squidfunk.github.io/mkdocs-material](https://squidfunk.github.io/mkdocs-material)
- **Catálogo de plugins:** [https://github.com/mkdocs/mkdocs/wiki/MkDocs-Plugins](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Plugins)
- **Markdown Extensions:** [https://python-markdown.github.io/extensions/](https://python-markdown.github.io/extensions/)
