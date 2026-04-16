# Skill Registry

**Delegator use only.** Any agent that launches sub-agents reads this registry to resolve compact rules, then injects them directly into sub-agent prompts. Sub-agents do NOT read this registry or individual SKILL.md files.

See `_shared/skill-resolver.md` for the full resolution protocol.

## User Skills

| Trigger | Skill | Path |
|---------|-------|------|
| User writes `/api-contract`, asks to define/document REST endpoints, or `sdd-spec` needs external HTTP contracts | api-contract-specialist | /home/david/.config/opencode/skills/api-contract-specialist/SKILL.md |
| User says judgment day / dual review / adversarial review | judgment-day | /home/david/.config/opencode/skills/judgment-day/SKILL.md |
| Creating a GitHub issue, bug report, or feature request | issue-creation | /home/david/.config/opencode/skills/issue-creation/SKILL.md |
| Creating a pull request or preparing changes for review | branch-pr | /home/david/.config/opencode/skills/branch-pr/SKILL.md |
| Creating a new AI skill or documenting reusable AI instructions | skill-creator | /home/david/.config/opencode/skills/skill-creator/SKILL.md |
| Writing Go tests, teatest/Bubbletea testing, or adding Go test coverage | go-testing | /home/david/.config/opencode/skills/go-testing/SKILL.md |
| Accessibility audit, WCAG compliance, keyboard navigation, screen reader support | accessibility-auditor | /home/david/.agents/skills/accessibility-auditor/SKILL.md |
| Software architecture patterns and best practices | architecture-patterns | /home/david/.agents/skills/architecture-patterns/SKILL.md |
| Clean architecture, layer separation, dependency rules | clean-architecture | /home/david/.agents/skills/clean-architecture/SKILL.md |
| DDD / hexagonal / ports and adapters / aggregates / CQRS | clean-ddd-hexagonal | /home/david/.agents/skills/clean-ddd-hexagonal/SKILL.md |
| Docker containerization, compose, image/build workflows | docker | /home/david/.agents/skills/docker/SKILL.md |
| .NET 8 minimal APIs, EF Core, CQRS, JWT | dotnet-core-expert | /home/david/.agents/skills/dotnet-core-expert/SKILL.md |
| Looking for an installable skill or capability discovery | find-skills | /home/david/.agents/skills/find-skills/SKILL.md |
| GCP infrastructure, GKE, Cloud Run, Storage, Pub/Sub | gcp | /home/david/.agents/skills/gcp/SKILL.md |
| Deploying containerized apps to Cloud Run | gcp-cloud-run | /home/david/.agents/skills/gcp-cloud-run/SKILL.md |
| NestJS modules/controllers/providers/DTOs/testing | nestjs-best-practices | /home/david/.agents/skills/nestjs-best-practices/SKILL.md |
| NestJS architecture/debugging/testing/auth issues | nestjs-expert | /home/david/.agents/skills/nestjs-expert/SKILL.md |
| NextAuth/Auth.js v5 authentication in Next.js | nextauth-authentication | /home/david/.agents/skills/nextauth-authentication/SKILL.md |
| Modern React hooks/composition/performance patterns | react-patterns | /home/david/.agents/skills/react-patterns/SKILL.md |
| React state management with Redux Toolkit/Zustand/Jotai/React Query | react-state-management | /home/david/.agents/skills/react-state-management/SKILL.md |
| React component testing with Vitest Browser Mode | react-testing | /home/david/.agents/skills/react-testing/SKILL.md |
| Redux Toolkit best practices in React/Next.js | redux-toolkit | /home/david/.agents/skills/redux-toolkit/SKILL.md |
| Refactor / code smell / technical debt / cleanup work | refactoring-surgeon | /home/david/.agents/skills/refactoring-surgeon/SKILL.md |
| shadcn/ui components, registry usage, presets, component composition | shadcn | /home/david/.agents/skills/shadcn/SKILL.md |
| System-level architecture, decomposition, scaling, ADRs | software-architecture-design | /home/david/.agents/skills/software-architecture-design/SKILL.md |
| Tailwind component/layout/responsive styling patterns | tailwind-patterns | /home/david/.agents/skills/tailwind-patterns/SKILL.md |
| Advanced TypeScript generics/conditional/mapped types | typescript-advanced-types | /home/david/.agents/skills/typescript-advanced-types/SKILL.md |
| TypeScript/NestJS E2E setup, writing, running, debugging, optimization | typescript-e2e-testing | /home/david/.agents/skills/typescript-e2e-testing/SKILL.md |
| Common UI patterns, forms, navigation, data display, accessibility | ui-design-patterns | /home/david/.agents/skills/ui-design-patterns/SKILL.md |
| React UI systems with Tailwind + Radix + shadcn/ui | ui-design-system | /home/david/.agents/skills/ui-design-system/SKILL.md |
| React/Next.js performance optimization from Vercel | vercel-react-best-practices | /home/david/.agents/skills/vercel-react-best-practices/SKILL.md |
| Website/webapp performance and Core Web Vitals optimization | web-performance-optimization | /home/david/.agents/skills/web-performance-optimization/SKILL.md |
| Playwright-based local webapp testing | webapp-testing | /home/david/.agents/skills/webapp-testing/SKILL.md |

