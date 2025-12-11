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
