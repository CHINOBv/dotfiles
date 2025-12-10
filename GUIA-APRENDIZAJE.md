# Guia Paso a Paso para Dominar Neovim

## Introduccion

Esta guia esta disenada para llevarte de cero a productivo en Neovim. Cada nivel toma aproximadamente 1-2 semanas de practica diaria.

**Regla de oro**: No intentes aprender todo de golpe. Domina cada nivel antes de avanzar.

---

## Nivel 1: Supervivencia (Semana 1)

### Objetivo
Poder abrir, editar, guardar y cerrar archivos sin entrar en panico.

### Dia 1-2: Los Basicos Absolutos

#### Abrir y Cerrar

```bash
nvim archivo.txt    # Abrir archivo
nvim .              # Abrir directorio actual
```

**Memoriza estas 4 cosas:**

| Tecla | Accion | Mnemonic |
|-------|--------|----------|
| `i` | Modo insertar | **I**nsert |
| `Esc` | Volver a normal | **Esc**apar |
| `:w` | Guardar | **W**rite |
| `:q` | Salir | **Q**uit |

**Practica:**
1. Abre nvim
2. Presiona `i` para escribir
3. Escribe "Hola mundo"
4. Presiona `Esc`
5. Escribe `:wq` y Enter para guardar y salir

#### Ejercicio del Dia
- Crea 5 archivos de texto
- Escribe algo en cada uno
- Guarda y cierra

### Dia 3-4: Movimiento Basico

**En modo NORMAL (presiona Esc primero):**

| Tecla | Movimiento |
|-------|------------|
| `h` | Izquierda |
| `j` | Abajo |
| `k` | Arriba |
| `l` | Derecha |

**Por que hjkl?**
- Estan en la fila central del teclado
- Tus dedos no se mueven de la posicion base
- Con practica, es mas rapido que las flechas

**Practica:**
1. Abre un archivo con texto
2. Navega SOLO con hjkl (nada de flechas!)
3. Hazlo por 15 minutos

#### Consejo
Pon un post-it en tu monitor:
```
h = izquierda
j = abajo (la j "baja")
k = arriba
l = derecha
```

### Dia 5-7: Entrar y Salir de Insert Mode

| Tecla | Accion |
|-------|--------|
| `i` | Insertar antes del cursor |
| `a` | Insertar despues del cursor |
| `o` | Nueva linea abajo e insertar |
| `O` | Nueva linea arriba e insertar |
| `Esc` | Volver a normal |

**Practica:**
1. Navega a diferentes posiciones
2. Usa `i`, `a`, `o`, `O` para insertar texto
3. Siempre vuelve a Normal con `Esc`

### Evaluacion Nivel 1

Puedes pasar al siguiente nivel si:
- [ ] Abres archivos sin problema
- [ ] Navegas con hjkl sin pensar
- [ ] Entras y sales de Insert mode fluidamente
- [ ] Guardas y cierras archivos

---

## Nivel 2: Eficiencia Basica (Semana 2)

### Objetivo
Editar texto mas rapido que en un editor normal.

### Dia 1-2: Movimiento por Palabras

| Tecla | Accion | Mnemonic |
|-------|--------|----------|
| `w` | Siguiente palabra | **W**ord |
| `b` | Palabra anterior | **B**ack |
| `e` | Final de palabra | **E**nd |

**Practica:**
```
El rapido zorro marron salta sobre el perro perezoso.
```
1. Posicionate al inicio
2. Presiona `w` varias veces - observa donde para
3. Presiona `b` para ir atras
4. Presiona `e` para ir al final de cada palabra

### Dia 3-4: Movimiento por Linea

| Tecla | Accion |
|-------|--------|
| `0` | Inicio de linea |
| `$` | Final de linea |
| `^` | Primer caracter no-blanco |

**Practica:**
```
    function ejemplo() {
        console.log("hola");
    }
```
1. Presiona `0` - vas al inicio absoluto
2. Presiona `^` - vas a "function"
3. Presiona `$` - vas al final

### Dia 5: Borrar Texto

| Tecla | Accion | Mnemonic |
|-------|--------|----------|
| `x` | Borrar caracter | Como la X de tachar |
| `dd` | Borrar linea | **D**elete line |
| `dw` | Borrar palabra | **D**elete **W**ord |
| `d$` o `D` | Borrar hasta fin de linea | |

