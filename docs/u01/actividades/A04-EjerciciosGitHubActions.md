# Ejercicios Progresivos: GitHub Actions

## 📚 Fundamentos de GitHub Actions

### ¿Qué es GitHub Actions?

**GitHub Actions** es una plataforma de integración continua y entrega continua (CI/CD) que permite automatizar tareas de desarrollo, pruebas y despliegue directamente desde tu repositorio de GitHub. Puedes crear **workflows** (flujos de trabajo) que se ejecuten automáticamente en respuesta a eventos específicos.

### Conceptos Fundamentales

#### 1. **Workflow (Flujo de Trabajo)**
Un workflow es un proceso automatizado configurable que ejecuta uno o más jobs. Se define mediante archivos YAML ubicados en `.github/workflows/`.

**Características:**
- Se activa mediante eventos (push, pull_request, schedule, etc.)
- Puede contener múltiples jobs que se ejecutan en paralelo o secuencialmente
- Es versionado junto con tu código

**Ejemplo básico:**
```yaml
name: Mi Primer Workflow
on: push
jobs:
  saludo:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Hola desde GitHub Actions"
```

#### 2. **Events (Eventos)**
Los eventos son actividades específicas que disparan la ejecución de un workflow.

**Eventos más comunes:**
- `push` - Cuando se hace push de commits
- `pull_request` - Al crear/actualizar un PR
- `schedule` - Ejecución programada (cron)
- `workflow_dispatch` - Ejecución manual
- `release` - Al publicar un release

**Ejemplo con múltiples eventos:**
```yaml
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  workflow_dispatch:
```

#### 3. **Jobs**
Un job es un conjunto de steps que se ejecutan en el mismo runner (máquina virtual).

**Características:**
- Por defecto, los jobs se ejecutan en **paralelo**
- Pueden tener dependencias con `needs`
- Se ejecutan en runners independientes

**Ejemplo con dependencias:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building..."
  
  test:
    runs-on: ubuntu-latest
    needs: build  # Espera a que 'build' termine
    steps:
      - run: echo "Testing..."
```

#### 4. **Steps (Pasos)**
Los steps son tareas individuales dentro de un job. Pueden ejecutar comandos shell o usar actions.

**Tipos de steps:**
- **Comando shell:** `run: comando`
- **Action reutilizable:** `uses: actions/checkout@v4`

**Ejemplo:**
```yaml
steps:
  - name: Checkout código
    uses: actions/checkout@v4
  
  - name: Ejecutar tests
    run: npm test
```

#### 5. **Runners**
Los runners son servidores que ejecutan los workflows. GitHub proporciona runners hospedados.

**Runners disponibles:**
- `ubuntu-latest` (Ubuntu Linux)
- `windows-latest` (Windows Server)
- `macos-latest` (macOS)

También puedes configurar **self-hosted runners** (auto-hospedados).

#### 6. **Actions**
Las actions son aplicaciones reutilizables que realizan tareas complejas. Se encuentran en **GitHub Marketplace**.

**Actions oficiales más usadas:**
- `actions/checkout@v4` - Clona el repositorio
- `actions/setup-node@v4` - Configura Node.js
- `actions/upload-artifact@v4` - Sube artefactos
- `docker/build-push-action@v5` - Build y push de Docker

**Sintaxis:**
```yaml
- uses: actions/checkout@v4
  with:
    ref: main
```

#### 7. **Expressions y Context**
Las expresiones permiten acceder a información contextual del workflow.

**Variables de contexto comunes:**
- `${{ github.repository }}` - Nombre del repo
- `${{ github.actor }}` - Usuario que disparó el workflow
- `${{ github.sha }}` - Hash del commit
- `${{ secrets.MI_SECRET }}` - Acceso a secrets
- `${{ steps.id-paso.outputs.variable }}` - Output de un step

**Ejemplo:**
```yaml
- run: echo "Ejecutado por ${{ github.actor }}"
- run: echo "Repositorio: ${{ github.repository }}"
```

#### 8. **Matrix Strategy (Estrategia de Matriz)**
Permite ejecutar el mismo job con múltiples configuraciones.

**Ejemplo:**
```yaml
strategy:
  matrix:
    node-version: [16, 18, 20]
    os: [ubuntu-latest, windows-latest]

runs-on: ${{ matrix.os }}
steps:
  - uses: actions/setup-node@v4
    with:
      node-version: ${{ matrix.node-version }}
```

Esto crea **6 jobs** (3 versiones × 2 SO).

#### 9. **Artifacts (Artefactos)**
Los artefactos son archivos generados durante el workflow que se pueden descargar o compartir entre jobs.

**Ejemplo de subida:**
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: mi-build
    path: dist/
```

