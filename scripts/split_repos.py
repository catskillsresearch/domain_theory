#!/usr/bin/env python3
"""Split domain_theory into scott1972, scott1980, scott1982, scott_models sibling repos."""

from __future__ import annotations

import re
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DESKTOP = ROOT.parent

REPOS = {
    "scott1972": {
        "lib": "Scott1972",
        "src_subdir": "ContinuousLattice",
        "src_glob": "Domain/ContinuousLattice",
        "replacements": [("Domain.ContinuousLattice", "Scott1972.ContinuousLattice")],
        "root_imports_from_domain_lean": True,
        "filter_prefix": "Domain.ContinuousLattice.",
    },
    "scott1980": {
        "lib": "Scott1980",
        "src_subdir": "Neighborhood",
        "src_glob": "Domain/Neighborhood",
        "replacements": [("Domain.Neighborhood", "Scott1980.Neighborhood")],
        "root_imports_from_domain_lean": True,
        "filter_prefix": "Domain.Neighborhood.",
    },
    "scott1982": {
        "lib": "Scott1982",
        "files": ["Domain/Constructive.lean", "Domain/InfoSys.lean"],
        "replacements": [
            ("Domain.Constructive", "Scott1982.Constructive"),
            ("Domain.InfoSys", "Scott1982.InfoSys"),
        ],
        "root_imports": ["Scott1982.Constructive", "Scott1982.InfoSys"],
    },
}

LAKEFILE_TEMPLATE = """name = "{name}"
version = "0.1.0"
keywords = {keywords}
defaultTargets = ["{lib}"]

[leanOptions]
pp.unicode.fun = true
relaxedAutoImplicit = true

[[require]]
name = "mathlib"
scope = "leanprover-community"
rev = "v4.30.0"
{extra_requires}
[[lean_lib]]
name = "{lib}"
"""

README_1972 = """[![Lean 4](https://img.shields.io/github/actions/workflow/status/catskillsresearch/scott1972/build.yml?label=Lean%204)](https://github.com/catskillsresearch/scott1972/actions/workflows/build.yml)
# scott1972

Lean 4 formalization of Dana Scott's **1972** *Continuous Lattices* (LNM 274):
injective `T₀`-spaces, Scott topology, way-below, function spaces, inverse limits.

Standalone package — no dependency on the 1980/1982 formalizations. Part IV equivalence
theorems live in [`scott_models`](../scott_models).

## Build

```bash
lake exe cache get
lake build Scott1972
```

Pinned: Lean / mathlib **v4.30.0** (`lean-toolchain`).
"""

README_1980 = """[![Lean 4](https://img.shields.io/github/actions/workflow/status/catskillsresearch/scott1980/build.yml?label=Lean%204)](https://github.com/catskillsresearch/scott1980/actions/workflows/build.yml)
# scott1980

Lean 4 formalization of Dana Scott's **1981** PRG-19 *Lectures on a Mathematical
Theory of Computation* (neighborhood systems / filter domains).

Standalone package — no dependency on the 1972 formalization. Part IV equivalence
theorems live in [`scott_models`](../scott_models).

## Build

```bash
lake exe cache get
lake build Scott1980
```

Pinned: Lean / mathlib **v4.30.0** (`lean-toolchain`).
"""

README_1982 = """[![Lean 4](https://img.shields.io/github/actions/workflow/status/catskillsresearch/scott1982/build.yml?label=Lean%204)](https://github.com/catskillsresearch/scott1982/actions/workflows/build.yml)
# scott1982

Lean 4 formalization of Dana Scott's **1982** *Domains for Denotational Semantics*
(ICALP) — information systems (constructive presentation).

Includes a choice-free `Finset` prelude (`Scott1982.Constructive`) and `Scott1982.InfoSys`.

Standalone package. Part IV equivalence theorems live in [`scott_models`](../scott_models).

## Build

```bash
lake exe cache get
lake build Scott1982
```

Pinned: Lean / mathlib **v4.30.0** (`lean-toolchain`).
"""