**Concepto clave: OPERADOR + MOVIMIENTO**

`d` es el operador "delete". Se combina con movimientos:
- `d` + `w` = borrar palabra
- `d` + `$` = borrar hasta final
- `d` + `3j` = borrar 3 lineas abajo

### Dia 6: Deshacer y Repetir

| Tecla | Accion |
|-------|--------|
| `u` | Deshacer |
| `Ctrl+r` | Rehacer |
| `.` | Repetir ultimo comando |

**El poder del punto (.)**

El `.` repite tu ultima accion. Ejemplo:
1. `dw` borra una palabra
2. Muevete a otra palabra
3. `.` la borra tambien
4. Muevete a otra
5. `.` la borra

### Dia 7: Copiar y Pegar

| Tecla | Accion | Mnemonic |
|-------|--------|----------|
| `yy` | Copiar linea | **Y**ank (copiar en Vim) |
| `yw` | Copiar palabra | |
| `p` | Pegar despues | **P**aste |
| `P` | Pegar antes | |

**Practica: Duplicar lineas**
1. `yy` copia la linea actual
2. `p` la pega abajo
3. `yyp` = duplicar linea (muy util!)

### Evaluacion Nivel 2

Puedes pasar si:
- [ ] Te mueves por palabras sin pensar
- [ ] Borras texto eficientemente con d + movimiento
- [ ] Usas `.` para repetir acciones
- [ ] Copias y pegas con yy y p

---

## Nivel 3: Edicion Inteligente (Semana 3)

### Objetivo
Usar combinaciones que hacen la edicion 10x mas rapida.

### Dia 1-2: El Operador Change (c)

`c` = borrar + entrar en insert mode

| Comando | Accion |
|---------|--------|
| `cw` | Cambiar palabra |
| `c$` o `C` | Cambiar hasta fin de linea |
| `cc` | Cambiar linea completa |

**Practica:**
```javascript
const nombre = "valor_incorrecto";
```
1. Posicionate en "valor_incorrecto"
2. `cw` - borra la palabra y te deja en insert
3. Escribe "valor_correcto"
4. `Esc`

### Dia 3-4: Text Objects (El Superpoder de Vim)

Los text objects te permiten operar sobre estructuras.

**Sintaxis: `[operador] + [i/a] + [objeto]`**

- `i` = **i**nner (dentro de)
- `a` = **a**round (incluyendo delimitadores)

| Objeto | Descripcion |
|--------|-------------|
| `w` | palabra |
| `"` | comillas dobles |
| `'` | comillas simples |
| `(` o `)` | parentesis |
| `{` o `}` | llaves |
| `[` o `]` | corchetes |
| `t` | tag HTML |

**Ejemplos magicos:**

```javascript
const mensaje = "Hola mundo";
```
- Cursor en cualquier parte de "Hola mundo"
- `ci"` → Cambia el contenido dentro de las comillas
- `ca"` → Cambia incluyendo las comillas

```javascript
function ejemplo(parametro1, parametro2) {
    return resultado;
}
```
- Cursor dentro de los parentesis
- `ci(` → Cambia los parametros
- `di{` → Borra el contenido de la funcion

**Practica intensiva:**
```html
<div class="container">
    <p>Texto de ejemplo</p>
</div>
```
1. `cit` - cambia dentro del tag p
2. `dat` - borra el tag p completo
3. `ci"` - cambia el valor de class

### Dia 5-6: Busqueda en Linea

| Tecla | Accion |
|-------|--------|
| `f{char}` | Ir al siguiente {char} |
| `F{char}` | Ir al anterior {char} |
| `t{char}` | Ir antes del siguiente {char} |
| `T{char}` | Ir despues del anterior {char} |
| `;` | Repetir busqueda |
| `,` | Repetir busqueda (direccion opuesta) |

**Ejemplo:**
```
const resultado = calcular(valor1, valor2);
```
- `f=` - salta al `=`
- `f,` - salta a la primera `,`
- `;` - salta a la siguiente `,`
- `ct)` - cambia hasta antes del `)`

### Dia 7: Numeros + Comandos

