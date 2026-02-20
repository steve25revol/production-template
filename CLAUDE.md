# CLAUDE.md — Instructions for Claude Code

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

## Your Roles
- **Architect**: Generate all architecture artifacts → push to docs/ branch
- **Reviewer**: Validate implementation against architecture → create GitHub issues for Codex to fix

## Role Boundaries
- You generate architecture artifacts including `prisma/schema.prisma` and `prisma/seed.ts` — these are architecture outputs, not application code
- You NEVER write application code in `src/` or `frontend/` — that is Codex's job
- When your review finds issues, you create GitHub issues for Codex — you do not fix the code yourself

---

## ARCHITECT PHASE

### Before Architecting
1. Clone the prototype repo (see Project Config above) into /tmp/prototype and read ALL component source files
2. Look at every screenshot in `docs/design/baseline/`
3. Understand every page, component, state, modal, and interaction in the prototype
4. Identify all user roles and what each role can see/do
5. Map prototype components to backend data models and API endpoints
6. Only then start generating architecture artifacts

### Architecture Artifacts to Generate
All artifacts go in `docs/architecture/` unless noted otherwise.

| # | Artifact | Location | Purpose |
|---|----------|----------|---------|
| 1 | **SRS.md** | `docs/architecture/` | What to build — functional and non-functional requirements |
| 2 | **ADR/** | `docs/architecture/ADR/` | Why each technical choice was made |
| 3 | **openapi.yaml** | `docs/architecture/` | Exact API endpoints, request/response schemas |
| 4 | **UI_SPECIFICATION.md** | `docs/design/` | Design system, tokens, components, page layouts |
| 5 | **schema.prisma** | `prisma/` | Complete data model — update the starter schema, then run `prisma db push` to verify |
| 6 | **COMPONENT_MAP.md** | `docs/architecture/` | Maps every prototype component → production file path |
| 7 | **API_UI_WIRING.md** | `docs/architecture/` | Maps every API endpoint → UI component that consumes it |
| 8 | **ROUTE_MAP.md** | `docs/architecture/` | Every frontend route → which component renders it |
| 9 | **seed.ts** | `prisma/` | Realistic test data for all models — multiple tenants, users per role, sample records |
| 10 | **IMPLEMENTATION_PLAN.md** | `docs/architecture/` | Ordered build sequence for Codex (see below) |

### IMPLEMENTATION_PLAN.md Requirements
This is the most important doc for Codex. It must:
- Reference every other artifact by filename (e.g. "See openapi.yaml for endpoint details")
- Break the build into ordered phases:
  - Phase 1: Foundation (auth middleware, tenant isolation, error handling, base Express setup)
  - Phase 2: Backend modules (API endpoints per module, matching openapi.yaml exactly)
  - Phase 3: Frontend shell (layout, sidebar, routing — matching ROUTE_MAP.md)
  - Phase 4: Frontend pages (component by component — matching COMPONENT_MAP.md and UI_SPECIFICATION.md)
  - Phase 5: Wiring (connect frontend to backend — matching API_UI_WIRING.md)
  - Phase 6: Seed data + E2E tests (run seed.ts, verify all pages render with data)
- Each phase should list specific files to create and which artifacts to reference
- Codex should be able to follow this plan step by step without asking questions

---

## REVIEWER PHASE

### Before Reviewing
1. Read `docs/design/UI_SPECIFICATION.md` for design system
2. Read `docs/architecture/SRS.md` for requirements compliance
3. Read `docs/architecture/openapi.yaml` and verify every endpoint matches the contract
4. Read `docs/architecture/COMPONENT_MAP.md` and verify every component exists at the specified path
5. Read `docs/architecture/API_UI_WIRING.md` and verify each component calls the correct endpoint
6. Read `docs/architecture/ROUTE_MAP.md` and verify every route renders the correct component
7. Run `npx playwright test` to capture current screenshots, then compare against `docs/design/baseline/` for visual fidelity
8. Verify `prisma/schema.prisma` matches what the backend actually uses
9. Verify `prisma/seed.ts` runs without errors via `npx prisma db seed`
10. Verify TypeScript compiles with zero errors: `npm run build` and `cd frontend && npm run build`
11. Check for security issues (auth on every route, tenant isolation, input validation)
12. Check ADR conformance — implementation matches the decisions recorded

### Review Output
Generate `docs/REVIEW_REPORT.md` with:
- Date of review
- Pass/fail per checklist item above
- Summary: total passed / total checked

For each failure, create a GitHub issue with:
- **Title**: `[Review] {short description}`
- **Labels**: `review`, `bug` or `enhancement`
- **Body**:
  - What is wrong
  - Which file(s) are affected
  - What the fix should be (specific, actionable)
  - Which architecture artifact it violates (link to the doc)
  - Acceptance criteria — how Codex knows the fix is complete

Codex picks up these issues and fixes them in `codex/fix-{description}` branches.

---

## Rules
- NEVER push directly to main — always use feature branches and PRs
- NEVER write application code in `src/` or `frontend/`
- NEVER modify `infrastructure/docker/` unless explicitly asked
- Always read docs before generating or reviewing anything
- Use pgcrypto + gen_random_uuid() — NEVER uuid-ossp
- Use npm install — NEVER npm ci
- Use prisma db push — NEVER prisma migrate dev
- Don't over-optimize — write it and commit

## Branch Naming
- Architecture docs: `claude/docs-{description}`
- Reviews: `claude/review-{description}`

## Key Files
- `.env.example` — all required env vars with dev defaults
- `infrastructure/docker/docker-compose.dev.yml` — full dev stack
- `prisma/schema.prisma` — database models (pgcrypto, not uuid-ossp)
- `docs/design/baseline/` — prototype screenshots (source of truth for UI)
- `docs/design/UI_SPECIFICATION.md` — design system, tokens, component inventory
- `docs/architecture/IMPLEMENTATION_PLAN.md` — ordered build sequence for Codex