README_MODELS = """[![Lean 4](https://img.shields.io/github/actions/workflow/status/catskillsresearch/scott_models/build.yml?label=Lean%204)](https://github.com/catskillsresearch/scott_models/actions/workflows/build.yml)
# scott_models

**Part IV** of the Scott domain theory monograph: equivalence theorems relating the
1972 continuous-lattice, 1980 neighborhood-system, and 1982 information-system
presentations.

Depends on sibling packages (Lake path deps by default):

- [`scott1972`](../scott1972) — Part I
- [`scott1980`](../scott1980) — Part II
- [`scott1982`](../scott1982) — Part III

Replace `path = "../…"` in `lakefile.toml` with git URLs when publishing.

## Build

```bash
lake exe cache get
lake build ScottModels
```

Narrative inventory: `arxiv.md`. Session resume: `HANDOFF.md`.
"""

CI_YML = """name: Continuous Integration

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  build:
    name: Build Lean Project
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install elan
        run: |
          curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
          echo "$HOME/.elan/bin" >> $GITHUB_PATH

      - name: Configure Lake cache
        run: lake exe cache get || true

      - name: Build project
        run: lake build
"""

MODELS_CI_YML = """name: Continuous Integration

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  build:
    name: Build Lean Project
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: scott_models
    steps:
      - name: Checkout scott_models
        uses: actions/checkout@v4
        with:
          path: scott_models

      - name: Checkout scott1972
        uses: actions/checkout@v4
        with:
          repository: catskillsresearch/scott1972
          path: scott1972

      - name: Checkout scott1980
        uses: actions/checkout@v4
        with:
          repository: catskillsresearch/scott1980
          path: scott1980

      - name: Checkout scott1982
        uses: actions/checkout@v4
        with:
          repository: catskillsresearch/scott1982
          path: scott1982

      - name: Install elan
        run: |
          curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
          echo "$HOME/.elan/bin" >> $GITHUB_PATH

      - name: Configure Lake cache
        run: lake exe cache get || true

      - name: Build project
        run: lake build
"""

MODELS_LAKE_EXTRA = """
[[require]]
name = "scott1972"
path = "../scott1972"

[[require]]
name = "scott1980"
path = "../scott1980"

[[require]]
name = "scott1982"
path = "../scott1982"
"""


def read_domain_imports() -> list[str]:
    lines = (ROOT / "Domain.lean").read_text().splitlines()
    return [ln.strip().removeprefix("import ") for ln in lines if ln.startswith("import ")]


def rewrite_content(text: str, replacements: list[tuple[str, str]]) -> str:
    for old, new in replacements:
        text = text.replace(old, new)
    return text


def copy_lean_tree(
    repo_dir: Path,
    lib: str,
    src: Path,
    dest_name: str,
    replacements: list[tuple[str, str]],
) -> None:
    dest_root = repo_dir / lib / dest_name
    if src.is_file():
        dest_root.parent.mkdir(parents=True, exist_ok=True)
        dest = repo_dir / lib / Path(src.name)
        dest.write_text(rewrite_content(src.read_text(), replacements))
        return
    shutil.copytree(src, dest_root, dirs_exist_ok=True)
    for f in dest_root.rglob("*.lean"):
        f.write_text(rewrite_content(f.read_text(), replacements))


def write_root_lean(repo_dir: Path, lib: str, imports: list[str]) -> None:
    body = "\n".join(f"import {imp}" for imp in imports)
    (repo_dir / f"{lib}.lean").write_text(body + "\n")


def scaffold_common(repo_dir: Path, name: str, lib: str, readme: str, keywords: str) -> None:
    repo_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy(ROOT / "lean-toolchain", repo_dir / "lean-toolchain")
    shutil.copy(ROOT / ".gitignore", repo_dir / ".gitignore")
    if (ROOT / "LICENSE").exists():
        shutil.copy(ROOT / "LICENSE", repo_dir / "LICENSE")
    (repo_dir / "README.md").write_text(readme)
    (repo_dir / "lakefile.toml").write_text(
        LAKEFILE_TEMPLATE.format(
            name=name,
            lib=lib,
            keywords=keywords,
            extra_requires="",
        )
    )
    ci = repo_dir / ".github" / "workflows"
    ci.mkdir(parents=True, exist_ok=True)
    (ci / "build.yml").write_text(CI_YML)


