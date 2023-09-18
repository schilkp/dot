import argparse

from Colors import *
from Config import parse_config
from YayIntf import yay_install, yay_read_pkg_state, yay_remove


def main():
    parser = argparse.ArgumentParser(prog='SchilkPKG')

    parser.add_argument('action', help='Action to perform. Default: status',
                        nargs='?', choices=('install', 'remove', 'status'), default='status')
    parser.add_argument('groups', help='Package group', nargs='*', default=[])

    args = parser.parse_args()

    c = parse_config()
    yay_read_pkg_state(c)

    if args.action == 'status':
        for group in c.groups:
            print(f"{COLOR_CYAN}{group}{COLOR_NC}:")
            for package in c.groups[group].packages.values():
                if type(package.installed_version) is str:
                    print(f"  {COLOR_GREEN}{package.source}/{package.name}{COLOR_NC} ({package.installed_version})")
                else:
                    print(f"  {COLOR_RED}{package.source}/{package.name}{COLOR_NC}")
    elif args.action == 'install':
        if len(args.groups) == 0:
            raise Exception("No groups specified")
        packages_all = c.get_group_packages(args.groups, install_filter=None)
        print(
            f"{COLOR_CYAN}Implied packaes{COLOR_NC}: {', '.join([str(p) for p in packages_all])}")
        packages_needed = c.get_group_packages(args.groups, 'not installed')
        print(
            f"{COLOR_GREEN}Required packaes{COLOR_NC}: {', '.join(str(p) for p in packages_needed)}")
        yay_install(packages_needed)
    elif args.action == 'remove':
        if len(args.groups) == 0:
            raise Exception("No groups specified")
        packages_all = c.get_group_packages(args.groups, install_filter=None)
        print(
            f"{COLOR_CYAN}Implied packaes{COLOR_NC}: {', '.join([str(p) for p in packages_all])}")
        packages_to_remove = c.get_group_packages(args.groups, 'installed')
        print(
            f"{COLOR_RED}To be removed{COLOR_NC}: {', '.join(str(p) for p in packages_to_remove)}")
        yay_remove(packages_to_remove)


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(f"{COLOR_RED}Error: {e}{COLOR_NC}")
    except KeyboardInterrupt as e:
        print(f"Interruped.")

