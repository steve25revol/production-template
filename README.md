# Production Template — 25RevolAI

Template repo for FDA-compliant Life Sciences software platforms.

## Quick Start

1. Click "Use this template" on GitHub to create a new repo
2. Open in GitHub Codespaces
3. Run `bash scripts/init-project.sh` to configure for your project
4. Follow `PLAYBOOK.md` for the full build process

## Project Structure
```
├── .devcontainer/          # Codespace configuration
├── .github/workflows/      # CI pipeline
├── docs/
│   ├── architecture/       # SRS, ADRs, OpenAPI, component maps (Claude Code generates)
│   └── design/
│       └── baseline/       # Prototype screenshots (Playwright captures)
├── frontend/               # React + Vite + TypeScript (Codex builds)
├── infrastructure/docker/  # PostgreSQL, Redis, Keycloak, MinIO, NATS
├── prisma/                 # Database schema and seed data
├── scripts/                # Project initialization
├── src/                    # Express + TypeScript backend (Codex builds)
├── CLAUDE.md               # Instructions for Claude Code (Architect + Reviewer)
├── CODEX.md                # Instructions for Codex (Builder)
└── PLAYBOOK.md             # Step-by-step build process
```

## Agent Roles

| Agent | Role | What it does |
|-------|------|-------------|
| Google AI Studio | Prototyper | Builds the UI prototype |
| Claude Chat | Strategist | Framework decisions, brainstorming |
| Claude Code | Architect + Reviewer | Generates specs, reviews implementation |
| Codex | Builder | Implements features, fixes review issues |

## Infrastructure

| Service | Port | Purpose |
|---------|------|---------|
| API | 3000 | Express backend |
| Frontend | 5173 | React + Vite |
| PostgreSQL | 5432 | Primary database |
| Redis | 6379 | Cache + sessions |
| Keycloak | 8080 | Identity + SSO |
| MinIO | 9000/9001 | File storage |
| NATS | 4222 | Event bus |
| Apache AGE | — | Property graph (runs inside PostgreSQL) | Optional |
| Jena Fuseki | 3030 | RDF/SPARQL triple store for ontologies | Optional |

## Part of the 25RevolAI Framework

Prototype → Capture → Architecture → Build → Review → Deploy