def build_repo_1972_1980(name: str, cfg: dict) -> None:
    repo_dir = DESKTOP / name
    lib = cfg["lib"]
    readme = README_1972 if name == "scott1972" else README_1980
    keywords = '["domain-theory", "scott-1972", "continuous-lattices", "lean4"]' if name == "scott1972" else '["domain-theory", "scott-1980", "neighborhood-systems", "lean4"]'
    scaffold_common(repo_dir, name, lib, readme, keywords)

    src = ROOT / cfg["src_glob"]
    copy_lean_tree(repo_dir, lib, src, cfg["src_subdir"], cfg["replacements"])

    prefix = cfg["filter_prefix"]
    module_prefix = lib + "."
    imports = [
        imp.replace("Domain.", module_prefix)
        for imp in read_domain_imports()
        if imp.startswith(prefix)
    ]
    write_root_lean(repo_dir, lib, imports)

    sources = repo_dir / "sources"
    sources.mkdir(exist_ok=True)
    if name == "scott1972":
        shutil.copy(
            ROOT / "sources/ScottContinLatt1972_vision.md",
            sources / "ScottContinLatt1972_vision.md",
        )
    else:
        shutil.copy(ROOT / "sources/PRG19_vision.md", sources / "PRG19_vision.md")
        for extra in ("Exercise722-Composer-Run.md", "Exercise722-Composer-Playbook.md"):
            p = ROOT / extra
            if p.exists():
                dst = repo_dir / extra
                text = p.read_text().replace("Domain.Neighborhood", "Scott1980.Neighborhood")
                dst.write_text(text)
        if (ROOT / "HANDOFF.md").exists():
            shutil.copy(ROOT / "HANDOFF.md", repo_dir / "HANDOFF.md")
        rules = ROOT / ".cursor/rules/handoff-discipline.mdc"
        if rules.exists():
            (repo_dir / ".cursor/rules").mkdir(parents=True, exist_ok=True)
            shutil.copy(rules, repo_dir / ".cursor/rules/handoff-discipline.mdc")
        if (ROOT / ".cursorignore").exists():
            shutil.copy(ROOT / ".cursorignore", repo_dir / ".cursorignore")


def build_repo_1982() -> None:
    name = "scott1982"
    cfg = REPOS[name]
    repo_dir = DESKTOP / name
    lib = cfg["lib"]
    scaffold_common(repo_dir, name, lib, README_1982, '["domain-theory", "scott-1982", "information-systems", "lean4"]')

    for rel in cfg["files"]:
        src = ROOT / rel
        copy_lean_tree(repo_dir, lib, src, Path(rel).name, cfg["replacements"])

    write_root_lean(repo_dir, lib, cfg["root_imports"])
    sources = repo_dir / "sources"
    sources.mkdir(exist_ok=True)
    shutil.copy(
        ROOT / "sources/Domains_for_Denotational_Semantics.md",
        sources / "Domains_for_Denotational_Semantics.md",
    )