## Compact Rules

Pre-digested rules per skill. Delegators copy matching blocks into sub-agent prompts as `## Project Standards (auto-resolved)`.

### api-contract-specialist
- Read the spec artifact first; if no spec exists, stop and request `sdd-spec`.
- Model each HTTP use case as command/query, actor, resource, auth, and side effects.
- Detect endpoint conflicts and classify them as REPLACES, EXTENDS, COEXISTS, or DUPLICATE.
- Document business meaning, request/response shapes, business-level errors, and auth explicitly.
- Add usage examples only when payload shape or validation is non-obvious.
- Mark ambiguities with `NEEDS CLARIFICATION` plus the assumption used in the draft.

### judgment-day
- Never review inline; launch two independent blind judges in parallel.
- Resolve and inject project standards before launching judges or the fix agent.
- Synthesize findings into confirmed, suspect, and contradiction buckets.
- Distinguish WARNING (real) from WARNING (theoretical); treat theoretical warnings as INFO.
- Ask the user before fixing confirmed issues after round 1.
- Re-judge only when confirmed critical issues justify another cycle.

### issue-creation
- Use the repo issue templates; blank issues are not acceptable.
- Every new issue gets `status:needs-review` and must later receive `status:approved` before a PR.
- Questions belong in Discussions, not Issues.
- Search for duplicates before creating anything.
- Fill all required template fields, including pre-flight checks and reproduction/problem details.
- Use the right template: bug report vs feature request.

### branch-pr
- Every PR must link exactly one approved issue.
- Branch names must follow `type/description` with lowercase `a-z0-9._-` only.
- PR must have exactly one `type:*` label.
- Use conventional commits only; never add `Co-Authored-By` trailers.
- Run shellcheck on modified shell scripts before opening the PR.
- Use the PR template with issue link, summary, change table, test plan, and checklist.

### skill-creator
- Create a skill only for reusable, non-trivial patterns.
- Use `skills/{skill-name}/SKILL.md` with complete frontmatter including trigger text.
- Put critical rules first; keep examples minimal and commands copy-pasteable.
- Use `assets/` for templates/schemas and `references/` only for local docs.
- Do not add keyword sections, troubleshooting sprawl, or web URLs in references.
- Register the new skill in `AGENTS.md` after creation.

### go-testing
- Prefer table-driven tests for multi-case behavior.
- Test Bubbletea model state transitions directly before higher-level flows.
- Use teatest for interactive TUI flows and golden files for visual output.
- Use `t.TempDir()` for filesystem work and mock command execution when possible.
- Cover both success and error paths explicitly.
- Keep assertions deterministic and focused on observable state.

### accessibility-auditor
- Prefer semantic HTML over ARIA workarounds whenever possible.
- Maintain correct heading hierarchy and landmark structure.
- Ensure full keyboard access, visible focus states, and screen-reader support.
- Add ARIA only to fill semantic gaps, not to patch bad markup lazily.
- Verify color contrast, labels, and interaction states against WCAG 2.1.
- Test with automated tools plus real keyboard/screen-reader flows when relevant.

