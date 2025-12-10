# Guia Completa de Neovim + Wezterm

## Tabla de Contenidos

1. [Introduccion](#introduccion)
2. [Wezterm](#wezterm)
3. [Neovim - Conceptos Basicos](#neovim---conceptos-basicos)
4. [Modos de Vim](#modos-de-vim)
5. [Movimiento y Navegacion](#movimiento-y-navegacion)
6. [Edicion de Texto](#edicion-de-texto)
7. [Busqueda y Reemplazo](#busqueda-y-reemplazo)
8. [Ventanas, Buffers y Tabs](#ventanas-buffers-y-tabs)
9. [Explorador de Archivos (Neo-tree)](#explorador-de-archivos-neo-tree)
10. [Telescope (Fuzzy Finder)](#telescope-fuzzy-finder)
11. [LSP e IntelliSense](#lsp-e-intellisense)
12. [Debugging .NET](#debugging-net)
13. [Git Integration](#git-integration)
14. [Terminal Integrada](#terminal-integrada)
15. [OpenCode](#opencode)
16. [Comandos .NET](#comandos-net)
17. [Personalizacion](#personalizacion)
18. [Tips y Trucos](#tips-y-trucos)
19. [Solucion de Problemas](#solucion-de-problemas)

---

## Introduccion

Esta configuracion combina:
- **Wezterm**: Terminal moderna con GPU rendering
- **Neovim**: Editor de texto extensible basado en Vim
- **LazyVim**: Distribucion de Neovim preconfigurada
- **Plugins personalizados**: Para desarrollo .NET

### Filosofia

Vim se basa en la idea de que la mayoria del tiempo programando se pasa **editando**, no escribiendo codigo nuevo. Por eso Vim tiene modos especializados y comandos composables que permiten editar texto de manera extremadamente eficiente.

---

## Wezterm

Wezterm es tu terminal. Aqui es donde corre Neovim.

### Keymaps de Wezterm

| Tecla | Accion |
|-------|--------|
| `Ctrl+a c` | Nueva tab |
| `Ctrl+a x` | Cerrar tab |
| `Ctrl+a n` | Siguiente tab |
| `Ctrl+a p` | Tab anterior |
| `Ctrl+a \|` | Split vertical |
| `Ctrl+a -` | Split horizontal |
| `Ctrl+a h/j/k/l` | Navegar entre splits |
| `Ctrl+a z` | Zoom (maximizar panel) |
| `Ctrl+a 1-9` | Ir a tab N |
| `Ctrl+Shift+f` | Buscar en terminal |
| `Ctrl+Shift+c` | Copiar |
| `Ctrl+Shift+v` | Pegar |

> **Nota**: `Ctrl+a` es la tecla "leader" de Wezterm. Presionala primero, sueltala, luego presiona la siguiente tecla.

### Apariencia

- **Tema**: Catppuccin Mocha
- **Fuente**: JetBrainsMono Nerd Font
- **Transparencia**: 90%

---

## Neovim - Conceptos Basicos

### Que es Neovim?

Neovim es un editor de texto modal. "Modal" significa que tiene diferentes modos de operacion:

1. **Normal**: Para navegar y ejecutar comandos
2. **Insert**: Para escribir texto
3. **Visual**: Para seleccionar texto
4. **Command**: Para ejecutar comandos Ex

### Iniciar Neovim

```bash
# Abrir Neovim
nvim

# Abrir un archivo
nvim archivo.cs

# Abrir un directorio
nvim .
```

### Salir de Neovim

| Comando | Accion |
|---------|--------|
| `:q` | Salir (si no hay cambios) |
| `:q!` | Salir sin guardar |
| `:w` | Guardar |
| `:wq` o `:x` | Guardar y salir |
| `ZZ` | Guardar y salir (modo normal) |
| `ZQ` | Salir sin guardar (modo normal) |

---

## Modos de Vim

### Normal Mode (Por defecto)

Es el modo principal. Aqui navegas y ejecutas comandos.

**Como entrar**: Presiona `Esc` desde cualquier otro modo.

### Insert Mode

Para escribir texto como en un editor normal.

| Tecla | Accion |
|-------|--------|
| `i` | Insertar antes del cursor |
| `I` | Insertar al inicio de la linea |
| `a` | Insertar despues del cursor |
| `A` | Insertar al final de la linea |
| `o` | Nueva linea abajo |
| `O` | Nueva linea arriba |
| `s` | Borrar caracter e insertar |
| `S` | Borrar linea e insertar |

**Como salir**: Presiona `Esc`

### Visual Mode

Para seleccionar texto.

| Tecla | Accion |
|-------|--------|
| `v` | Visual (por caracter) |
| `V` | Visual linea (lineas completas) |
| `Ctrl+v` | Visual bloque (columnas) |

**Como salir**: Presiona `Esc`

### Command Mode

Para ejecutar comandos Ex.

**Como entrar**: Presiona `:` desde modo normal.

```vim
:w              " Guardar
:q              " Salir
:e archivo.cs   " Abrir archivo
:help tema      " Ver ayuda
:%s/foo/bar/g   " Reemplazar
```

---

## Movimiento y Navegacion

### Movimiento Basico

| Tecla | Accion |
|-------|--------|
| `h` | Izquierda |
| `j` | Abajo |
| `k` | Arriba |
| `l` | Derecha |

> **Tip**: Usa los numeros relativos! Si quieres ir 15 lineas abajo: `15j`

### Movimiento por Palabras

| Tecla | Accion |
|-------|--------|
| `w` | Inicio de siguiente palabra |
| `W` | Inicio de siguiente PALABRA (ignora puntuacion) |
| `e` | Final de palabra actual |
| `E` | Final de PALABRA actual |
| `b` | Inicio de palabra anterior |
| `B` | Inicio de PALABRA anterior |

### Movimiento por Linea

| Tecla | Accion |
|-------|--------|
| `0` | Inicio de linea |
| `^` | Primer caracter no-blanco |
| `$` | Final de linea |
| `g_` | Ultimo caracter no-blanco |

### Movimiento por Pantalla

| Tecla | Accion |
|-------|--------|
| `Ctrl+d` | Media pagina abajo |
| `Ctrl+u` | Media pagina arriba |
| `Ctrl+f` | Pagina completa abajo |
| `Ctrl+b` | Pagina completa arriba |
| `H` | Parte alta de la pantalla |
| `M` | Mitad de la pantalla |
| `L` | Parte baja de la pantalla |
| `zz` | Centrar cursor en pantalla |
| `zt` | Cursor arriba de pantalla |
| `zb` | Cursor abajo de pantalla |

### Movimiento por Archivo

| Tecla | Accion |
|-------|--------|
| `gg` | Inicio del archivo |
| `G` | Final del archivo |
| `{numero}G` | Ir a linea N (ej: `50G`) |
| `:{numero}` | Ir a linea N (ej: `:50`) |
| `%` | Ir al bracket/parentesis que cierra |

### Movimiento por Codigo

| Tecla | Accion |
|-------|--------|
| `{` | Parrafo anterior |
| `}` | Parrafo siguiente |
| `[[` | Seccion anterior |
| `]]` | Seccion siguiente |
| `gd` | Ir a definicion |
| `gr` | Ver referencias |
| `gI` | Ir a implementacion |

---

## Edicion de Texto

### Operadores

Los operadores se combinan con movimientos: `operador + movimiento`

| Operador | Accion |
|----------|--------|
| `d` | Delete (cortar) |
| `c` | Change (borrar e insertar) |
| `y` | Yank (copiar) |
| `>` | Indentar derecha |
| `<` | Indentar izquierda |
| `=` | Auto-indentar |
| `gU` | Mayusculas |
| `gu` | Minusculas |

### Ejemplos de Operador + Movimiento

| Comando | Accion |
|---------|--------|
| `dw` | Borrar palabra |
| `d$` o `D` | Borrar hasta final de linea |
| `dd` | Borrar linea completa |
| `d3j` | Borrar 3 lineas abajo |
| `cw` | Cambiar palabra |
| `ci"` | Cambiar dentro de comillas |
| `ca{` | Cambiar incluyendo llaves |
| `yy` | Copiar linea |
| `y3w` | Copiar 3 palabras |
| `>}` | Indentar hasta siguiente parrafo |
| `=G` | Auto-indentar hasta final |

### Text Objects

Los text objects permiten operar sobre estructuras de texto.

| Prefijo | Significado |
|---------|-------------|
| `i` | Inner (dentro de) |
| `a` | A/Around (incluyendo delimitadores) |

| Object | Descripcion |
|--------|-------------|
| `w` | Palabra |
| `W` | PALABRA |
| `s` | Oracion |
| `p` | Parrafo |
| `"` | Comillas dobles |
| `'` | Comillas simples |
| `` ` `` | Backticks |
| `(` o `)` | Parentesis |
| `[` o `]` | Corchetes |
| `{` o `}` | Llaves |
| `<` o `>` | Angle brackets |
| `t` | Tag HTML/XML |

### Ejemplos de Text Objects

| Comando | Accion |
|---------|--------|
| `diw` | Borrar palabra (sin espacios) |
| `daw` | Borrar palabra (con espacios) |
| `ci"` | Cambiar dentro de comillas |
| `ca"` | Cambiar incluyendo comillas |
| `di{` | Borrar dentro de llaves |
| `da{` | Borrar incluyendo llaves |
| `cit` | Cambiar dentro de tag HTML |
| `yip` | Copiar parrafo |
| `>i{` | Indentar dentro de llaves |

### Comandos de Edicion Rapida

| Comando | Accion |
|---------|--------|
| `x` | Borrar caracter bajo cursor |
| `X` | Borrar caracter antes del cursor |
| `r{char}` | Reemplazar caracter |
| `R` | Modo reemplazo (sobreescribir) |
| `J` | Unir linea actual con siguiente |
| `~` | Cambiar mayuscula/minuscula |
| `.` | Repetir ultimo comando |
| `u` | Deshacer |
| `Ctrl+r` | Rehacer |

### Copiar y Pegar

| Comando | Accion |
|---------|--------|
| `y{motion}` | Copiar |
| `yy` | Copiar linea |
| `p` | Pegar despues |
| `P` | Pegar antes |
| `"ay{motion}` | Copiar al registro 'a' |
| `"ap` | Pegar del registro 'a' |
| `"+y` | Copiar al clipboard del sistema |
| `"+p` | Pegar del clipboard del sistema |

### Mover Lineas

| Comando | Accion |
|---------|--------|
| `Alt+j` | Mover linea abajo |
| `Alt+k` | Mover linea arriba |
| `:m +1` | Mover linea abajo |
| `:m -2` | Mover linea arriba |

---

## Busqueda y Reemplazo

### Busqueda

| Comando | Accion |
|---------|--------|
| `/patron` | Buscar hacia adelante |
| `?patron` | Buscar hacia atras |
| `n` | Siguiente coincidencia |
| `N` | Coincidencia anterior |
| `*` | Buscar palabra bajo cursor (adelante) |
| `#` | Buscar palabra bajo cursor (atras) |
| `:noh` | Limpiar resaltado de busqueda |

### Reemplazo

```vim
" Sintaxis: :[rango]s/patron/reemplazo/[flags]

" Reemplazar en linea actual
:s/foo/bar/

" Reemplazar todos en linea actual
:s/foo/bar/g

" Reemplazar en todo el archivo
:%s/foo/bar/g

" Reemplazar con confirmacion
:%s/foo/bar/gc

" Reemplazar solo en seleccion visual
:'<,'>s/foo/bar/g

" Reemplazar ignorando mayusculas
:%s/foo/bar/gi

" Usar regex
:%s/\d\+/NUMBER/g
```

### Flags de Reemplazo

| Flag | Significado |
|------|-------------|
| `g` | Global (todas las ocurrencias en linea) |
| `c` | Confirmar cada reemplazo |
| `i` | Ignorar mayusculas/minusculas |
| `I` | Respetar mayusculas/minusculas |
| `n` | Solo contar, no reemplazar |

---

## Ventanas, Buffers y Tabs

### Conceptos

- **Buffer**: Un archivo abierto en memoria
- **Window**: Una vista de un buffer
- **Tab**: Una coleccion de ventanas

### Buffers

| Comando | Accion |
|---------|--------|
| `:e archivo` | Abrir archivo en buffer |
| `:ls` | Listar buffers |
| `:b {n}` | Ir a buffer N |
| `:bn` | Siguiente buffer |
| `:bp` | Buffer anterior |
| `:bd` | Cerrar buffer |
| `<leader>bb` | Lista de buffers (Telescope) |
| `<S-h>` | Buffer anterior |
| `<S-l>` | Buffer siguiente |

### Ventanas

| Comando | Accion |
|---------|--------|
| `Ctrl+w s` o `<leader>-` | Split horizontal |
| `Ctrl+w v` o `<leader>\|` | Split vertical |
| `Ctrl+w q` | Cerrar ventana |
| `Ctrl+w o` | Cerrar otras ventanas |
| `Ctrl+h/j/k/l` | Navegar entre ventanas |
| `Ctrl+Up/Down` | Redimensionar altura |
| `Ctrl+Left/Right` | Redimensionar ancho |
| `Ctrl+w =` | Igualar tamano |
| `Ctrl+w _` | Maximizar altura |
| `Ctrl+w \|` | Maximizar ancho |

### Tabs

| Comando | Accion |
|---------|--------|
| `:tabnew` | Nueva tab |
| `:tabclose` | Cerrar tab |
| `gt` | Siguiente tab |
| `gT` | Tab anterior |
| `{n}gt` | Ir a tab N |

---

## Explorador de Archivos (Neo-tree)

Neo-tree es el explorador de archivos.

### Abrir Neo-tree

| Comando | Accion |
|---------|--------|
| `<leader>e` | Toggle explorador |
| `<leader>E` | Explorador en root del proyecto |

### Navegacion en Neo-tree

| Tecla | Accion |
|-------|--------|
| `j/k` | Mover arriba/abajo |
| `Enter` | Abrir archivo/expandir carpeta |
| `l` | Expandir carpeta |
| `h` | Colapsar carpeta |
| `<` | Ir a padre |
| `/` | Buscar |

### Acciones en Neo-tree

| Tecla | Accion |
|-------|--------|
| `a` | Crear archivo/carpeta |
| `d` | Eliminar |
| `r` | Renombrar |
| `c` | Copiar |
| `m` | Mover |
| `p` | Pegar |
| `y` | Copiar path |
| `Y` | Copiar path relativo |
| `H` | Mostrar/ocultar archivos ocultos |
| `R` | Refrescar |
| `?` | Mostrar ayuda |

---

## Telescope (Fuzzy Finder)

Telescope es el buscador fuzzy universal.

### Busqueda de Archivos

| Comando | Accion |
|---------|--------|
| `<leader>ff` | Buscar archivos |
| `<leader>fr` | Archivos recientes |
| `<leader>fg` | Grep (buscar texto) |
| `<leader>fw` | Buscar palabra bajo cursor |
| `<leader>fb` | Buffers abiertos |
| `<leader>fh` | Historial de busqueda |

### Navegacion en Telescope

| Tecla | Accion |
|-------|--------|
| `Ctrl+j/k` | Mover arriba/abajo |
| `Ctrl+n/p` | Mover arriba/abajo (alternativo) |
| `Enter` | Abrir seleccion |
| `Ctrl+x` | Abrir en split horizontal |
| `Ctrl+v` | Abrir en split vertical |
| `Ctrl+t` | Abrir en nueva tab |
| `Esc` | Cerrar |
| `Ctrl+u` | Scroll preview arriba |
| `Ctrl+d` | Scroll preview abajo |

### Otros Pickers

| Comando | Accion |
|---------|--------|
| `<leader>:` | Historial de comandos |
| `<leader>sk` | Keymaps |
| `<leader>sh` | Help tags |
| `<leader>sc` | Comandos |
| `<leader>sd` | Diagnosticos |
| `<leader>ss` | Simbolos del documento |
| `<leader>sS` | Simbolos del workspace |

---

## LSP e IntelliSense

LSP (Language Server Protocol) proporciona IntelliSense, diagnosticos, etc.

### Navegacion de Codigo

| Comando | Accion |
|---------|--------|
| `gd` | Ir a definicion |
| `gD` | Ir a declaracion |
| `gr` | Ver referencias |
| `gI` | Ir a implementacion |
| `gy` | Ir a tipo de definicion |
| `K` | Mostrar documentacion (hover) |
| `gK` | Signature help |

### Acciones de Codigo

| Comando | Accion |
|---------|--------|
| `<leader>ca` | Code actions |
| `<leader>cr` | Renombrar simbolo |
| `<leader>cf` | Formatear archivo |
| `<leader>cF` | Formatear seleccion |

### Diagnosticos

| Comando | Accion |
|---------|--------|
| `]d` | Siguiente diagnostico |
| `[d` | Diagnostico anterior |
| `]e` | Siguiente error |
| `[e` | Error anterior |
| `]w` | Siguiente warning |
| `[w` | Warning anterior |
| `<leader>cd` | Diagnostico en linea |
| `<leader>xx` | Lista de diagnosticos |

### Autocompletado

| Tecla | Accion |
|-------|--------|
| `Ctrl+Space` | Abrir menu de autocompletado |
| `Ctrl+n` | Siguiente sugerencia |
| `Ctrl+p` | Sugerencia anterior |
| `Enter` | Aceptar sugerencia |
| `Ctrl+e` | Cerrar menu |
| `Tab` | Siguiente item / expandir snippet |
| `Shift+Tab` | Item anterior |

---

## Debugging .NET

El debugging usa nvim-dap con netcoredbg.

### Keymaps de Debug

| Comando | Accion |
|---------|--------|
| `F5` | Iniciar/Continuar debug |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `Shift+F11` | Step out |
| `Shift+F5` | Terminar debug |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Breakpoint condicional |
| `<leader>dc` | Continuar |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dt` | Terminar |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluar expresion |
| `<leader>dr` | Toggle REPL |

### Flujo de Trabajo

1. Abre el archivo donde quieres el breakpoint
2. Presiona `F9` en la linea deseada (aparece ●)
3. Presiona `F5` para iniciar debug
4. Selecciona el proyecto (Api, ScrappingService, etc.)
5. Haz una request al endpoint
6. El debug se detendra en el breakpoint
7. Usa `F10`/`F11` para navegar
8. `Shift+F5` para terminar

### DAP UI

Cuando el debug inicia, se abre automaticamente la UI con:
- **Variables**: Variables locales y sus valores
- **Watch**: Expresiones personalizadas
- **Call Stack**: Pila de llamadas
- **Breakpoints**: Lista de breakpoints
- **REPL**: Consola interactiva

---

## Git Integration

### LazyGit

| Comando | Accion |
|---------|--------|
| `<leader>gg` | Abrir LazyGit |

LazyGit es una TUI completa para Git. Keymaps dentro de LazyGit:
- `j/k` - Navegar
- `Enter` - Seleccionar
- `Space` - Stage/Unstage
- `c` - Commit
- `P` - Push
- `p` - Pull
- `?` - Ayuda

### Gitsigns (en buffer)

| Comando | Accion |
|---------|--------|
| `]h` | Siguiente hunk (cambio) |
| `[h` | Hunk anterior |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghu` | Unstage hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |

---

## Terminal Integrada

### Toggle Terminal

| Comando | Accion |
|---------|--------|
| `Ctrl+\` | Toggle terminal flotante |
| `<leader>tf` | Terminal flotante |
| `<leader>th` | Terminal horizontal |
| `<leader>tv` | Terminal vertical |

### Navegacion

| Comando | Accion |
|---------|--------|
| `Esc Esc` | Salir de modo terminal |
| `Ctrl+h/j/k/l` | Navegar a otra ventana |

---

## OpenCode

OpenCode es el asistente de IA integrado.

### Keymaps

| Comando | Accion |
|---------|--------|
| `Ctrl+o` | Toggle OpenCode |
| `<leader>oo` | OpenCode flotante |
| `<leader>ov` | OpenCode lateral |
| `<leader>oh` | OpenCode abajo |

### Uso

1. `Ctrl+o` para abrir
2. Escribe tu pregunta/instruccion
3. `Ctrl+o` para ocultar (mantiene sesion)
4. `Ctrl+o` para volver

---

## Comandos .NET

Comandos disponibles via Overseer (`<leader>N`):

| Comando | Accion |
|---------|--------|
| `<leader>Nr` | dotnet run |
| `<leader>Nb` | dotnet build |
| `<leader>Nc` | dotnet clean |
| `<leader>Nt` | dotnet test |
| `<leader>NR` | dotnet restore |
| `<leader>Nw` | dotnet watch |

---

## Harpoon (Navegacion Rapida)

Harpoon permite marcar archivos y saltar entre ellos instantaneamente.
Ideal para los 3-5 archivos que usas constantemente.

### Keymaps

| Comando | Accion |
|---------|--------|
| `<leader>ha` | Agregar archivo actual a Harpoon |
| `<leader>hh` | Abrir menu de Harpoon |
| `<leader>1` | Ir al archivo 1 |
| `<leader>2` | Ir al archivo 2 |
| `<leader>3` | Ir al archivo 3 |
| `<leader>4` | Ir al archivo 4 |
| `<leader>5` | Ir al archivo 5 |
| `<leader>hp` | Archivo anterior |
| `<leader>hn` | Archivo siguiente |

### Flujo de Trabajo

1. Abre un archivo importante (ej: Controller)
2. `<leader>ha` - Lo agrega a Harpoon
3. Abre otro archivo (ej: Service)
4. `<leader>ha` - Lo agrega
5. Ahora puedes saltar con `<leader>1` y `<leader>2`

---

## Snippets (C#)

Los snippets permiten escribir codigo comun rapidamente.
Escribe el trigger y presiona `Tab` para expandir.

### Snippets Disponibles

| Trigger | Descripcion |
|---------|-------------|
| `class` | Clase publica |
| `classns` | Clase con namespace |
| `interface` | Interface |
| `record` | Record |
| `ctor` | Constructor |
| `ctordi` | Constructor con DI |
| `prop` | Propiedad |
| `propi` | Propiedad con init |
| `propr` | Propiedad required |
| `method` | Metodo |
| `methodasync` | Metodo async |
| `try` | Try-catch |
| `tryf` | Try-catch-finally |
| `if` | If |
| `ife` | If-else |
| `for` | For loop |
| `foreach` | Foreach |
| `switch` | Switch |
| `switchex` | Switch expression |
| `httpget` | Controller GET action |
| `httppost` | Controller POST action |
| `httpgetid` | Controller GET by ID |
| `action` | Controller action |
| `fact` | xUnit Fact test |
| `theory` | xUnit Theory test |
| `log` | Logger statement |
| `logi` | Logger con interpolacion |
| `summary` | XML summary |
| `region` | Region |
| `guard` | Guard clause |
| `null` | Null check |

### Uso

1. En un archivo .cs, escribe `prop`
2. Presiona `Tab`
3. Se expande a: `public string Name { get; set; }`
4. Edita el tipo y nombre
5. `Tab` para saltar al siguiente campo

### Navegacion en Snippets

| Tecla | Accion |
|-------|--------|
| `Tab` | Expandir / Siguiente campo |
| `Shift+Tab` | Campo anterior |

---

## Database & Message Queues

Clientes integrados para SQL Server, PostgreSQL, MongoDB, Redis y RabbitMQ.

### SQL Databases (DBUI)

Interface visual para SQL Server, PostgreSQL, MySQL, SQLite.

| Comando | Accion |
|---------|--------|
| `<leader>Ds` | Toggle SQL UI |
| `<leader>Da` | Agregar conexion SQL |
| `<leader>Df` | Buscar buffer SQL |
| `Ctrl+Enter` | Ejecutar query (en .sql) |

### SQL Server

| Comando | Accion |
|---------|--------|
| `<leader>Dt` | Conectar con sqlcmd |

### PostgreSQL

| Comando | Accion |
|---------|--------|
| `<leader>Dp` | Abrir psql local |
| `<leader>DP` | Conectar a servidor |

### MongoDB

| Comando | Accion |
|---------|--------|
| `<leader>Dm` | Abrir mongosh local |
| `<leader>DM` | Conectar a servidor |

### Redis

| Comando | Accion |
|---------|--------|
| `<leader>Dr` | Abrir redis-cli local |
| `<leader>DR` | Conectar a servidor |

### RabbitMQ

| Comando | Accion |
|---------|--------|
| `<leader>Dq` | Abrir Management UI (browser) |
| `<leader>DQ` | Terminal con rabbitmqctl |

### Connection Strings (para DBUI)

```
# SQL Server
sqlserver://user:password@localhost:1433/database
sqlserver://localhost:1433/database?trusted_connection=true

# PostgreSQL  
postgresql://user:password@localhost:5432/database

# MySQL
mysql://user:password@localhost:3306/database

# SQLite
sqlite:///C:/path/to/database.db

# MongoDB (via mongosh)
mongodb://user:password@localhost:27017/database
```

### Requisitos

Instala los CLIs necesarios:

```powershell
# Con Chocolatey
choco install postgresql      # psql
choco install mongodb-shell   # mongosh
choco install redis-64        # redis-cli
choco install rabbitmq        # rabbitmqctl
# sqlcmd viene con SQL Server o SSMS
```

### Uso de DBUI (SQL)

1. `<leader>Ds` - Abre DB UI
2. `<leader>Da` - Agrega conexion
3. Navega schemas/tablas
4. Abre buffer de query
5. Escribe SQL
6. `Ctrl+Enter` ejecuta
7. Resultados aparecen abajo

---

## Personalizacion

### Estructura de Archivos

```
~\AppData\Local\nvim\
├── init.lua              # Punto de entrada
├── lazy-lock.json        # Versiones de plugins
└── lua\
    ├── config\
    │   ├── autocmds.lua  # Autocomandos
    │   ├── keymaps.lua   # Keymaps personalizados
    │   ├── lazy.lua      # Configuracion de Lazy.nvim
    │   └── options.lua   # Opciones de Neovim
    └── plugins\
        ├── animations.lua
        ├── buffers.lua
        ├── colorscheme.lua
        ├── dap.lua
        ├── dashboard.lua
        ├── database.lua    # SQL client
        ├── dotnet.lua
        ├── harpoon.lua     # Navegacion rapida
        ├── opencode.lua
        ├── roslyn.lua
        ├── snippets.lua    # Snippets C#
        ├── ui-effects.lua
        └── which-key.lua
```

### Agregar Keymaps

Edita `lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set

-- Ejemplo: mapear <leader>h a :nohlsearch
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })
```

### Agregar Plugins

Crea un archivo en `lua/plugins/mi-plugin.lua`:

```lua
return {
  {
    "autor/nombre-plugin",
    opts = {
      -- configuracion
    },
  },
}
```

### Cambiar Opciones

Edita `lua/config/options.lua`:

```lua
local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.relativenumber = true
```

---

## Tips y Trucos

### Macros

Las macros permiten grabar y repetir secuencias de comandos.

```
qa        " Iniciar grabacion en registro 'a'
...       " Ejecutar comandos
q         " Detener grabacion
@a        " Reproducir macro 'a'
@@        " Repetir ultima macro
10@a      " Reproducir macro 10 veces
```

### Marks (Marcadores)

```
ma        " Crear mark 'a' en posicion actual
'a        " Ir a linea del mark 'a'
`a        " Ir a posicion exacta del mark 'a'
:marks    " Ver todos los marks
```

### Registers

```
"ayy      " Copiar linea al registro 'a'
"ap       " Pegar del registro 'a'
:reg      " Ver contenido de registros
"+        " Clipboard del sistema
"*        " Seleccion primaria (X11)
"0        " Ultimo yank
"1-9      " Ultimos deletes
```

### Comandos Utiles

```vim
" Ver keymaps
:map
:nmap          " Solo modo normal
:imap          " Solo modo insert

" Ejecutar comando externo
:!comando

" Insertar output de comando
:r !comando

" Editar archivo remoto
:e scp://usuario@host/ruta/archivo

" Diferencias entre archivos
:diffsplit archivo

" Guardar como root
:w !sudo tee %
```

### Movimientos Avanzados

```
f{char}   " Ir al siguiente {char} en la linea
F{char}   " Ir al anterior {char} en la linea
t{char}   " Ir antes del siguiente {char}
T{char}   " Ir despues del anterior {char}
;         " Repetir f/F/t/T
,         " Repetir f/F/t/T en direccion opuesta
```

### Ejemplos Practicos

```
" Borrar dentro de parentesis
di(

" Cambiar palabra y repetir con .
ciw<nuevo><Esc>
n.n.n.    " Buscar siguiente y repetir cambio

" Indentar bloque de codigo
>i{

" Comentar lineas (con plugin)
gc3j      " Comentar 3 lineas abajo
gcap      " Comentar parrafo

" Seleccionar funcion completa
vaf       " Visual around function

" Duplicar linea
yyp

" Borrar hasta encontrar 'x'
dtx

" Cambiar todo dentro de tag HTML
cit
```

---

## Solucion de Problemas

### Breakpoints no funcionan

1. Verifica que el proyecto este compilado: `:!dotnet build`
2. Verifica que existan los PDB files
3. Asegurate de estar en el directorio correcto del proyecto

### LSP no funciona

1. Verifica que Roslyn este instalado: `:checkhealth`
2. Reinstala: elimina `%LOCALAPPDATA%\nvim-data\roslyn\` y reinicia

### Plugins no cargan

1. Ejecuta `:Lazy sync`
2. Verifica errores: `:Lazy log`
3. Limpia cache: elimina `%LOCALAPPDATA%\nvim-data\lazy\`

### Terminal no abre

1. Verifica que PowerShell 7 este instalado
2. Verifica la ruta en `opencode.lua`: `shell = "pwsh"`

### Fuentes no se ven bien

1. Instala una Nerd Font
2. Configura la fuente en Wezterm
3. Reinicia Wezterm

### Comandos de ayuda

```vim
:checkhealth          " Diagnostico general
:Lazy                 " Gestor de plugins
:Mason                " Gestor de LSP/herramientas
:LspInfo              " Info del LSP actual
:messages             " Ver mensajes/errores
```

---

## Resumen de Keymaps Principales

### Mas Usados

| Tecla | Accion |
|-------|--------|
| `Space` | Leader |
| `Ctrl+s` | Guardar |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar texto |
| `<leader>e` | Explorador |
| `gd` | Ir a definicion |
| `K` | Documentacion |
| `<leader>ca` | Code actions |
| `F5` | Debug |
| `F9` | Breakpoint |
| `Ctrl+o` | OpenCode |
| `<leader>gg` | LazyGit |

### Cheat Sheet Visual

```
┌─────────────────────────────────────────────────────────────┐
│  NORMAL MODE                                                │
├─────────────────────────────────────────────────────────────┤
│  h j k l     Movimiento basico                              │
│  w b e       Por palabras                                   │
│  0 $ ^       Inicio/fin de linea                            │
│  gg G        Inicio/fin de archivo                          │
│  Ctrl+d/u    Media pagina abajo/arriba                      │
│  /texto      Buscar                                         │
│  n N         Siguiente/anterior resultado                   │
├─────────────────────────────────────────────────────────────┤
│  i a o       Entrar a INSERT mode                           │
│  v V Ctrl+v  Entrar a VISUAL mode                           │
│  :           Entrar a COMMAND mode                          │
├─────────────────────────────────────────────────────────────┤
│  d + motion  Borrar                                         │
│  c + motion  Cambiar                                        │
│  y + motion  Copiar                                         │
│  p P         Pegar despues/antes                            │
│  u Ctrl+r    Deshacer/Rehacer                               │
│  .           Repetir ultimo comando                         │
├─────────────────────────────────────────────────────────────┤
│  Ctrl+h/j/k/l  Navegar ventanas                             │
│  <leader>e     Explorador                                   │
│  <leader>ff    Buscar archivos                              │
│  <leader>fg    Buscar texto                                 │
└─────────────────────────────────────────────────────────────┘
```

---

**Feliz coding!** 