Puedes multiplicar cualquier comando con numeros:

| Comando | Accion |
|---------|--------|
| `5j` | Bajar 5 lineas |
| `3w` | Avanzar 3 palabras |
| `2dd` | Borrar 2 lineas |
| `4p` | Pegar 4 veces |
| `10x` | Borrar 10 caracteres |

**Con lineas relativas:**
Los numeros a la izquierda te dicen exactamente cuantas lineas:
```
  5 │ function foo() {
  4 │     const a = 1;
  3 │     const b = 2;
  2 │     const c = 3;
  1 │     return a + b + c;
300 │ } ← estas aqui
  1 │
  2 │ function bar() {
```
- `5k` - sube a `function foo()`
- `d5k` - borra desde aqui hasta `function foo()`

### Evaluacion Nivel 3

Puedes pasar si:
- [ ] Usas `c` + movimiento naturalmente
- [ ] Dominas `ci"`, `ci(`, `ci{` etc.
- [ ] Usas `f` y `t` para moverte en lineas
- [ ] Combinas numeros con comandos

---

## Nivel 4: Flujo de Trabajo (Semana 4)

### Objetivo
Trabajar con multiples archivos y ventanas eficientemente.

### Dia 1-2: Busqueda Global

| Comando | Accion |
|---------|--------|
| `/patron` | Buscar adelante |
| `?patron` | Buscar atras |
| `n` | Siguiente resultado |
| `N` | Resultado anterior |
| `*` | Buscar palabra bajo cursor |
| `#` | Buscar palabra bajo cursor (atras) |

**Practica:**
1. Abre un archivo con codigo
2. `/function` - busca "function"
3. `n` - siguiente
4. `N` - anterior
5. Posicionate en una variable
6. `*` - busca todas las ocurrencias

### Dia 3: Buscar y Reemplazar

```vim
:[rango]s/buscar/reemplazar/[flags]
```

| Comando | Accion |
|---------|--------|
| `:s/foo/bar/` | Reemplazar en linea actual |
| `:s/foo/bar/g` | Todas en linea actual |
| `:%s/foo/bar/g` | Todas en archivo |
| `:%s/foo/bar/gc` | Todas con confirmacion |

**Practica:**
```javascript
var nombre = "test";
var valor = "test";
var otro = "test";
```
1. `:%s/var/const/g` - cambia todos los var por const
2. `:%s/test/valor/gc` - con confirmacion (y/n/a/q)

### Dia 4-5: Multiples Archivos

**Telescope (Fuzzy Finder):**

| Comando | Accion |
|---------|--------|
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar texto en archivos |
| `<leader>fb` | Ver buffers abiertos |
| `<leader>fr` | Archivos recientes |

**Practica:**
1. `<leader>ff` - escribe parte del nombre
2. Usa `Ctrl+j/k` para navegar resultados
3. `Enter` para abrir

**Buffers:**

| Comando | Accion |
|---------|--------|
| `<S-h>` | Buffer anterior |
| `<S-l>` | Buffer siguiente |
| `<leader>bd` | Cerrar buffer |

### Dia 6-7: Ventanas

| Comando | Accion |
|---------|--------|
| `<leader>-` | Split horizontal |
| `<leader>\|` | Split vertical |
| `Ctrl+h/j/k/l` | Navegar ventanas |
| `Ctrl+w q` | Cerrar ventana |
| `Ctrl+w o` | Cerrar otras ventanas |

**Practica:**
1. Abre un archivo
2. `<leader>|` - split vertical
3. `<leader>ff` - abre otro archivo
4. `Ctrl+h` / `Ctrl+l` para moverte entre ellos

### Evaluacion Nivel 4

Puedes pasar si:
- [ ] Buscas y reemplazas sin pensar
- [ ] Navegas entre archivos con Telescope
- [ ] Manejas multiples buffers
- [ ] Usas splits cuando necesitas ver varios archivos

---

## Nivel 5: Productividad (Semana 5-6)

### Objetivo
Usar las herramientas especificas de desarrollo.

### LSP (IntelliSense)

| Comando | Accion |
|---------|--------|
| `gd` | Ir a definicion |
| `gr` | Ver referencias |
| `K` | Ver documentacion |
| `<leader>ca` | Code actions |
| `<leader>cr` | Renombrar simbolo |
| `]d` / `[d` | Siguiente/anterior diagnostico |