### architecture-patterns
- Choose architecture based on team size, domain complexity, and deployment needs.
- Prefer simple modular structures before jumping to distributed systems.
- Design around business capabilities and explicit module boundaries.
- Separate shared concerns from feature modules.
- Treat event-driven, CQRS, and microservices as tradeoffs, not defaults.
- Document why a pattern fits the problem, not just what it is.

### clean-architecture
- Keep business rules independent from frameworks and infrastructure.
- Enforce inward dependency direction across layers.
- Isolate use cases from delivery and persistence details.
- Avoid leaking transport or database models into core logic.
- Define clear boundaries for entities, use cases, interfaces, and adapters.
- Prefer explicit interfaces where boundary inversion matters.

### clean-ddd-hexagonal
- Keep domain code free of HTTP, ORM, and database dependencies.
- Controllers/adapters never call repositories directly; go through application use cases.
- Use one repository per aggregate, not per table/entity.
- Model value objects by structural equality and entities by identity.
- Keep cross-aggregate consistency eventual unless a single transaction truly requires otherwise.
- Start simple; do not add CQRS/event sourcing unless the domain complexity justifies it.

### docker
- Order Dockerfile layers for cache efficiency: dependencies before app code.
- Prefer explicit, reproducible images and minimal runtime footprints.
- Use volumes for persistence and networks for service discovery.
- Keep build and runtime concerns separated, ideally with multi-stage builds.
- Treat containers as disposable; configuration belongs in env/config, not mutated images.
- Use Docker for consistent test/dev/prod environments, not as accidental complexity.

### dotnet-core-expert
- Use modern .NET/C# patterns: async I/O, nullable references, DI, DTO records.
- Follow clean architecture separation for APIs, domain, and persistence.
- Never expose EF entities directly in API responses.
- Validate inputs and document APIs with OpenAPI/Swagger.
- Prefer integration tests with WebApplicationFactory for end-to-end backend behavior.
- Avoid synchronous I/O, legacy .NET Framework patterns, and secrets in source files.

### find-skills
- Use `npx skills find <query>` with specific domain keywords.
- Present relevant skills with install command plus skills.sh link.
- Offer installation with `npx skills add <pkg> -g -y` only if the user wants it.
- If nothing relevant exists, say so directly and offer to help without a skill.
- Suggest creating a custom skill only when the pattern is recurring.
- Search terms should reflect the task, not vague categories.

### gcp
- Use `gcloud`/`gsutil`/`bq` commands appropriate to the target GCP service.
- Set and verify the active project before applying infrastructure changes.
- Treat GKE, Cloud Run, Storage, BigQuery, and Pub/Sub as separate operating models.
- Prefer scripted, reproducible operations over console-only steps.
- Keep credentials and project IDs out of committed source.
- Verify service-specific deployment/runtime settings explicitly.

### gcp-cloud-run
- Build and deploy stateless HTTP containers that listen on the Cloud Run port.
- Expose health/readiness endpoints and handle SIGTERM for graceful shutdown.
- Set memory/CPU/timeout/auth flags deliberately at deploy time.
- Use Cloud Run for autoscaling services, not stateful long-lived workers that need local state.
- Keep config in env vars and image builds reproducible.
- Separate image build, deployment, IAM exposure, and traffic rollout steps.

### nestjs-best-practices
- Organize by modules/providers/controllers and export providers intentionally.
- Validate DTOs with ValidationPipe plus whitelist/forbid settings.
- Use guards, pipes, interceptors, and filters according to the Nest request lifecycle.
- Throw HttpExceptions, not generic errors, for request failures.
- Handle circular dependencies with `forwardRef()` only when refactoring is not feasible.
- Isolate unit tests with provider overrides and keep E2E tests state-clean.

### nestjs-expert
- First confirm the issue is truly NestJS; hand off pure TS/DB/frontend problems to the right specialist.
- Detect module structure, auth stack, DB stack, and test setup before changing code.
- Validate fixes in order: typecheck, unit, integration, then E2E.
- Prefer fixing module boundaries and exports before resorting to `forwardRef()`.
- Respect existing provider/module/test conventions already present in the codebase.
- Use one-shot diagnostics; avoid long-running watch/serve processes.

