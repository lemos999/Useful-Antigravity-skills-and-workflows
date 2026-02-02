# Anti-singularity Resource

A standardized resource protocol for AI development agents. This repository defines strict workflows, coding patterns, verification rules, and persona configurations to ensure consistent code quality, security, and architectural integrity across various technology stacks.

## ⚡ Core Principles

This protocol operates under a **Global Priority Mandate**. Resources are resolved in the following strict order:

1.  **Global**: `~/.gemini/antigravity/` (Primary)
2.  **Package**: `./antisingularity/`
3.  **Local**: `./.agent/` (Project-specific fallback)

All operations must adhere to **Security First**, **Immutability**, and **Test-Driven Development (TDD)** principles.

## 📂 Repository Structure

- **`/workflows`**: Operational command definitions (e.g., build, test, review).
- **`/skills`**: Language-specific best practices and architectural patterns.
- **`/configs`**: Configuration files for linters, package managers, and tools.
- **`GEMINI.md`**: Core persona ('Ray') and operational mandate definitions.

## 🛠 Supported Stacks & Capabilities

### 1. Golang
- **Workflows**: `/go-build`, `/go-test` (Table-driven tests), `/go-review`.
- **Patterns**: Concurrency safety, error wrapping, idiomatic structure.

### 2. Java (Spring Boot)
- **Workflows**: `springboot-verification`, `springboot-tdd`.
- **Patterns**: JPA optimization, Spring Security, Layered Architecture.

### 3. TypeScript / Next.js
- **Workflows**: `tdd-workflow`, `e2e` (Playwright), `refactor-clean`.
- **Patterns**: React composition, Zod input validation, performance optimization.

### 4. Infrastructure & Data
- **PostgreSQL**: Indexing strategies, Query optimization, RLS policies.
- **ClickHouse**: MergeTree engine patterns, bulk insertion strategies.
- **Browser Control**: Automated UI navigation and visual verification.

## 💻 Key Commands

Primary commands defined for agent interaction:

| Command | Description |
|:--- |:--- |
| `/verify` | Runs full validation: Build, Types, Lint, and Tests. |
| `/checkpoint` | Creates or verifies project state snapshots. |
| `/eval` | Defines and checks quantitative success criteria for features. |
| `/code-review` | comprehensive review focusing on security and quality. |
| `/go-review` | Go-specific static analysis and race condition checks. |
| `/plan` | Generates implementation roadmaps and risk analysis. |

## 🤖 Persona: Ray

This protocol enforces the 'Ray' persona:
- **Role**: Cynical, high-level developer (Codeforces Grandmaster tier).
- **Style**: "Zero Monolith" architecture, atomic modularity.
- **Tone**: Blunt, concise, and efficiency-driven.

## 🔒 Security Mandate

All generated code must pass the following checks before commitment:
- **No Hardcoded Secrets**: Strict enforcement of environment variables.
- **SQL Injection Prevention**: Mandatory use of parameterized queries.
- **Input Validation**: Required schema validation (Zod/Pydantic) for all inputs.

---
**License**: MIT


