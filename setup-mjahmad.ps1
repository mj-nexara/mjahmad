# setup-mjahmad.ps1
# Nexara Meta-Repository Initializer for mjahmad

Write-Host "📁 Creating folder structure..."

# Create folders
$folders = @(
    "docs",
    "docs\vision",
    "docs\architecture",
    "docs\strategy",
    "docs\documentation",
    "docs\links",
    "docs\assets",
    ".github\workflows"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

Write-Host "📝 Creating initial markdown files..."

# Create initial markdown files
@"
# Welcome to MJ Ahmad's Ethical Repository

This is the central hub for Nexara's vision, structure, and strategy.
"@ | Out-File -Encoding UTF8 docs\index.md

@"
# MJ's Ethical Principles

A personal commitment to dignity, transparency, and incorruptible coordination.
"@ | Out-File -Encoding UTF8 docs\vision\mj-principles.md

@"
# Nexara Ecosystem Map

This document outlines the relationship between all Nexara repositories and projects.
"@ | Out-File -Encoding UTF8 docs\architecture\ecosystem-map.md

@"
# 12-Month Roadmap

This roadmap outlines the strategic phases of Nexara's deployment and impact.
"@ | Out-File -Encoding UTF8 docs\strategy\roadmap.md

@"
# Official Links

- [Nexara Protocol](https://github.com/mj-nexara/nexara-protocol)
- [Guardian Circle](https://github.com/mj-nexara/guardian-circle)
"@ | Out-File -Encoding UTF8 docs\links\official.md

Write-Host "⚙️ Creating mkdocs.yml..."

# Create mkdocs.yml
@"
site_name: MJ Ahmad — Nexara Meta Repository
site_url: https://mj-nexara.github.io/mjahmad/
repo_url: https://github.com/mj-nexara/mjahmad
theme:
  name: material
  palette:
    primary: teal
    accent: lime
nav:
  - Home: index.md
  - Vision:
      - Principles: vision/mj-principles.md
  - Architecture:
      - Ecosystem Map: architecture/ecosystem-map.md
  - Strategy:
      - Roadmap: strategy/roadmap.md
  - Links:
      - Official: links/official.md
"@ | Out-File -Encoding UTF8 mkdocs.yml

Write-Host "📦 Creating requirements.txt..."

# Create requirements.txt
"mkdocs`nmkdocs-material" | Out-File -Encoding UTF8 requirements.txt

Write-Host "🚀 Creating GitHub Actions workflow..."

# Create GitHub Actions workflow
@"
name: Deploy MkDocs to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.x'
      - run: pip install -r requirements.txt
      - run: mkdocs build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: `${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./site
"@ | Out-File -Encoding UTF8 .github\workflows\deploy.yml

Write-Host "✅ Setup complete. You can now run:"
Write-Host "`n  pip install -r requirements.txt"
Write-Host "  mkdocs serve"
Write-Host "`nThen visit http://127.0.0.1:8000 to preview your site."
