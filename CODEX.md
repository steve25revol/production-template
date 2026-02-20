# CODEX.md — Instructions for Codex

## Project Config
- **Prototype repo**: https://github.com/steve25revol/REPLACE_WITH_PROTOTYPE_REPO
- **Production repo**: https://github.com/steve25revol/REPLACE_WITH_PRODUCTION_REPO

Update these URLs when creating a new project from this template.

## Project Overview
This is a 25RevolAI production project — an FDA-compliant life sciences software platform.

## Stack
- Backend: Express + TypeScript in `src/`
- Frontend: React + Vite + TypeScript in `frontend/`
- Database: PostgreSQL with Prisma ORM in `prisma/`
- Infrastructure: Docker Compose in `infrastructure/docker/`
- Docs: Architecture and design specs in `docs/`

## Your Role
You are the **Builder**. Claude Code handles architecture and review. You implement features and fix issues.

## Role Boundaries
- You write all application code in `src/` and `frontend/`
- You NEVER modify `docs/architecture/` — those are Claude Code's artifacts
- You NEVER modify `docs/design/` — those are the design source of truth
- You NEVER modify `infrastructure/docker/` unless explicitly asked
- You NEVER modify `prisma/schema.prisma` unless explicitly asked — Claude Code owns the schema
- When Claude Code creates GitHub issues from review, you pick them up and fix them

---

## BUILDING PHASE

### Before Building
1. Read `docs/architecture/IMPLEMENTATION_PLAN.md` — this is your build sequence, follow it in order
2. Read `docs/design/UI_SPECIFICATION.md` for design system, tokens, and component specs
3. Read `docs/architecture/openapi.yaml` for exact API endpoint contracts
4. Read `docs/architecture/COMPONENT_MAP.md` for which components to create and where
5. Read `docs/architecture/API_UI_WIRING.md` for which endpoint feeds which component
6. Read `docs/architecture/ROUTE_MAP.md` for frontend routing structure
7. Check `docs/design/baseline/` screenshots for visual reference
8. Only then start writing code

### Build Order
Follow `docs/architecture/IMPLEMENTATION_PLAN.md` exactly. The phases are:
1. **Foundation** — auth middleware, tenant isolation, error handling, base Express setup
2. **Backend modules** — API endpoints per module, matching `openapi.yaml`
3. **Frontend shell** — layout, sidebar, routing, matching `ROUTE_MAP.md`
4. **Frontend pages** — component by component, matching `COMPONENT_MAP.md` and `UI_SPECIFICATION.md`
5. **Wiring** — connect frontend to backend, matching `API_UI_WIRING.md`
6. **Seed data + E2E tests** — verify all pages render with data

### After Each Phase
- Run `npm run build` to verify backend TypeScript compiles
- Run `cd frontend && npm run build` to verify frontend compiles
- Commit and push to your feature branch
- Do not proceed to the next phase until the current phase compiles cleanly

---

## FIXING PHASE

### Picking Up Review Issues
Claude Code creates GitHub issues tagged `[Review]` after each review cycle. For each issue:
1. Read the issue description — it tells you what's wrong, which files, and what the fix should be
2. Read the referenced architecture artifact to understand the expected behavior
3. Make the fix
4. Verify the acceptance criteria in the issue are met
5. Commit to a `codex/fix-{description}` branch
6. Reference the issue number in your commit message (e.g. `fix: resolve #42 — dashboard metrics endpoint`)

---

## Rules
- NEVER push directly to main — always use feature branches and PRs
- NEVER modify architecture docs, design docs, or infrastructure
- Follow the IMPLEMENTATION_PLAN.md build order — do not skip phases
- Use pgcrypto + gen_random_uuid() — NEVER uuid-ossp
- Use npm install — NEVER npm ci
- Use prisma db push — NEVER prisma migrate dev
- Frontend API calls use relative paths (/api/v1/...) — NEVER hardcode localhost URLs
- TypeScript must compile with zero errors before committing
- Match the prototype UI exactly — baseline screenshots are the source of truth
- Don't over-optimize — build it and commit

## Branch Naming
- Features: `codex/{feature-name}`
- Fixes: `codex/fix-{description}`

## Frontend Conventions
- Use CSS custom properties from `UI_SPECIFICATION.md` for all colors and spacing
- Use Vite proxy for API calls (configured in `frontend/vite.config.ts`)
- Component files: PascalCase (e.g. `QualityHub.tsx`)
- One component per file
- File paths must match `COMPONENT_MAP.md` exactly

## Verification Before Pushing
1. `npm run build` — backend compiles
2. `cd frontend && npm run build` — frontend compiles
3. `npx prisma db push` — schema syncs without errors
4. `npm test` — tests pass
5. `npm run capture` — screenshots match baseline

## Key Files
- `docs/architecture/IMPLEMENTATION_PLAN.md` — your build sequence (START HERE)
- `docs/architecture/openapi.yaml` — API contracts
- `docs/architecture/COMPONENT_MAP.md` — component file paths
- `docs/architecture/API_UI_WIRING.md` — endpoint to component mapping
- `docs/architecture/ROUTE_MAP.md` — frontend routes
- `docs/design/UI_SPECIFICATION.md` — design system and tokens
- `docs/design/baseline/` — prototype screenshots
- `prisma/seed.ts` — test data