def build_repo_models() -> None:
    name = "scott_models"
    lib = "ScottModels"
    repo_dir = DESKTOP / name
    repo_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy(ROOT / "lean-toolchain", repo_dir / "lean-toolchain")
    shutil.copy(ROOT / ".gitignore", repo_dir / ".gitignore")
    if (ROOT / "LICENSE").exists():
        shutil.copy(ROOT / "LICENSE", repo_dir / "LICENSE")
    (repo_dir / "README.md").write_text(README_MODELS)
    (repo_dir / "lakefile.toml").write_text(
        LAKEFILE_TEMPLATE.format(
            name=name,
            lib=lib,
            keywords='["domain-theory", "scott", "equivalence", "lean4"]',
            extra_requires=MODELS_LAKE_EXTRA,
        )
    )
    ci = repo_dir / ".github" / "workflows"
    ci.mkdir(parents=True, exist_ok=True)
    (ci / "build.yml").write_text(MODELS_CI_YML)

    equiv = repo_dir / lib / "Equivalence.lean"
    equiv.parent.mkdir(parents=True, exist_ok=True)
    equiv.write_text(
        """import Scott1972.ContinuousLattice.Specialization
import Scott1980.Neighborhood.Exercise122
import Scott1982.InfoSys

/-!
# Equivalence theorems (Part IV)

Bridges between Scott's 1972 continuous-lattice topology, 1980 neighbourhood-system
topology (Exercise 1.22), and 1982 information systems.

Planned results (not yet formalized):

* neighbourhood topology on `|𝒟|` from a continuous lattice ↔ Scott topology;
* approximable maps ↔ Scott-continuous maps;
* information-system ideals ↔ domain elements of the other presentations.
-/
"""
    )

    write_root_lean(
        repo_dir,
        lib,
        [
            "Scott1972.ContinuousLattice.Specialization",
            "Scott1980.Neighborhood.Basic",
            "Scott1982.InfoSys",
            "ScottModels.Equivalence",
        ],
    )

    for fname in ("arxiv.md", "HANDOFF.md", "system_prompt.md", ".cursorignore"):
        p = ROOT / fname
        if p.exists():
            shutil.copy(p, repo_dir / fname)
    rules = ROOT / ".cursor/rules/handoff-discipline.mdc"
    if rules.exists():
        (repo_dir / ".cursor/rules").mkdir(parents=True, exist_ok=True)
        shutil.copy(rules, repo_dir / ".cursor/rules/handoff-discipline.mdc")
    scripts_src = ROOT / "scripts"
    scripts_dst = repo_dir / "scripts"
    if scripts_src.is_dir():
        shutil.copytree(scripts_src, scripts_dst, dirs_exist_ok=True)
        # Remove split script from models copy
        (scripts_dst / "split_repos.py").unlink(missing_ok=True)

    split_note = repo_dir / "SPLIT.md"
    split_note.write_text(
        """# Four-repo layout

This monograph is split into four Lake packages (siblings on the Desktop):

| Repo | Part | Root module |
| --- | --- | --- |
| `scott1972` | Scott 1972 continuous lattices | `Scott1972` |
| `scott1980` | Scott 1981 PRG-19 neighbourhood systems | `Scott1980` |
| `scott1982` | Scott 1982 information systems | `Scott1982` |
| `scott_models` | Equivalence theorems (this repo) | `ScottModels` |

The original monolith remains at `domain_theory/` for reference until retired.

Generated by `domain_theory/scripts/split_repos.py`.
"""
    )


def git_init(repo_dir: Path) -> None:
    if (repo_dir / ".git").exists():
        return
    subprocess.run(["git", "init", "-b", "main"], cwd=repo_dir, check=True)
    subprocess.run(["git", "add", "-A"], cwd=repo_dir, check=True)
    subprocess.run(
        [
            "git",
            "commit",
            "-m",
            "Initial import from domain_theory monolith split.",
        ],
        cwd=repo_dir,
        check=True,
    )


def lake_update_and_build(repo_dir: Path, target: str) -> None:
    print(f"==> lake update in {repo_dir.name}")
    subprocess.run(["lake", "update"], cwd=repo_dir, check=True)
    print(f"==> lake build {target} in {repo_dir.name}")
    subprocess.run(
        ["lake", "build", target],
        cwd=repo_dir,
        check=True,
    )


def main() -> None:
    build_repo_1972_1980("scott1972", REPOS["scott1972"])
    build_repo_1972_1980("scott1980", REPOS["scott1980"])
    build_repo_1982()
    build_repo_models()

    # Note in original repo
    (ROOT / "SPLIT.md").write_text(
        (DESKTOP / "scott_models" / "SPLIT.md").read_text()
        + "\nRun `python3 scripts/split_repos.py` to regenerate sibling repos.\n"
    )

    for name, lib in (
        ("scott1972", "Scott1972"),
        ("scott1980", "Scott1980"),
        ("scott1982", "Scott1982"),
    ):
        git_init(DESKTOP / name)
        lake_update_and_build(DESKTOP / name, lib)

    git_init(DESKTOP / "scott_models")
    lake_update_and_build(DESKTOP / "scott_models", "ScottModels")
    print("Done. Repos at:", ", ".join(str(DESKTOP / n) for n in REPOS) + f", {DESKTOP / 'scott_models'}")


if __name__ == "__main__":
    main()
