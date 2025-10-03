# Repository Guidelines

## Project Structure & Module Organization
- `backend/CustomsDeclaration.API` holds the .NET 8 Web API solution with layered folders (`Controllers`, `Services`, `Data`, `Models`, `Middleware`, `Extensions`). Use `Scripts/` for database bootstrap SQL and keep runtime logs in `logs/`.
- `frontend/` hosts the Vue 3 + Vite client; primary source lives in `src/` (API adapters, layouts, views, Pinia stores, styles, utilities). Generated type stubs (`auto-imports.d.ts`, `components.d.ts`) are overwritten by Vite plugins.
- `SQL/` stores canonical SQL Server and Oracle scripts used to seed customs tables. Treat these as read-only reference files and mirror updates back into `backend/CustomsDeclaration.API/Scripts/` when tooling relies on them.

## Build, Test, and Development Commands
- Backend: `dotnet restore` then `dotnet run --project backend/CustomsDeclaration.API` starts the API; `dotnet watch run` is preferred during iterative work. Publish artifacts with `dotnet publish -c Release` when packaging deployments.
- Frontend: from `frontend/`, run `npm install` once, then `npm run dev` for local development, `npm run build` for production bundles, `npm run preview` to sanity-check the build, and `npm run lint` to apply ESLint + Prettier formatting.

## Coding Style & Naming Conventions
- Follow C# conventions: 4-space indentation, PascalCase for classes/methods, camelCase for locals, and suffix asynchronous methods with `Async`. Keep controllers thin and push business logic into `Services/`.
- Vue files use `<script setup>` with Composition API. Name Vue components in PascalCase, route files in kebab-case, Pinia stores as `useXxxStore`, and keep shared helpers in `utils/`. Run `npm run lint` before committing to normalize with ESLint (Vue plugin) and Prettier.

## Testing Guidelines
- Add backend unit tests under a sibling `backend/CustomsDeclaration.Tests` project and wire them into the solution so `dotnet test` covers service and middleware layers. Use test doubles for database factories and assert against the unified `ApiResponse` contract.
- Frontend currently relies on manual checks (see `frontend/src/utils/templateTest.js`). Introduce Vitest or Cypress suites under `frontend/tests/` as features stabilize, and mirror naming as `FeatureName.spec.js`. Record data fixtures in JSON and avoid hard-coded credentials.

## Commit & Pull Request Guidelines
- The repository snapshot ships without Git history; adopt Conventional Commits (`feat:`, `fix:`, `refactor:`) to keep changelogs intelligible. Scope tags such as `backend`, `frontend`, or `sql` help triage later.
- Each PR should include a concise summary, testing notes (commands run, data sources touched), any linked tracker IDs, and screenshots/GIFs for UI work. Verify that authentication toggles re-enabled in `Program.cs` before requesting review.

## Security & Configuration Tips
- Never commit real connection strings or JWT secrets. Use `appsettings.Development.json` and `.env.development` only for local values and document sensitive overrides in your PR.
- Restore `[Authorize]` attributes and middleware before merging. Scrub exported SQL from personal data and rotate default admin credentials after deployments.

## Encoding & Chinese Text Handling
- Keep repository files in UTF-8 without BOM; never save in GBK/GB2312.
- In PowerShell, run chcp 65001 before using Get-Content/Set-Content so the console handles UTF-8 Chinese correctly.
- Always pass -Encoding UTF8 (or use [IO.File]::ReadAllText/WriteAllText(..., [Text.Encoding]::UTF8)) when reading or writing files.
- Avoid inline console editing that defaults to ANSI; prefer editors configured for UTF-8 or scripts that explicitly set encoding.
- After edits, re-open the file with Get-Content -Encoding UTF8 to confirm Chinese text displays as expected.

- 若发现旧文件被误存为 ANSI/GBK 等本地编码，先执行 `chcp 65001 | Out-Null`，再用 `Get-Content -Encoding Default path | Set-Content -Encoding UTF8 path` 将文件转换为 UTF-8 后再编辑，避免出现 `U+FFFD` 替换字符。
- 批量脚本处理中文文本时，读取与写入都显式指定 `-Encoding UTF8` 或调用 `[IO.File]::ReadAllText(..., Encoding.UTF8)` / `[IO.File]::WriteAllText(..., Encoding.UTF8)`，不要依赖默认编码。