### nextauth-authentication
- Use Auth.js v5 patterns with the universal `auth()` API.
- Validate sensitive sessions server-side, not just in the client.
- Use `AUTH_` environment variable names and never hardcode secrets.
- Decide session strategy explicitly: JWT vs database.
- Put auth callbacks and authorization logic in the root auth config.
- Treat middleware and protected route checks as first-class auth behavior.

### react-patterns
- Prefer small components with one responsibility and composition over inheritance.
- Keep hooks at top level and extract them only when logic truly repeats.
- Place state at the narrowest scope that fits the sharing needs.
- Distinguish presentational vs container/server/client roles clearly.
- Avoid premature optimization; profile before optimizing renders.
- Favor pure components and straightforward event/data flow.

### react-state-management
- Classify state first: local, global, server, URL, or form state.
- Use simple local state first; only escalate to Zustand/Redux/Jotai when sharing/complexity requires it.
- Prefer React Query/SWR/RTK Query for server state and caching concerns.
- Keep selectors and typed hooks centralized.
- Normalize complex global state instead of nesting it deeply.
- Match the tool to the problem size, not to hype.

### react-testing
- Prefer Vitest Browser Mode with `vitest-browser-react` over legacy DOM-only setups.
- `render()` is async; await it and use `expect.element()` for retry-aware assertions.
- Test visible behavior, callbacks, and conditional rendering from the user perspective.
- Use real browser events instead of overusing manual `act()` wrappers.
- Keep components visible for debugging and rely on auto-cleanup semantics.
- Mock network boundaries cleanly and assert user-observable outcomes.

### redux-toolkit
- Keep Redux state normalized and organized by feature.
- Use `createSlice`, selectors, and typed hooks consistently.
- Prefer RTK Query for data fetching/caching instead of ad hoc async plumbing.
- Encapsulate access through selectors rather than reading state shape everywhere.
- Keep naming conventions consistent: PascalCase types, camelCase logic, kebab-case files.
- Optimize only when needed; avoid pushing derived calculations into components.

### refactoring-surgeon
- Never refactor without a safety net; ensure tests or characterization coverage first.
- Make one small refactoring at a time and keep behavior unchanged.
- Do not mix refactoring with feature work or incident hotfixes.
- Name the code smell you are addressing before changing structure.
- Avoid premature abstraction; wait for repeated concrete cases.
- Measure whether complexity/readability/testability actually improved.

### shadcn
- Prefer existing shadcn components and registry results before custom markup.
- Use semantic tokens and built-in variants; do not override core styling casually.
- Use `gap-*`, `size-*`, `cn()`, and proper component composition patterns.
- Forms should use the field/input group primitives, not ad hoc layout divs.
- Dialog/Sheet/Drawer always need titles for accessibility.
- Run shadcn CLI through the project package runner, not arbitrary commands.

### software-architecture-design
- Focus on system-level decisions, not low-level implementation details.
- Compare 2–3 viable architectural options with tradeoffs when the problem is broad.
- Include concrete technology picks, non-goals, ownership boundaries, and success metrics.
- Map architecture decisions to team structure and operational reality.
- Document what NOT to build yet to avoid premature scope.
- Treat ADRs and measurable outcomes as part of the architecture, not afterthoughts.

### tailwind-patterns
- Use mobile-first responsive utilities and semantic design tokens.
- Stick to a consistent spacing scale and container pattern.
- Prefer reusable card/grid/layout primitives over one-off class soup.
- Use dark mode and responsive breakpoints intentionally, not reactively.
- Keep utility composition readable and centered on layout semantics.
- Favor standard Tailwind patterns for common UI structures.

### typescript-advanced-types
- Use advanced types only to improve safety and API clarity, not to show off.
- Apply generics with constraints when reuse needs compile-time guarantees.
- Use conditional and mapped types to transform shapes systematically.
- Prefer inference when it stays readable; spell types out when intent is otherwise opaque.
- Keep utility types composable and focused.
- Avoid type-level cleverness that future maintainers cannot debug.

### typescript-e2e-testing
- Always identify whether the task is setup, writing, running, debugging, review, or optimization first.
- Load the relevant workflow before acting; do not improvise E2E structure ad hoc.
- Use real infrastructure via Docker when the workflow requires realistic integration coverage.
- Write tests in Given/When/Then style with isolation and cleanup discipline.
- Replace fixed waits with polling/synchronization primitives where possible.
- Diagnose flaky tests through isolation, timing, infra health, and message/database state.