**Ejemplo de descarga:**
```yaml
- uses: actions/download-artifact@v4
  with:
    name: mi-build
    path: ./descargado
```

#### 10. **Secrets y Variables de Entorno**
Los secrets almacenan información sensible (tokens, contraseñas) de forma cifrada.

**Configuración:** Settings → Secrets and variables → Actions → New repository secret

**Uso:**
```yaml
env:
  API_KEY: ${{ secrets.MI_API_KEY }}

steps:
  - run: echo "La API key está protegida"
```

### Estructura de un Archivo YAML

```yaml
name: Nombre del Workflow        # Nombre descriptivo (opcional)

on:                              # Eventos que disparan el workflow
  push:
    branches: [main]
  pull_request:

env:                             # Variables de entorno globales
  NODE_VERSION: 20

jobs:                            # Definición de jobs
  build:                         # ID del job
    name: Build del Proyecto     # Nombre legible
    runs-on: ubuntu-latest       # Runner
    
    env:                         # Variables de entorno del job
      ENV: production
    
    steps:                       # Lista de pasos
      - name: Paso 1
        uses: actions/checkout@v4
      
      - name: Paso 2
        run: echo "Comando shell"
```

### Mejores Prácticas

✅ **Nomenclatura:** Usa nombres descriptivos para workflows, jobs y steps  
✅ **Versionado:** Especifica versiones en actions (`@v4`, no `@main`)  
✅ **Caché:** Usa caché para dependencias (`cache: 'npm'`)  
✅ **Secrets:** NUNCA hardcodees credenciales  
✅ **Fail-fast:** Configura `fail-fast: false` en matrices si quieres ver todos los resultados  
✅ **Condicionales:** Usa `if:` para ejecutar steps condicionalmente  
✅ **Timeouts:** Define `timeout-minutes` para evitar ejecuciones infinitas  

### Límites y Cuotas

**Repositorios públicos:**
- ✅ Minutos ilimitados en runners de GitHub

**Repositorios privados:**
- 📊 2000 minutos/mes (Free)
- 📊 3000 minutos/mes (Pro)

**Otros límites:**
- Máximo 1000 solicitudes API/hora
- Artefactos: retención de 90 días (configurable)
- Logs: retención de 400 días

---

## 📋 Índice de Ejercicios

