# DBA Database Skills

Five reusable skills for DBAs and database engineers working with SQL Server 2022 and 2025, PostgreSQL 18, MySQL 9.7 LTS, and MariaDB 13.0. They provide version aware guidance in Spanish for relational modeling and normalization through third normal form (3NF), T-SQL/SQL, security, performance, backup and recovery, high availability, and migrations.

This project is intended for review and collaboration. Please open an issue with the database engine, exact version/build, relevant source documentation, a reproducible example, and the behavior you expected. For proposed changes, use pull requests and explain how you validated them. Do not include production data, credentials, hostnames, or confidential schemas.

## Skills in this repository

| Skill folder | Engine and scope |
|---|---|
| `sqlserver-2022-engineering/` | Microsoft SQL Server 2022 (16.x); check edition, CU, compatibility level, and feature availability. |
| `sqlserver-2025-engineering/` | Microsoft SQL Server 2025 (17.x); distinguish edition, build, GA features, and preview features. |
| `postgresql-18-engineering/` | PostgreSQL 18; includes guidance for the 18.6 patch level. |
| `mysql-9-7-engineering/` | MySQL 9.7 LTS; distinguish Community, Enterprise, managed services, and storage engines. |
| `mariadb-13-engineering/` | MariaDB 13.0; 13.0.2 was the stable release reviewed for this package. The 13.0 series is rolling, not LTS. |

For a single installable plugin, use `dba-database-skills/`. It bundles all five skill folders and a plugin manifest. The top level folders are also available individually for installations that support standalone Agent Skills.

## Compatibility

Each skill follows the Agent Skills folder format: a `SKILL.md` entry file with YAML front matter and optional references, checklists, and templates. Codex can load skills directly from its skill directories. The plugin package is prepared for Codex and the OpenAI plugin submission workflow; using these instructions in another agent may require manual installation and may not support the bundled plugin metadata.

Instructions and templates are in Spanish. Engine identifiers, commands, SQL syntax, filenames, and API names remain in their original language. Users can request another response language. Keep the selected skill aligned with the actual server product and version: MySQL and MariaDB are separate engines; SQL Server 2022 and 2025 have different capabilities; PostgreSQL extensions and managed platforms can change what is available.

## Installation

### Standalone skill in Codex

1. Choose one folder from the table above.
2. Copy that folder, with its `SKILL.md` at the folder root, into your personal Codex skills directory (commonly `~/.codex/skills/`) or into the project skills location used by your Codex setup.
3. Start a new Codex session or refresh skill discovery. Invoke it by name, for example `$postgresql-18-engineering`.

Install each engine skill separately when you need several; do not place a folder inside another copy of itself.

### Plugin package

Use the complete `dba-database-skills` folder with its root `plugin.json` and `skills/` directory. For local use in Codex, add the plugin to a local plugin marketplace or use the plugin import workflow available in your Codex version. For the shared ChatGPT and Codex Plugins Directory, upload `dba-database-skills-plugin.zip` from the repository root through the OpenAI Plugins dashboard, review automated findings, and submit the draft for review. Approval and publication are OpenAI decisions; a successful upload does not mean the plugin is listed.

The plugin only contains instructions and reference files. It does not connect to a database, install a driver, provision an MCP server, or provide credentials.

## Normalization method

The skills require separating confirmed business rules from hypotheses. They identify all candidate keys and functional dependencies; assess 1NF, 2NF, and 3NF; consider redundancy and insert/update/delete anomalies; and evaluate lossless decomposition and dependency preservation separately. When the schema and sample data cannot establish a business dependency, the agent must state what needs confirmation instead of inventing it. Any denormalization requires a reason and validation plan.

## Limitations

- These skills are engineering guidance, not a substitute for current vendor documentation, release notes, an experienced DBA, or domain-owner confirmation.
- A version label alone is not enough. Check the actual build, edition, operating system, storage engine, extensions, compatibility settings, drivers, permissions, and managed-service restrictions.
- Example diagnostics are bounded read-only queries, but even read-only operations can consume resources or expose sensitive metadata. Review them before use and follow local access policies.
- Templates are starting points. Generated SQL has not been validated against your live schema, workload, operational constraints, or a production server. A skill does not authorize execution or guarantee correctness, availability, performance, or recovery.
- Backup, restore, replication, and failover guidance must be tested with the exact version, topology, tools, encryption keys, and recovery objectives in your environment.
- MariaDB 13.0 documentation reviewed for this release contains a discrepancy about two GA capabilities; see its `references/version-matrix.md`. The MariaDB backup reference also records the 13.0.2 `innodb_log_archive`/`mariadb-backup` limitation. Recheck current release notes before using those features.
- The materials reflect source review on 2026-09-29. Verify newer patches and documentation before operational use.

## License

Released under the MIT License. See [LICENSE](LICENSE). Third-party product names and linked technical documentation remain the property of their respective owners.
