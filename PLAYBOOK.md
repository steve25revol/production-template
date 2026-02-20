# Project Playbook — 25RevolAI Framework

## Quick Start
1. Create prototype repo from `prototype-template` → `ClientName_Prototype`
2. Create production repo from `production-template` → `ClientName_OS`
3. Run `bash scripts/init-project.sh` in the production repo
4. Follow the phases below

---

## Phase 0: Prototype
- Build prototype in Google AI Studio
- Push to prototype repo (NEVER to production repo)
- Run Playwright capture in production repo codespace:
  - Clone prototype into /tmp/, run it, capture screenshots
  - Save to `docs/design/baseline/`, commit and push

## Phase 1: Discovery
- Stakeholder interviews
- Regulatory review (FDA 21 CFR Part 11, ISO 13485)
- Confirm scope

## Phase 2A: Architecture
- Tell Claude Code: "Start architecting" — it reads CLAUDE.md and follows instructions
- Claude Code generates all 10 artifacts
- Review the PR, merge to main

## Phase 2B: Pricing
- Use architecture artifacts to generate pricing
- Complexity analysis, timeline, risk assessment, ROI

## Phase 2C: Client Decision
- Present proposal
- If approved, proceed to build

## Phase 3: Implementation
- Codex reads CODEX.md and follows IMPLEMENTATION_PLAN.md
- Builds in phases: Foundation → Backend → Frontend shell → Pages → Wiring → Tests
- Commits per phase, compiles before moving on

## Phase 4: Review
- Tell Claude Code: "Start reviewing" — it reads CLAUDE.md and follows review checklist
- Generates REVIEW_REPORT.md
- Creates GitHub issues for any failures
- Codex picks up issues and fixes them

## Phase 5: CI/CD
- GitHub Actions runs on every PR
- Tests, builds, visual regression against baseline

## Phase 6: Deploy
- SoftIron HyperCloud: dev → staging → production

---

## Lessons Learned
- NEVER let Google AI Studio push to production repo
- Use postgres:16 not alpine, pgcrypto not uuid-ossp
- Use npm install not npm ci, prisma db push not migrate dev
- Include ALL env vars in .env.example
- Use Vite proxy for API calls, never hardcode localhost
- Give AI agents specific prompts — end with "don't over-optimize, write it and commit"