| Ejercicio | Dificultad | Conceptos Clave |
|-----------|------------|-----------------|
| [Ejercicio 1](#ejercicio-1-mi-primer-workflow) | ⭐ Básico | Sintaxis básica, eventos, comandos shell |
| [Ejercicio 2](#ejercicio-2-workflow-con-múltiples-jobs) | ⭐⭐ Básico | Múltiples jobs, dependencias |
| [Ejercicio 3](#ejercicio-3-matriz-de-ejecución) | ⭐⭐⭐ Intermedio | Estrategia de matriz, variables |
| [Ejercicio 4](#ejercicio-4-artefactos-y-outputs) | ⭐⭐⭐ Intermedio | Artefactos, outputs entre jobs |
| [Ejercicio 5](#ejercicio-5-testing-y-despliegue-con-actions) | ⭐⭐⭐⭐ Avanzado | GitHub Marketplace Actions, testing |

---

## Ejercicio 1: Mi Primer Workflow

### 🎯 Objetivos de Aprendizaje
- Crear tu primer archivo de workflow
- Entender la estructura básica YAML
- Configurar eventos que disparan el workflow
- Ejecutar comandos shell básicos

### 📝 Descripción
Vas a crear un workflow simple que se ejecute cuando hagas push al repositorio. Este workflow imprimirá información básica del sistema y del repositorio.

### 🛠️ Instrucciones

#### Paso 1: Preparar el repositorio
1. Crea un nuevo repositorio en GitHub llamado `github-actions-lab`
2. Clónalo localmente
3. Crea la estructura de directorios para workflows

**Pregunta:** ¿En qué ruta exacta deben ubicarse los archivos de workflows de GitHub Actions?

#### Paso 2: Crear el workflow
Crea un archivo llamado `hello-world.yml` en la ubicación correcta con el siguiente esquema:

```yaml
name: [Elige un nombre descriptivo]

on: [¿Qué evento debe disparar el workflow?]

jobs:
  [nombre-del-job]:
    runs-on: [¿En qué sistema operativo se ejecutará?]
    
    steps:
      - name: [Paso 1: Saludar]
        run: |
          [Comando para imprimir "Hola desde GitHub Actions!"]
          
      - name: [Paso 2: Mostrar información del sistema]
        run: |
          [Comandos para mostrar: fecha actual, usuario, directorio actual]
          
      - name: [Paso 3: Variables de entorno de GitHub]
        run: |
          [Imprime las variables: GITHUB_REPOSITORY, GITHUB_REF, GITHUB_ACTOR]
```

#### Paso 3: Completar el workflow
Rellena los espacios marcados con `[]` considerando:
- El nombre debe ser descriptivo
- Debe ejecutarse en pushes a la rama `main`
- Usa `ubuntu-latest` como runner
- En Linux, usa `echo` para imprimir, `date` para la fecha, `whoami` para el usuario, `pwd` para el directorio
- Las variables de GitHub se acceden con `$GITHUB_VARIABLE`

#### Paso 4: Probar el workflow
1. Añade el archivo al staging
2. Haz commit con mensaje descriptivo
3. Sube los cambios a GitHub
4. Ve a la pestaña **Actions** en tu repositorio

**Preguntas de verificación:**
- ¿Aparece tu workflow en la lista?
- ¿Se ejecutó automáticamente?
- ¿Qué información muestra en los logs?

### ✅ Criterios de Éxito
- [ ] El workflow se ejecuta automáticamente al hacer push
- [ ] Los 3 pasos se completan exitosamente
- [ ] Los logs muestran toda la información solicitada
- [ ] El badge del workflow está en verde (✓)

### 🤔 Preguntas de Reflexión
1. ¿Qué diferencia hay entre `name` del workflow y `name` del step?
2. ¿Por qué es necesario el pipe `|` después de `run:`?
3. ¿Qué otros eventos podrían disparar este workflow?

---

## Ejercicio 2: Workflow con Múltiples Jobs

### 🎯 Objetivos de Aprendizaje
- Crear múltiples jobs en un workflow
- Establecer dependencias entre jobs con `needs`
- Trabajar con diferentes sistemas operativos
- Entender la ejecución paralela vs. secuencial

### 📝 Descripción
Vas a crear un workflow con 3 jobs que simulan un proceso de construcción (build), prueba (test) y despliegue (deploy). Los jobs deben ejecutarse en el orden correcto.

### 🛠️ Instrucciones

#### Paso 1: Diseñar la secuencia
**Antes de escribir código, responde:**
- ¿En qué orden deben ejecutarse los jobs?
- ¿Qué jobs pueden ejecutarse en paralelo?
- ¿Cuáles deben esperar a otros?

#### Paso 2: Crear el workflow
Crea un archivo `build-test-deploy.yml` con esta estructura:

```yaml
name: Build, Test y Deploy

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    name: Construcción del Proyecto
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout del código
        run: echo "Clonando repositorio..."
        
      - name: Simular construcción
        run: |
          echo "Compilando proyecto..."
          sleep 3
          echo "Construcción completada ✓"
          
      - name: Verificar artefactos
        run: |
          echo "Generando artefactos de construcción..."
          echo "Build #$GITHUB_RUN_NUMBER" > build-info.txt
          cat build-info.txt

  test:
    name: [Completa: Nombre del job de testing]
    runs-on: [¿Qué sistema operativo?]
    needs: [¿De qué job depende este?]
    
    steps:
      - name: Preparar entorno de pruebas
        run: [Imprime mensaje indicando preparación]
        
      - name: Ejecutar tests unitarios
        run: |
          [Simula ejecución de 3 tests con sleep 2]
          [Imprime "✓ Tests unitarios pasados"]
          
      - name: Ejecutar tests de integración
        run: |
          [Simula tests de integración]
          [Imprime resultado]

  deploy:
    name: [Completa: Nombre del job de despliegue]
    runs-on: [Sistema operativo]
    needs: [¿De qué jobs depende? Puede ser más de uno]
    
    steps:
      - name: [Paso de despliegue a staging]
        run: |
          [Simula despliegue con sleep]
          [Imprime URL ficticia: https://staging.miapp.com]
          
      - name: [Verificación post-despliegue]
        run: |
          [Simula health check]
          [Imprime estado: "Aplicación funcionando correctamente"]
```

#### Paso 3: Añadir job condicional
Añade un cuarto job llamado `notify` que:
- Se ejecute SOLO si todos los jobs anteriores fueron exitosos
- Use `ubuntu-latest`
- Dependa de `deploy`
- Imprima un mensaje de éxito con la hora actual

**Pista:** Necesitarás usar `needs: deploy`

#### Paso 4: Experimentar con fallos
1. Modifica el job `test` para que falle:
   ```yaml
   - name: Test que falla
     run: exit 1
   ```
2. Haz commit y push
3. Observa qué jobs se ejecutan y cuáles se omiten

**Preguntas:**
- ¿Se ejecutó el job `deploy`?
- ¿Por qué?
- ¿Cómo aparece el job `test` en la interfaz?

#### Paso 5: Corregir y ejecutar
1. Elimina la línea que causa el fallo
2. Haz commit y push
3. Verifica que todos los jobs se ejecuten correctamente

### ✅ Criterios de Éxito
- [ ] Los 4 jobs se ejecutan en el orden correcto
- [ ] `test` no empieza hasta que `build` termina
- [ ] `deploy` no empieza hasta que `test` termina
- [ ] Cuando un job falla, los dependientes no se ejecutan
- [ ] El workflow completo aparece en verde

### 🤔 Preguntas de Reflexión
1. ¿Qué ventaja tiene dividir un workflow en múltiples jobs?
2. Si dos jobs no tienen dependencias entre sí, ¿se ejecutan en paralelo o secuencialmente?
3. ¿Cómo cambiarías el workflow para que `deploy` se ejecute INCLUSO si `test` falla?

**Pista para la pregunta 3:** Investiga `if: always()` o `if: failure()`

---

## Ejercicio 3: Matriz de Ejecución

### 🎯 Objetivos de Aprendizaje
- Usar estrategias de matriz (`strategy.matrix`)
- Ejecutar el mismo workflow en múltiples configuraciones
- Trabajar con variables de matriz
- Entender cuándo usar matrices

### 📝 Descripción
Vas a crear un workflow que pruebe tu aplicación en múltiples versiones de Node.js y en diferentes sistemas operativos simultáneamente.

### 🛠️ Instrucciones

#### Paso 1: Crear aplicación de prueba
1. En la raíz de tu repositorio, crea un archivo `app.js`:

```javascript
const version = process.version;
const platform = process.platform;

console.log(`✓ Node.js ${version} ejecutándose en ${platform}`);
console.log(`Fecha: ${new Date().toISOString()}`);

// Simular algunas operaciones
const array = Array.from({length: 1000000}, (_, i) => i);
const sum = array.reduce((a, b) => a + b, 0);
console.log(`✓ Test de rendimiento completado: ${sum}`);

process.exit(0);
```

2. Haz commit y push del archivo

#### Paso 2: Crear workflow con matriz básica
Crea `matrix-test.yml`:

```yaml
name: Matrix Testing

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    name: Test Node ${{ matrix.node-version }} en ${{ matrix.os }}
    runs-on: ${{ matrix.os }}
    
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [14, 16, 18, 20]
    
    steps:
      - name: Checkout del repositorio
        run: echo "Clonando código..."
      
      - name: Mostrar información del entorno
        run: |
          echo "Sistema Operativo: ${{ matrix.os }}"
          echo "Versión de Node.js: ${{ matrix.node-version }}"
          echo "Runner: ${{ runner.os }}"
          
      - name: Simular instalación de Node.js
        run: |
          echo "Instalando Node.js ${{ matrix.node-version }}..."
          sleep 2
          
      - name: Ejecutar aplicación
        run: |
          echo "Ejecutando app.js..."
          echo "✓ Tests completados en Node ${{ matrix.node-version }}"
```

**Pregunta antes de continuar:** ¿Cuántos jobs se crearán con esta configuración de matriz? ¿Por qué?

#### Paso 3: Añadir combinaciones específicas
Modifica la matriz para:
1. **Excluir** la combinación `windows-latest` con `node-version: 14`
2. **Incluir** una combinación especial: `ubuntu-latest` con `node-version: 21` y una variable extra `experimental: true`

**Estructura a añadir:**
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    node-version: [14, 16, 18, 20]
    exclude:
      - [Completa: ¿cómo excluir windows con node 14?]
    include:
      - [Completa: ¿cómo incluir ubuntu con node 21 y experimental: true?]
```

#### Paso 4: Hacer la matriz configurable
Añade estas opciones a la estrategia:

```yaml
strategy:
  matrix:
    # ... tu matriz actual ...
  fail-fast: [¿true o false? ¿Qué hace esta opción?]
  max-parallel: [¿Cuántos jobs quieres ejecutar simultáneamente? Elige entre 1-5]
```

**Preguntas:**
- ¿Qué hace `fail-fast: false`?
- ¿Cuándo sería útil `max-parallel: 2`?

#### Paso 5: Probar y analizar
1. Haz commit y push
2. Ve a la pestaña Actions
3. Observa cómo se crean múltiples jobs en paralelo

**Preguntas de verificación:**
- ¿Cuántos jobs se ejecutaron en total?
- ¿Se excluyó correctamente Windows + Node 14?
- ¿Apareció el job con Node 21 (experimental)?
- ¿Qué jobs se ejecutaron primero?

### ✅ Criterios de Éxito
- [ ] Se ejecutan 11 jobs del test de Node.js (12 - 1 exclusión + 1 inclusión)
- [ ] La exclusión funciona correctamente
- [ ] La inclusión con variable extra aparece
- [ ] Todos los jobs se completan exitosamente

### 🤔 Preguntas de Reflexión
1. ¿Cuándo usarías una matriz en un proyecto real?
2. ¿Qué ventaja tiene probar en múltiples sistemas operativos?
3. ¿Por qué podría ser problemático `fail-fast: true` en algunos casos?
4. Si tienes 3 OS × 4 versiones de Node × 2 entornos, ¿cuántos jobs se crearían?

### 💡 Desafío Extra (Opcional)
Modifica el workflow para que solo ejecute `ubuntu-latest` con `node-version: [18, 20]` en PRs.

---

## Ejercicio 4: Artefactos y Outputs

### 🎯 Objetivos de Aprendizaje
- Generar y subir artefactos
- Compartir datos entre jobs con outputs
- Descargar artefactos de jobs previos
- Persistir información de builds

### 📝 Descripción
Vas a crear un workflow que genere archivos (artefactos) en un job, los comparta con otros jobs, y los haga disponibles para descarga.

### 🛠️ Instrucciones

#### Paso 1: Crear archivos de proyecto
Crea estos archivos en tu repositorio:

**`build.sh` (en la raíz):**
```bash
#!/bin/bash
echo "🔨 Iniciando construcción..."
mkdir -p dist
echo "Build: $1" > dist/build-info.txt
echo "Fecha: $(date)" >> dist/build-info.txt
echo "Version: $2" >> dist/build-info.txt
echo "<html><body><h1>Mi App v$2</h1></body></html>" > dist/index.html
echo "✓ Construcción completada"
ls -la dist/
```

**`test-results.sh`:**
```bash
#!/bin/bash
echo "🧪 Ejecutando tests..."
mkdir -p test-results
echo "Tests ejecutados: 42" > test-results/summary.txt
echo "Tests pasados: 40" >> test-results/summary.txt
echo "Tests fallidos: 2" >> test-results/summary.txt
echo "Cobertura: 85%" >> test-results/summary.txt
echo "✓ Tests completados"
cat test-results/summary.txt
```

Haz commit de estos archivos.

#### Paso 2: Crear workflow con artefactos
Crea `artifacts-workflow.yml`:

```yaml
name: Build con Artefactos

on:
  push:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      version:
        description: 'Versión del build'
        required: true
        default: '1.0.0'

jobs:
  build:
    name: Construir Aplicación
    runs-on: ubuntu-latest
    
    outputs:
      build-number: ${{ steps.build-step.outputs.build_num }}
      build-date: ${{ steps.build-step.outputs.date }}
    
    steps:
      - name: Checkout del código
        run: |
          echo "Clonando repositorio..."
          # En un caso real usarías: actions/checkout@v4
          
      - name: Configurar permisos
        run: |
          [Comando para hacer ejecutables los archivos .sh]
          
      - name: Ejecutar build
        id: build-step
        run: |
          VERSION="${{ github.event.inputs.version || '1.0.0' }}"
          ./build.sh $GITHUB_RUN_NUMBER $VERSION
          
          # Establecer outputs
          echo "build_num=$GITHUB_RUN_NUMBER" >> [¿A qué variable de entorno se escribe?]
          echo "date=$(date +'%Y-%m-%d')" >> [¿Misma variable?]
          
      - name: Mostrar outputs
        run: |
          echo "Build Number: ${{ steps.build-step.outputs.build_num }}"
          echo "Build Date: ${{ steps.build-step.outputs.build_date }}"
          
      - name: Subir artefactos de build
        run: |
          echo "📦 Preparando artefactos..."
          # Aquí simulas la subida
          ls -R dist/
          echo "✓ Artefactos listos para compartir"
```

**Pregunta:** ¿A qué variable de entorno se escriben los outputs? **Pista:** Es `$GITHUB_OUTPUT`

#### Paso 3: Añadir job de testing
Añade este job que usa los outputs del build:

```yaml
  test:
    name: Testing
    runs-on: ubuntu-latest
    needs: build
    
    steps:
      - name: Mostrar información del build anterior
        run: |
          echo "🔍 Build Number recibido: ${{ needs.build.outputs.build-number }}"
          echo "🔍 Fecha del build: ${{ needs.build.outputs.build-date }}"
          
      - name: Configurar permisos
        run: [Haz ejecutable test-results.sh]
        
      - name: Ejecutar tests
        run: |
          ./test-results.sh
          
      - name: Preparar artefactos de test
        run: |
          echo "📊 Resultados de tests disponibles"
          cat test-results/summary.txt
```

#### Paso 4: Añadir job de reporte
Crea un tercer job que genere un reporte combinando información de ambos jobs anteriores:

```yaml
  report:
    name: [Nombre del job]
    runs-on: ubuntu-latest
    needs: [build, test]
    
    steps:
      - name: Generar reporte
        run: |
          mkdir -p reports
          
          echo "# 📋 Reporte de Build y Test" > reports/report.md
          echo "" >> reports/report.md
          echo "## 🔨 Información del Build" >> reports/report.md
          echo "- Build Number: ${{ needs.build.outputs.build-number }}" >> reports/report.md
          echo "- Fecha: ${{ needs.build.outputs.build-date }}" >> reports/report.md
          echo "- Commit: ${{ github.sha }}" >> reports/report.md
          echo "" >> reports/report.md
          echo "## ✅ Estado" >> reports/report.md
          echo "- Build: SUCCESS ✓" >> reports/report.md
          echo "- Tests: SUCCESS ✓" >> reports/report.md
          
          cat reports/report.md
          
      - name: Preparar artefacto final
        run: |
          echo "📄 Reporte generado"
          ls -la reports/
```

#### Paso 5: Probar con workflow_dispatch
1. Ve a Actions → "Build con Artefactos" → "Run workflow"
2. Introduce una versión: `2.5.0`
3. Ejecuta el workflow
4. Observa los logs de cada job

**Preguntas de verificación:**
- ¿Se pasaron correctamente los outputs entre jobs?
- ¿Aparece la versión que introdujiste en los logs?
- ¿Todos los jobs recibieron la información correcta?

### ✅ Criterios de Éxito
- [ ] El job `build` genera outputs correctamente
- [ ] El job `test` recibe y muestra los outputs de `build`
- [ ] El job `report` combina información de ambos jobs
- [ ] Los archivos se generan en las ubicaciones correctas
- [ ] El workflow funciona tanto con push como con workflow_dispatch

### 🤔 Preguntas de Reflexión
1. ¿Cuál es la diferencia entre un output y un artefacto?
2. ¿Por qué necesitamos `needs` para acceder a los outputs?
3. ¿Qué pasaría si intentas acceder a `needs.build.outputs.build-number` sin declarar `needs: build`?
4. ¿Cuándo usarías outputs vs. artefactos en un proyecto real?

### 💡 Nota Importante
En este ejercicio simulamos la subida/descarga de artefactos con comandos básicos. En el siguiente ejercicio usarás las **actions oficiales** de GitHub para manejar artefactos de forma real: `actions/upload-artifact@v4` y `actions/download-artifact@v4`.

---

## Ejercicio 5: Testing y Despliegue con Actions

### 🎯 Objetivos de Aprendizaje
- Usar actions del GitHub Marketplace
- Implementar checkout de código con `actions/checkout`
- Manejar artefactos con actions oficiales
- Configurar Node.js/Python con actions
- Crear un pipeline de CI real

### 📝 Descripción
Ahora vas a crear un workflow **real** usando actions predefinidas de GitHub Marketplace. Construirás una aplicación web simple, ejecutarás tests, y generarás artefactos descargables.

### 🛠️ Instrucciones

#### Paso 1: Crear proyecto Node.js
Crea estos archivos en tu repositorio:

**`package.json`:**
```json
{
  "name": "mi-app-web",
  "version": "1.0.0",
  "description": "Aplicación de prueba para GitHub Actions",
  "scripts": {
    "test": "node test.js",
    "build": "node build.js"
  }
}
```

**`app.js`:**
```javascript
function sumar(a, b) {
  return a + b;
}

function multiplicar(a, b) {
  return a * b;
}

module.exports = { sumar, multiplicar };
```

**`test.js`:**
```javascript
const { sumar, multiplicar } = require('./app.js');

console.log('🧪 Ejecutando tests...\n');

let passed = 0;
let failed = 0;

// Test 1
if (sumar(2, 3) === 5) {
  console.log('✓ Test 1: sumar(2, 3) = 5');
  passed++;
} else {
  console.log('✗ Test 1 FALLÓ');
  failed++;
}

// Test 2
if (multiplicar(4, 5) === 20) {
  console.log('✓ Test 2: multiplicar(4, 5) = 20');
  passed++;
} else {
  console.log('✗ Test 2 FALLÓ');
  failed++;
}

// Test 3
if (sumar(-1, 1) === 0) {
  console.log('✓ Test 3: sumar(-1, 1) = 0');
  passed++;
} else {
  console.log('✗ Test 3 FALLÓ');
  failed++;
}

console.log(`\n📊 Resultado: ${passed} pasados, ${failed} fallidos`);

if (failed > 0) {
  process.exit(1);
}
```

**`build.js`:**
```javascript
const fs = require('fs');

console.log('🔨 Iniciando build...');

// Crear directorio dist
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist');
}

// Crear archivo HTML
const html = `
<!DOCTYPE html>
<html>
<head>
  <title>Mi App Web</title>
  <style>
    body { font-family: Arial; text-align: center; padding: 50px; }
    h1 { color: #0366d6; }
  </style>
</head>
<body>
  <h1>✓ Build Exitoso</h1>
  <p>Build #${process.env.GITHUB_RUN_NUMBER || 'local'}</p>
  <p>Commit: ${process.env.GITHUB_SHA?.substring(0, 7) || 'unknown'}</p>
</body>
</html>
`;

fs.writeFileSync('dist/index.html', html);

// Copiar app.js a dist
fs.copyFileSync('app.js', 'dist/app.js');

console.log('✓ Build completado');
console.log('✓ Archivos generados en dist/');
```

Haz commit de estos archivos.

#### Paso 2: Crear workflow con actions del Marketplace

Crea `ci-pipeline.yml`:

```yaml
name: CI Pipeline con Actions

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    name: Tests Unitarios
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout del código
        uses: actions/checkout@v4
        
      - name: Configurar Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          
      - name: Mostrar versiones
        run: |
          node --version
          npm --version
          
      - name: Ejecutar tests
        run: npm test
        
      - name: Verificar resultado
        run: echo "✓ Todos los tests pasaron"
```

**Pregunta:** ¿Qué hace `actions/checkout@v4`? ¿Por qué es necesario?

#### Paso 3: Añadir job de build con artefactos REALES

```yaml
  build:
    name: Build de Producción
    runs-on: ubuntu-latest
    needs: test
    
    steps:
      - name: Checkout del código
        uses: [¿Qué action usas? Incluye la versión]
        
      - name: Configurar Node.js
        uses: [¿Qué action? ¿Qué versión de Node?]
        with:
          node-version: [Elige versión LTS]
          
      - name: Ejecutar build
        run: [¿Qué comando ejecuta el build?]
        
      - name: Listar archivos generados
        run: |
          echo "📦 Contenido de dist:"
          ls -la dist/
          
      - name: Subir artefactos
        uses: actions/upload-artifact@v4
        with:
          name: build-artifacts
          path: dist/
          retention-days: 30
```

#### Paso 4: Añadir job que descarga y verifica artefactos

```yaml
  verify-build:
    name: Verificar Build
    runs-on: ubuntu-latest
    needs: build
    
    steps:
      - name: Descargar artefactos
        uses: actions/download-artifact@v4
        with:
          name: build-artifacts
          path: ./downloaded
          
      - name: Verificar archivos descargados
        run: |
          echo "📥 Archivos descargados:"
          ls -R ./downloaded
          
      - name: Validar HTML
        run: |
          if [ -f "./downloaded/index.html" ]; then
            echo "✓ index.html existe"
            cat ./downloaded/index.html
          else
            echo "✗ index.html NO encontrado"
            exit 1
          fi
          
      - name: Validar JavaScript
        run: |
          if [ -f "./downloaded/app.js" ]; then
            echo "✓ app.js existe"
          else
            echo "✗ app.js NO encontrado"
            exit 1
          fi
```

#### Paso 5: Añadir paso de resumen

Al final del workflow, añade un job de resumen:

```yaml
  summary:
    name: Resumen del Pipeline
    runs-on: ubuntu-latest
    needs: [test, build, verify-build]
    if: always()
    
    steps:
      - name: Generar resumen
        run: |
          echo "# 📊 Resumen del Pipeline" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "- **Tests:** ${{ needs.test.result }}" >> $GITHUB_STEP_SUMMARY
          echo "- **Build:** ${{ needs.build.result }}" >> $GITHUB_STEP_SUMMARY
          echo "- **Verificación:** ${{ needs.verify-build.result }}" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "🔗 [Ver artefactos](${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }})" >> $GITHUB_STEP_SUMMARY
```

**Pregunta:** ¿Qué hace `$GITHUB_STEP_SUMMARY`? ¿Dónde se muestra?

#### Paso 6: Probar el workflow completo

1. Haz commit y push
2. Ve a la pestaña Actions
3. Espera a que se complete
4. Verifica:
   - ¿Se ejecutaron los tests?
   - ¿Se generó el artefacto?
   - ¿Se descargó y verificó correctamente?

#### Paso 7: Descargar artefactos

1. En la página de la ejecución del workflow, busca la sección "Artifacts"
2. Descarga `build-artifacts`
3. Extrae el archivo ZIP
4. Abre `index.html` en un navegador

**Pregunta:** ¿Aparece el número de build y el commit hash?

### ✅ Criterios de Éxito
- [ ] Los tests se ejecutan correctamente
- [ ] El build se ejecuta solo si los tests pasan
- [ ] Se genera un artefacto descargable
- [ ] El artefacto contiene los archivos correctos
- [ ] El job de verificación valida el contenido
- [ ] El resumen se muestra correctamente

### 🤔 Preguntas de Reflexión
1. ¿Qué ventajas tiene usar `actions/checkout@v4` en lugar de clonar manualmente?
2. ¿Por qué especificamos `@v4` en las actions?
3. ¿Cuál es la diferencia entre usar `npm install` antes de `npm test` vs. no usarlo en este caso?
4. ¿Qué pasaría si no pones `needs: test` en el job `build`?
5. ¿Para qué sirve `retention-days: 30` en upload-artifact?

### 💡 Desafío Extra (Opcional)
Investiga cómo añadir una matriz para probar en múltiples versiones de Node.js (16, 18, 20).

---

## 🎓 Evaluación Final

Para completar esta serie de ejercicios, debes:

1. **Tener 5 workflows funcionando** (uno por ejercicio)
2. **Responder las preguntas de reflexión** de cada ejercicio
3. **Crear un documento** que explique:
   - ¿Cuál fue el ejercicio más difícil y por qué?
   - ¿Qué diferencias encontraste entre usar comandos shell vs. actions del Marketplace?
   - ¿Cómo aplicarías GitHub Actions en un proyecto real de tu carrera?

### Formato de Entrega

Crea un archivo `EVALUACION.md` en tu repositorio con:

```markdown
# Evaluación: GitHub Actions

## Ejercicio más Difícil
[Tu respuesta]

## Shell vs. Marketplace Actions
[Tu análisis]

## Aplicación en Proyectos Reales
[Tus ideas]

## Capturas de Pantalla
- [ ] Ejercicio 1: Workflow ejecutado
- [ ] Ejercicio 2: Múltiples jobs con dependencias
- [ ] Ejercicio 3: Matriz completa
- [ ] Ejercicio 4: Artefacto descargado
- [ ] Ejercicio 5: Pipeline CI completo

## URLs
- Repositorio: [URL]
- Actions: [URL]
```

---
<!-- 
## 📊 Resumen de la Práctica

### Progresión de Aprendizaje

```
Ejercicio 1 (20-25 min) → Sintaxis YAML básica, eventos, comandos shell
          ↓
Ejercicio 2 (30-35 min) → Múltiples jobs, dependencias, ejecución secuencial
          ↓
Ejercicio 3 (35-40 min) → Estrategia de matriz, testing multi-plataforma
          ↓
Ejercicio 4 (40-45 min) → Outputs, compartir datos entre jobs
          ↓
Ejercicio 5 (50-60 min) → GitHub Marketplace Actions, artefactos reales
```

### Habilidades Adquiridas

Al completar estos ejercicios, habrás aprendido a:

✅ Crear y configurar workflows de GitHub Actions  
✅ Usar eventos para disparar workflows automáticamente  
✅ Estructurar jobs con dependencias  
✅ Implementar estrategias de matriz para testing multi-configuración  
✅ Compartir datos entre jobs con outputs  
✅ Generar y gestionar artefactos  
✅ Integrar actions del GitHub Marketplace  
✅ Crear pipelines de CI/CD funcionales  

### Aplicaciones Prácticas

Estos conocimientos te permitirán:

- 🔄 Automatizar tests en cada push
- 📦 Construir y empaquetar aplicaciones automáticamente
- 🚀 Implementar despliegues continuos
- 🔍 Validar código en múltiples entornos
- 📊 Generar reportes de cobertura y calidad
- 🔐 Integrar análisis de seguridad

--- -->

**¡Buena suerte con los ejercicios!**
