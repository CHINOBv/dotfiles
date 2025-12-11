-- Snippets personalizados para C# y desarrollo .NET
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local fmt = require("luasnip.extras.fmt").fmt

      -- Cargar snippets de friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Función para obtener el nombre del archivo sin extensión
      local function filename()
        return vim.fn.expand("%:t:r")
      end

      -- Función helper para repetir nodos
      local function rep(idx)
        return f(function(args)
          return args[1]
        end, { idx })
      end

      -- ============================================
      -- SNIPPETS DE C#
      -- ============================================
      ls.add_snippets("cs", {
        -- Clase
        s("class", fmt([[
public class {}
{{
    {}
}}
]], { i(1, "ClassName"), i(0) })),

        -- Clase con namespace
        s("classns", fmt([[
namespace {}
{{
    public class {}
    {{
        {}
    }}
}}
]], { i(1, "Namespace"), i(2, "ClassName"), i(0) })),

        -- Interface
        s("interface", fmt([[
public interface I{}
{{
    {}
}}
]], { i(1, "Name"), i(0) })),

        -- Record
        s("record", fmt([[
public record {}({});
]], { i(1, "RecordName"), i(2, "string Property") })),

        -- Record con body
        s("recordb", fmt([[
public record {}({})
{{
    {}
}}
]], { i(1, "RecordName"), i(2, "string Property"), i(0) })),

        -- Constructor
        s("ctor", fmt([[
public {}({})
{{
    {}
}}
]], { f(filename), i(1), i(0) })),

        -- Constructor con inyección de dependencias
        s("ctordi", fmt([[
private readonly {} _{};

public {}({} {})
{{
    _{} = {};
}}
]], { 
  i(1, "IService"), 
  i(2, "service"),
  f(filename),
  rep(1),
  rep(2),
  rep(2),
  rep(2),
})),

        -- Propiedad
        s("prop", fmt([[
public {} {} {{ get; set; }}
]], { i(1, "string"), i(2, "Name") })),

        -- Propiedad con init
        s("propi", fmt([[
public {} {} {{ get; init; }}
]], { i(1, "string"), i(2, "Name") })),

        -- Propiedad required
        s("propr", fmt([[
public required {} {} {{ get; set; }}
]], { i(1, "string"), i(2, "Name") })),

        -- Propiedad privada con backing field
        s("propf", fmt([[
private {} _{};
public {} {}
{{
    get => _{};
    set => _{} = value;
}}
]], { i(1, "string"), i(2, "name"), rep(1), i(3, "Name"), rep(2), rep(2) })),

        -- Método
        s("method", fmt([[
public {} {}({})
{{
    {}
}}
]], { i(1, "void"), i(2, "MethodName"), i(3), i(0) })),

        -- Método async
        s("methodasync", fmt([[
public async Task<{}> {}Async({})
{{
    {}
}}
]], { i(1, "bool"), i(2, "MethodName"), i(3), i(0) })),

        -- Método async void
        s("methodasyncv", fmt([[
public async Task {}Async({})
{{
    {}
}}
]], { i(1, "MethodName"), i(2), i(0) })),

        -- Try-catch
        s("try", fmt([[
try
{{
    {}
}}
catch (Exception ex)
{{
    {}
}}
]], { i(1), i(0, "throw;") })),

        -- Try-catch-finally
        s("tryf", fmt([[
try
{{
    {}
}}
catch (Exception ex)
{{
    {}
}}
finally
{{
    {}
}}
]], { i(1), i(2, "throw;"), i(0) })),

        -- If
        s("if", fmt([[
if ({})
{{
    {}
}}
]], { i(1, "condition"), i(0) })),

        -- If-else
        s("ife", fmt([[
if ({})
{{
    {}
}}
else
{{
    {}
}}
]], { i(1, "condition"), i(2), i(0) })),

        -- For loop
        s("for", fmt([[
for (int {} = 0; {} < {}; {}++)
{{
    {}
}}
]], { i(1, "i"), rep(1), i(2, "length"), rep(1), i(0) })),

        -- Foreach
        s("foreach", fmt([[
foreach (var {} in {})
{{
    {}
}}
]], { i(1, "item"), i(2, "collection"), i(0) })),

        -- While
        s("while", fmt([[
while ({})
{{
    {}
}}
]], { i(1, "condition"), i(0) })),

        -- Switch
        s("switch", fmt([[
switch ({})
{{
    case {}:
        {}
        break;
    default:
        {}
        break;
}}
]], { i(1, "variable"), i(2, "value"), i(3), i(0) })),

        -- Switch expression
        s("switchex", fmt([[
var result = {} switch
{{
    {} => {},
    _ => {}
}};
]], { i(1, "variable"), i(2, "pattern"), i(3, "value"), i(0, "defaultValue") })),

        -- LINQ Select
        s("select", fmt([[
.Select({} => {})
]], { i(1, "x"), i(0, "x") })),

        -- LINQ Where
        s("where", fmt([[
.Where({} => {})
]], { i(1, "x"), i(0, "x.Property == value") })),

        -- LINQ FirstOrDefault
        s("first", fmt([[
.FirstOrDefault({} => {})
]], { i(1, "x"), i(0, "x.Id == id") })),

        -- Async/Await
        s("await", fmt([[
await {}
]], { i(0) })),

        -- Logger
        s("log", fmt([[
_logger.Log{}("{}")
]], { c(1, { t("Information"), t("Warning"), t("Error"), t("Debug") }), i(0, "Message") })),

        -- Logger con interpolación
        s("logi", fmt([[
_logger.Log{}("{}: {{{}}}", {})
]], { c(1, { t("Information"), t("Warning"), t("Error"), t("Debug") }), i(2, "Message"), i(3, "Variable"), i(0, "variable") })),

        -- Controller Action
        s("action", fmt([[
[Http{}("{}")]
public async Task<IActionResult> {}({})
{{
    {}
    return Ok();
}}
]], { c(1, { t("Get"), t("Post"), t("Put"), t("Delete"), t("Patch") }), i(2), i(3, "ActionName"), i(4), i(0) })),

        -- Controller GET
        s("httpget", fmt([[
[HttpGet("{}")]
public async Task<IActionResult> {}()
{{
    {}
    return Ok();
}}
]], { i(1), i(2, "Get"), i(0) })),

        -- Controller POST
        s("httppost", fmt([[
[HttpPost("{}")]
public async Task<IActionResult> {}([FromBody] {} request)
{{
    {}
    return Ok();
}}
]], { i(1), i(2, "Create"), i(3, "CreateRequest"), i(0) })),

        -- Controller con ID
        s("httpgetid", fmt([[
[HttpGet("{{{}}})"]
public async Task<IActionResult> {}({} {})
{{
    {}
    return Ok();
}}
]], { i(1, "id"), i(2, "GetById"), i(3, "Guid"), rep(1), i(0) })),

        -- Mediator Send
        s("mediator", fmt([[
var result = await _mediator.Send(new {}({}));
]], { i(1, "Command"), i(0) })),

        -- Entity Framework DbSet
        s("dbset", fmt([[
public DbSet<{}> {} {{ get; set; }}
]], { i(1, "Entity"), i(2, "Entities") })),

        -- Xunit Test
        s("fact", fmt([[
[Fact]
public async Task {}()
{{
    // Arrange
    {}

    // Act
    {}

    // Assert
    {}
}}
]], { i(1, "Should_Expected_When_Condition"), i(2), i(3), i(0) })),

        -- Xunit Theory
        s("theory", fmt([[
[Theory]
[InlineData({})]
public async Task {}({})
{{
    // Arrange
    {}

    // Act
    {}

    // Assert
    {}
}}
]], { i(1), i(2, "Should_Expected_When_Condition"), i(3, "string input"), i(4), i(5), i(0) })),

        -- Region
        s("region", fmt([[
#region {}
{}
#endregion
]], { i(1, "Region Name"), i(0) })),

        -- Summary XML
        s("summary", fmt([[
/// <summary>
/// {}
/// </summary>
]], { i(0, "Description") })),

        -- Summary con params
        s("summaryp", fmt([[
/// <summary>
/// {}
/// </summary>
/// <param name="{}">{}</param>
/// <returns>{}</returns>
]], { i(1, "Description"), i(2, "param"), i(3, "Param description"), i(0, "Return description") })),

        -- Null check
        s("null", fmt([[
{} ?? throw new ArgumentNullException(nameof({}))
]], { i(1, "variable"), rep(1) })),

        -- Guard clause
        s("guard", fmt([[
if ({} is null)
    throw new ArgumentNullException(nameof({}));
]], { i(1, "variable"), rep(1) })),

        -- Disposable pattern
        s("dispose", fmt([[
private bool _disposed;

protected virtual void Dispose(bool disposing)
{{
    if (!_disposed)
    {{
        if (disposing)
        {{
            {}
        }}
        _disposed = true;
    }}
}}

public void Dispose()
{{
    Dispose(true);
    GC.SuppressFinalize(this);
}}
]], { i(0, "// Dispose managed resources") })),
      })

      -- ============================================
      -- SNIPPETS DE TYPESCRIPT/REACT
      -- ============================================
      ls.add_snippets("typescriptreact", {
        -- Functional Component
        s("rfc", fmt([[
import React from 'react';

interface {}Props {{
  {}
}}

export const {}: React.FC<{}Props> = ({{ {} }}) => {{
  return (
    <div>
      {}
    </div>
  );
}};
]], { i(1, "Component"), i(2), rep(1), rep(1), i(3), i(0) })),

        -- useState
        s("us", fmt([[
const [{}, set{}] = useState<{}>({}); 
]], { i(1, "state"), f(function(args) return args[1][1]:gsub("^%l", string.upper) end, {1}), i(2, "string"), i(0, "''") })),

        -- useEffect
        s("ue", fmt([[
useEffect(() => {{
  {}
}}, [{}]);
]], { i(0), i(1) })),

        -- useCallback
        s("ucb", fmt([[
const {} = useCallback(({}) => {{
  {}
}}, [{}]);
]], { i(1, "callback"), i(2), i(0), i(3) })),

        -- useMemo
        s("um", fmt([[
const {} = useMemo(() => {{
  return {};
}}, [{}]);
]], { i(1, "value"), i(0), i(2) })),

        -- useRef
        s("ur", fmt([[
const {} = useRef<{}>({}); 
]], { i(1, "ref"), i(2, "HTMLDivElement"), i(0, "null") })),

        -- Custom Hook
        s("hook", fmt([[
import {{ useState, useEffect }} from 'react';

export const use{} = ({}) => {{
  const [{}, set{}] = useState<{}>({}); 

  useEffect(() => {{
    {}
  }}, []);

  return {{ {} }};
}};
]], { i(1, "CustomHook"), i(2), i(3, "state"), rep(3), i(4, "any"), i(5, "null"), i(6), i(0) })),
      })

      -- TypeScript snippets
      ls.add_snippets("typescript", {
        -- Interface
        s("int", fmt([[
interface {} {{
  {}
}}
]], { i(1, "IName"), i(0) })),

        -- Type
        s("type", fmt([[
type {} = {{
  {}
}};
]], { i(1, "TypeName"), i(0) })),

        -- Async function
        s("afn", fmt([[
async function {}({}): Promise<{}> {{
  {}
}}
]], { i(1, "name"), i(2), i(3, "void"), i(0) })),

        -- Arrow async function
        s("aafn", fmt([[
const {} = async ({}): Promise<{}> => {{
  {}
}};
]], { i(1, "name"), i(2), i(3, "void"), i(0) })),

        -- Try-catch async
        s("tryc", fmt([[
try {{
  {}
}} catch (error) {{
  console.error('Error:', error);
  {}
}}
]], { i(1), i(0) })),

        -- NestJS Controller
        s("nestctrl", fmt([[
import {{ Controller, Get, Post, Body, Param }} from '@nestjs/common';

@Controller('{}')
export class {}Controller {{
  constructor(private readonly {}Service: {}Service) {{}}

  @Get()
  findAll() {{
    return this.{}Service.findAll();
  }}

  @Get(':id')
  findOne(@Param('id') id: string) {{
    return this.{}Service.findOne(id);
  }}

  @Post()
  create(@Body() dto: {}) {{
    return this.{}Service.create(dto);
  }}
}}
]], { i(1, "resource"), i(2, "Resource"), i(3, "resource"), rep(2), rep(3), rep(3), i(4, "CreateDto"), rep(3) })),

        -- NestJS Service
        s("nestsvc", fmt([[
import {{ Injectable }} from '@nestjs/common';

@Injectable()
export class {}Service {{
  findAll() {{
    {}
  }}

  findOne(id: string) {{
    {}
  }}

  create(dto: {}) {{
    {}
  }}
}}
]], { i(1, "Resource"), i(2), i(3), i(4, "CreateDto"), i(0) })),

        -- Express Router
        s("exprouter", fmt([[
import {{ Router }} from 'express';

const router = Router();

router.get('/', async (req, res) => {{
  {}
}});

router.get('/:id', async (req, res) => {{
  const {{ id }} = req.params;
  {}
}});

router.post('/', async (req, res) => {{
  const body = req.body;
  {}
}});

export default router;
]], { i(1), i(2), i(0) })),
      })

      -- Extend to JavaScript/JSX
      ls.filetype_extend("javascript", { "typescript" })
      ls.filetype_extend("javascriptreact", { "typescriptreact", "typescript" })

      -- ============================================
      -- SNIPPETS DE GO
      -- ============================================
      ls.add_snippets("go", {
        -- Main function
        s("main", fmt([[
package main

func main() {{
	{}
}}
]], { i(0) })),

        -- Function
        s("fn", fmt([[
func {}({}) {} {{
	{}
}}
]], { i(1, "name"), i(2), i(3, "error"), i(0) })),

        -- Method
        s("meth", fmt([[
func ({} *{}) {}({}) {} {{
	{}
}}
]], { i(1, "r"), i(2, "Receiver"), i(3, "Method"), i(4), i(5, "error"), i(0) })),

        -- Struct
        s("st", fmt([[
type {} struct {{
	{}
}}
]], { i(1, "Name"), i(0) })),

        -- Interface
        s("iface", fmt([[
type {} interface {{
	{}
}}
]], { i(1, "Name"), i(0) })),

        -- If error
        s("ife", fmt([[
if err != nil {{
	return {}
}}
]], { i(0, "err") })),

        -- HTTP Handler
        s("hfunc", fmt([[
func {}(w http.ResponseWriter, r *http.Request) {{
	{}
}}
]], { i(1, "handler"), i(0) })),

        -- Test function
        s("test", fmt([[
func Test{}(t *testing.T) {{
	{}
}}
]], { i(1, "Name"), i(0) })),

        -- Table driven test
        s("ttest", fmt([[
func Test{}(t *testing.T) {{
	tests := []struct {{
		name string
		{}
	}}{{
		{{
			name: "{}",
			{}
		}},
	}}

	for _, tt := range tests {{
		t.Run(tt.name, func(t *testing.T) {{
			{}
		}})
	}}
}}
]], { i(1, "Name"), i(2, "input string"), i(3, "test case"), i(4), i(0) })),

        -- Goroutine
        s("go", fmt([[
go func() {{
	{}
}}()
]], { i(0) })),

        -- Select
        s("sel", fmt([[
select {{
case {}:
	{}
default:
	{}
}}
]], { i(1, "<-ch"), i(2), i(0) })),

        -- Defer
        s("def", fmt([[
defer func() {{
	{}
}}()
]], { i(0) })),

        -- Context with timeout
        s("ctx", fmt([[
ctx, cancel := context.WithTimeout(context.Background(), {}*time.Second)
defer cancel()
{}
]], { i(1, "5"), i(0) })),
      })

      -- ============================================
      -- SNIPPETS DE DART/FLUTTER
      -- ============================================
      ls.add_snippets("dart", {
        -- Stateless Widget
        s("stl", fmt([[
class {} extends StatelessWidget {{
  const {}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return {};
  }}
}}
]], { i(1, "MyWidget"), rep(1), i(0, "Container()") })),

        -- Stateful Widget
        s("stf", fmt([[
class {} extends StatefulWidget {{
  const {}({{super.key}});

  @override
  State<{}> createState() => _{}State();
}}

class _{}State extends State<{}> {{
  @override
  Widget build(BuildContext context) {{
    return {};
  }}
}}
]], { i(1, "MyWidget"), rep(1), rep(1), rep(1), rep(1), rep(1), i(0, "Container()") })),

        -- Build method
        s("build", fmt([[
@override
Widget build(BuildContext context) {{
  return {};
}}
]], { i(0, "Container()") })),

        -- InitState
        s("init", fmt([[
@override
void initState() {{
  super.initState();
  {}
}}
]], { i(0) })),

        -- Dispose
        s("dispose", fmt([[
@override
void dispose() {{
  {}
  super.dispose();
}}
]], { i(0) })),

        -- Consumer (Riverpod)
        s("cons", fmt([[
Consumer(
  builder: (context, ref, child) {{
    final {} = ref.watch({});
    return {};
  }},
)
]], { i(1, "state"), i(2, "provider"), i(0, "Container()") })),

        -- FutureBuilder
        s("futb", fmt([[
FutureBuilder<{}>(
  future: {},
  builder: (context, snapshot) {{
    if (snapshot.connectionState == ConnectionState.waiting) {{
      return const CircularProgressIndicator();
    }}
    if (snapshot.hasError) {{
      return Text('Error: ${{snapshot.error}}');
    }}
    final data = snapshot.data!;
    return {};
  }},
)
]], { i(1, "Type"), i(2, "future"), i(0, "Container()") })),

        -- StreamBuilder
        s("strb", fmt([[
StreamBuilder<{}>(
  stream: {},
  builder: (context, snapshot) {{
    if (!snapshot.hasData) {{
      return const CircularProgressIndicator();
    }}
    final data = snapshot.data!;
    return {};
  }},
)
]], { i(1, "Type"), i(2, "stream"), i(0, "Container()") })),

        -- BlocBuilder
        s("blocb", fmt([[
BlocBuilder<{}, {}>(
  builder: (context, state) {{
    return {};
  }},
)
]], { i(1, "Bloc"), i(2, "State"), i(0, "Container()") })),

        -- BlocListener
        s("blocl", fmt([[
BlocListener<{}, {}>(
  listener: (context, state) {{
    {}
  }},
  child: {},
)
]], { i(1, "Bloc"), i(2, "State"), i(3), i(0, "Container()") })),

        -- Freezed class
        s("freezed", fmt([[
@freezed
class {} with _${} {{
  const factory {}({{
    {}
  }}) = _{};
}}
]], { i(1, "MyClass"), rep(1), rep(1), i(0, "required String name,"), rep(1) })),
      })

      -- ============================================
      -- SNIPPETS DE DOCKERFILE
      -- ============================================
      ls.add_snippets("dockerfile", {
        -- Basic Dockerfile
        s("dock", fmt([[
FROM {}

WORKDIR /app

COPY {} .

RUN {}

EXPOSE {}

CMD [{}]
]], { i(1, "node:18-alpine"), i(2, "package*.json"), i(3, "npm install"), i(4, "3000"), i(0, '"npm", "start"') })),

        -- Multi-stage build
        s("multi", fmt([[
# Build stage
FROM {} AS builder

WORKDIR /app

COPY . .

RUN {}

# Production stage
FROM {}

WORKDIR /app

COPY --from=builder /app/{} .

EXPOSE {}

CMD [{}]
]], { i(1, "node:18-alpine"), i(2, "npm ci && npm run build"), i(3, "node:18-alpine"), i(4, "dist"), i(5, "3000"), i(0, '"node", "dist/main.js"') })),

        -- .NET Dockerfile
        s("docknet", fmt([[
FROM mcr.microsoft.com/dotnet/sdk:{} AS build
WORKDIR /src

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:{}
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE {}
ENTRYPOINT ["dotnet", "{}.dll"]
]], { i(1, "8.0"), rep(1), i(2, "8080"), i(0, "MyApp") })),

        -- Go Dockerfile
        s("dockgo", fmt([[
FROM golang:{}-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/main .

EXPOSE {}
CMD ["./main"]
]], { i(1, "1.21"), i(0, "8080") })),
      })

      -- Configuración de LuaSnip
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    end,
    -- Tab/S-Tab para snippets ya está manejado por LazyVim/nvim-cmp
  },
}
