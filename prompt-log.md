# Prompt log

## 2026-10-09

- **What I asked:** Set up the nicholas-bonilla portfolio repository skeleton: required files and directories with one-line placeholder READMEs, an AGENTS.md tailored from the course baseline and my resume, a one-line CLAUDE.md, this log's first entry, my resume as RESUME.md, and the specified .gitignore. Show every file before committing anything.
- **What you produced:** README.md (one-line placeholder, since none existed), RESUME.md, AGENTS.md, CLAUDE.md, prompt-log.md, .gitignore, and a one-line README.md in capabilities/, docs/briefs/, docs/decisions/, data/ and analysis/figures/.
- **What was wrong and how it was caught:** The first copies of README.md, CLAUDE.md, .gitignore and capabilities/README.md were written to an upload folder outside the repository, not the repository directory. This was caught by checking the paths in the tool results against the working directory, and the files were rewritten in the repository. The "Never paste into a model" list in AGENTS.md was inferred from my resume, so I still need to read it and correct it.