**Practica:**
1. Abre un archivo .cs
2. Posicionate en una clase/metodo
3. `gd` - ve a su definicion
4. `Ctrl+o` - vuelve atras
5. `gr` - ve donde se usa

### Autocompletado

| Tecla | Accion |
|-------|--------|
| `Ctrl+Space` | Abrir menu |
| `Ctrl+n/p` | Navegar opciones |
| `Enter` | Aceptar |
| `Tab` | Aceptar y expandir snippet |

### Explorador de Archivos

| Comando | Accion |
|---------|--------|
| `<leader>e` | Toggle explorador |
| `a` | Crear archivo |
| `d` | Eliminar |
| `r` | Renombrar |
| `c` / `p` | Copiar / Pegar |

### Diagnosticos

| Comando | Accion |
|---------|--------|
| `]d` | Siguiente error/warning |
| `[d` | Anterior error/warning |
| `<leader>xx` | Lista de diagnosticos |

### Evaluacion Nivel 5

Puedes pasar si:
- [ ] Navegas codigo con gd, gr, K
- [ ] Usas autocompletado eficientemente
- [ ] Manejas archivos desde Neo-tree
- [ ] Corriges errores rapidamente

---

## Nivel 6: Debugging (Semana 7)

### Objetivo
Debuggear aplicaciones .NET como un pro.

### Flujo de Debug

1. **Compilar**: `<leader>Nb` (dotnet build)
2. **Poner breakpoint**: `F9` en la linea deseada
3. **Iniciar debug**: `F5` → seleccionar proyecto
4. **Ejecutar**: Hacer request/ejecutar codigo
5. **Navegar**: F10 (step over), F11 (step into)
6. **Terminar**: `Shift+F5`

### Keymaps de Debug

| Tecla | Accion |
|-------|--------|
| `F5` | Iniciar/Continuar |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `Shift+F11` | Step out |
| `Shift+F5` | Terminar |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluar expresion |

### Practica

1. Abre un Controller
2. Pon un breakpoint en un endpoint
3. `F5` → DX Api
4. Haz una request con curl/Postman
5. Cuando pare, inspecciona variables
6. `F10` para avanzar linea por linea

---

## Nivel 7: Maestria (Semana 8+)

### Objetivo
Tecnicas avanzadas para maxima eficiencia.

### Macros

Grabar secuencia de comandos para repetir:

```
qa          " Empezar a grabar en registro 'a'
<comandos>  " Lo que quieras hacer
q           " Parar de grabar
@a          " Reproducir macro
@@          " Repetir ultima macro
10@a        " Repetir 10 veces
```

**Ejemplo practico:**
Tienes:
```
nombre1
nombre2
nombre3
```
Quieres:
```
const nombre1 = "";
const nombre2 = "";
const nombre3 = "";
```

1. Posicionate en la primera linea
2. `qa` - empieza a grabar
3. `I` - insert al inicio
4. `const ` - escribe
5. `Esc` - vuelve a normal
6. `A` - insert al final
7. ` = "";` - escribe
8. `Esc` - vuelve a normal
9. `j` - baja una linea
10. `q` - para de grabar
11. `2@a` - repite 2 veces

### Marks (Marcadores)

```
ma          " Crear mark 'a' aqui
'a          " Ir a linea del mark
`a          " Ir a posicion exacta
:marks      " Ver todos los marks
```

**Marks especiales:**
- `''` - Posicion antes del ultimo salto
- `'.` - Posicion de ultimo cambio
- `'^` - Posicion de ultima insercion

### Registers

Vim tiene multiples "clipboards":

```
"ayy        " Copiar linea al registro 'a'
"ap         " Pegar del registro 'a'
"+y         " Copiar al clipboard del sistema
"+p         " Pegar del clipboard del sistema
:reg        " Ver todos los registros
```

### Comandos Globales

```vim
" Borrar todas las lineas que contienen "debug"
:g/debug/d

" Borrar todas las lineas vacias
:g/^$/d

" Ejecutar comando en lineas que matchean
:g/TODO/normal! I// 
```

### Argumentos de Texto

