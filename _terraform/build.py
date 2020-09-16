#!/usr/bin/env python3
from pathlib import Path
import hashlib
import typing as t
import subprocess

import toml
import jinja2

TEMPLATES_DIR = Path("templates/")
VARIABLES_DIR = Path("variables/")
WORKSPACE_DIR = Path("workspace/")


def main() -> None:
    namespace = build_variables_namespace()
    jinja2_env = jinja2.Environment(loader=jinja2.FileSystemLoader(TEMPLATES_DIR))
    jinja2_env.filters["normalize_domain"] = normalize_domain
    jinja2_env.filters["no_dot"] = no_dot
    jinja2_env.filters["hash"] = hash_

    subprocess.run(["/bin/sh", "-c", "rm -f workspace/*.tf"])

    for name, template in template_files(jinja2_env):
        with WORKSPACE_DIR.joinpath(name).open("w+") as fp:
            print(f"rendering {name}...")
            fp.write(template.render(**namespace))


def build_variables_namespace() -> dict:
    namespace = {}
    files = [p for p in VARIABLES_DIR.iterdir() if is_toml_file(p)]
    for file_ in files:
        namespace[file_.name.rpartition(".")[0]] = toml.load(file_)
    return namespace


def is_toml_file(p: Path) -> bool:
    return p.is_file() and p.name.endswith(".toml")


def template_files(
    env: jinja2.Environment,
) -> t.Generator[t.Tuple[str, jinja2.Template], None, None]:
    for path in TEMPLATES_DIR.iterdir():
        if path.is_file():
            yield path.name, env.get_template(path.name)


def normalize_domain(s: t.Union[str, int]) -> str:
    """Jinja filter to 'normalize' domains for terraform IDs."""
    return str(s).replace(".", "_").replace("@", "domain_root_").lower()


def hash_(items: t.Any, namespace: str = "") -> str:
    """Jinja filter to provide a hash for arbitrary values."""
    if isinstance(items, dict):
        items = list([f"{k}{v}" for k, v in items.items()])
    elif not isinstance(items, list):
        items = list(items)
    h = hashlib.sha256()
    for item in items:
        h.update(bytes(str(item), "utf-8"))
    return f"{namespace}_{h.hexdigest()[:8]}"


def no_dot(s: str) -> str:
    """Jinja filter to ensure a domain has no trailing dot."""
    return s[:-1] if s.endswith(".") else s


if __name__ == "__main__":
    main()
