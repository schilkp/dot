import json
import os
from dataclasses import dataclass
from typing import Dict, List, Literal, Optional


@dataclass
class Config:
    groups: Dict[str, 'Group']

    def get_group_packages(self, groups: List[str], install_filter: Literal['installed'] | Literal['not installed'] | None) -> List['Package']:
        packages = {}
        for group in groups:

            if group not in self.groups:
                raise Exception(f"Unknown group {group}")

            for package in self.groups[group].packages.values():

                if install_filter == "installed":
                    if package.installed_version is not None:
                        packages[package.name] = package
                elif install_filter == "not installed":
                    if package.installed_version is None:
                        packages[package.name] = package
                else:
                    packages[package.name] = package

        return list(packages.values())


@dataclass
class Group:
    name: str
    packages: Dict[str, 'Package']


@dataclass
class Package:
    name: str
    source: str
    installed_version: Optional[str]

    def __str__(self) -> str:
        return f"{self.source}/{self.name}"


def parse_config() -> Config:

    dir_name = os.path.dirname(__file__)
    file_path = os.path.join(dir_name, "schilk_pkgs.json")
    file_path = os.path.abspath(file_path)

    with open(file_path) as infile:
        try:
            j = json.loads(infile.read())
        except json.JSONDecodeError as e:
            raise Exception(f"JSON error: {e}")

        groups = {}

        if type(j) is not dict:
            raise Exception("Invalid config format (root not dict)")

        for key in j:
            packages = {}

            if type(j[key]) is not list:
                raise Exception("Invalid config format (group not list)")

            for package in j[key]:
                if type(package) is not str:
                    raise Exception(
                        "Invalid config format (package is not str)")

                parts = package.split("/")
                if len(parts) != 2:
                    raise Exception("Misformed package name.")

                src = parts[0]
                name = parts[1]

                packages[name] = Package(
                    name=name, source=src, installed_version=None)

            groups[key] = Group(name=key, packages=packages)

        return Config(groups=groups)