```
" Cambiar argumento de funcion
cia         " Change inner argument

" function(arg1, arg2, arg3)
" Con cursor en arg2, cia cambia solo arg2
```

---

## Plan de Practica Diaria

### Rutina de 30 minutos

**Minutos 1-10: Calentamiento**
- Abre un archivo de codigo
- Navega solo con hjkl, w, b, e
- Practica f y t para moverte en lineas

**Minutos 11-20: Edicion**
- Practica ci", ci(, ci{
- Usa dw, cw, yw
- Practica . para repetir

**Minutos 21-30: Flujo de trabajo**
- Usa Telescope para buscar archivos
- Navega con gd, gr
- Practica con splits y buffers

### Retos Semanales

**Semana 1-2:**
- NO uses el mouse para nada
- NO uses las flechas del teclado

**Semana 3-4:**
- Cada vez que hagas algo repetitivo, piensa como automatizarlo
- Usa `.` al menos 20 veces al dia

**Semana 5-6:**
- Aprende 2 text objects nuevos por dia
- Practica macros con tareas reales

**Semana 7+:**
- Personaliza keymaps para tu flujo
- Contribuye a tu configuracion

---

## Errores Comunes y Como Evitarlos

### Error 1: Intentar aprender todo de golpe
**Solucion:** Sigue los niveles. Domina uno antes de avanzar.

### Error 2: Volver al mouse/flechas
**Solucion:** Desactiva el mouse. Forzate a usar hjkl.

### Error 3: No usar el punto (.)
**Solucion:** Cada vez que repitas algo, preguntate si pudiste usar `.`

### Error 4: No usar text objects
**Solucion:** `ci"` y `ci(` deberian ser tu pan de cada dia.

### Error 5: Quedarse en Insert mode
**Solucion:** Insert es solo para escribir. Editar es en Normal.

### Error 6: No usar busqueda
**Solucion:** `/`, `*`, y `f` son mas rapidos que navegar manualmente.

---

## Recursos Adicionales

### En Neovim
```vim
:Tutor              " Tutorial interactivo (30 min)
:help               " Documentacion completa
:help motion        " Ayuda sobre movimientos
:help text-objects  " Ayuda sobre text objects
```

### Juegos para Practicar
- **Vim Adventures** (vim-adventures.com) - Juego estilo Zelda
- **OpenVim** (openvim.com) - Tutorial interactivo
- **VimGolf** (vimgolf.com) - Retos de eficiencia

### Cheat Sheets
- Imprime un cheat sheet y tenlo al lado
- Revisa los keymaps: `<leader>sk` en Neovim

---

## Checklist Final de Maestria

### Nivel Basico
- [ ] Navego con hjkl sin pensar
- [ ] Uso i, a, o, O para insertar
- [ ] Guardo con :w y salgo con :q

### Nivel Intermedio
- [ ] Me muevo por palabras (w, b, e)
- [ ] Uso operadores (d, c, y) + movimientos
- [ ] Domino text objects (ci", ci(, etc.)
- [ ] Uso busqueda (/, *, n, N)
- [ ] Repito con . frecuentemente

### Nivel Avanzado
- [ ] Manejo multiples archivos con Telescope
- [ ] Uso splits y buffers eficientemente
- [ ] Navego codigo con LSP (gd, gr, K)
- [ ] Debuggeo con breakpoints

### Nivel Experto
- [ ] Creo macros para tareas repetitivas
- [ ] Uso registers para multiples clipboards
- [ ] Personalizo mi configuracion
- [ ] Ayudo a otros a aprender Vim

---

## Mensaje Final

Vim tiene una curva de aprendizaje empinada, pero la recompensa es enorme. Despues de unas semanas de practica, seras mas rapido que con cualquier otro editor.

**La clave es la consistencia:**
- 30 minutos diarios > 5 horas el fin de semana
- Usa Vim para TODO (notas, codigo, configs)
- Se paciente contigo mismo

**Recuerda:**
> "Vim no es dificil. Es diferente."

Cada comando que aprendes se suma a tu arsenal. Con el tiempo, editar texto se vuelve como tocar un instrumento - tus dedos saben que hacer sin que pienses.

**Buena suerte y feliz Vimming!**