### ui-design-patterns
- Use established UI patterns for navigation, forms, data display, and feedback.
- Match pattern choice to the actual UX problem, not just visual preference.
- Build with accessibility semantics and keyboard interaction from the start.
- Keep component vocabulary consistent across the interface.
- Prefer reusable pattern implementations over bespoke one-offs.
- Consider responsive adaptations as part of the pattern, not a later patch.

### ui-design-system
- Build on the Tailwind + Radix + shadcn layering model.
- Review UI through architecture, accessibility, responsiveness, consistency, and performance.
- Prefer component composition and token usage over ad hoc styling.
- Use progressive enhancement: styling first, then accessible behavior, then higher-level components.
- Treat design tokens, state patterns, and accessibility as system concerns.
- Improve developer experience with reusable, documented, type-safe components.

### vercel-react-best-practices
- Prioritize eliminating async waterfalls before micro-optimizing renders.
- Reduce bundle size with direct imports, dynamic loading, and deferred third-party code.
- Cache and serialize server/client data deliberately to avoid duplicate work.
- Derive state during render when possible instead of creating effect-driven duplication.
- Use transitions and memoization strategically, not reflexively.
- Optimize based on the highest-impact category first: waterfalls, bundle size, server performance.

### web-performance-optimization
- Measure first: establish Lighthouse/Core Web Vitals/bundle baselines before tuning.
- Prioritize high-impact wins such as critical rendering path, image optimization, and code splitting.
- Analyze runtime, network, and asset bottlenecks before proposing fixes.
- Re-measure after changes to confirm impact.
- Treat caching, lazy loading, and third-party script control as first-class levers.
- Optimize for user-perceived performance, not vanity metrics.

### webapp-testing
- Use Playwright scripts and prefer bundled helper scripts as black boxes.
- Run helper scripts with `--help` before reading or customizing them.
- For dynamic apps, wait for `networkidle` before inspecting or acting.
- Follow reconnaissance-then-action: inspect rendered DOM, then choose selectors.
- Keep browser automation headless and close resources cleanly.
- Do not inspect huge helper script sources unless direct usage truly fails.

## Project Conventions

| File | Path | Notes |
|------|------|-------|
| AGENTS.md | /home/david/dotfiles/AGENTS.md | Index — primary project conventions |
| install.sh | /home/david/dotfiles/install.sh | Linux/macOS installer; mutates real machine; do not run casually |
| install.ps1 | /home/david/dotfiles/install.ps1 | Windows installer; mutates real machine; do not run casually |
| bashrc | /home/david/dotfiles/bash/bashrc | Preserve machine-specific exports unless explicitly asked to sanitize |
| fish config | /home/david/dotfiles/fish/config.fish | Fish is primary shell; repo path assumptions live here |
| HyprPanel wrapper | /home/david/dotfiles/hyprpanel/hyprpanel-wrapper | Reads `~/dotfiles` and recopies HyprPanel config on launch |
| Hyprland config | /home/david/dotfiles/hyprland/hyprland.conf | Linux autostarts HyprPanel; Waybar is fallback/legacy |
| HyprPanel config | /home/david/dotfiles/hyprpanel/config/config.json | Edit repo copy, not only installed config |
| Neovim entrypoint | /home/david/dotfiles/nvim/init.lua | Real Neovim entrypoint |
| Lazy bootstrap | /home/david/dotfiles/nvim/lua/config/lazy.lua | Source of plugin bootstrapping truth |
| Plugin configs | /home/david/dotfiles/nvim/lua/plugins/*.lua | Real Neovim behavior lives here; docs may drift |
| StyLua config | /home/david/dotfiles/nvim/stylua.toml | Format touched Lua with 2 spaces, width 120 |
| Neovim keymaps | /home/david/dotfiles/nvim/lua/config/keymaps.lua | OpenCode path and actual key prefixes live here |
| README | /home/david/dotfiles/README.md | Useful overview but can drift from executable config |
| Neovim README | /home/david/dotfiles/nvim/README.md | Reference only; trust code when docs conflict |

Read the convention files listed above for project-specific patterns and rules. All referenced paths have been extracted — no need to read index files to discover more.
