import json
import subprocess


def run_cmd(cmd, silent=False):
    print(' '.join(cmd))
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    if not silent:
        if len(out) > 0:
            print(out.decode('utf-8'))
        if len(err) > 0:
            print(err.decode('utf-8'))
    if p.returncode != 0:
        raise Exception(f"cmd error! ({p.returncode})")
    return out, err


def workspace_contains_app(workspace, app) -> bool:
    out, _ = run_cmd(['hyprctl', '-j', 'clients'], True)
    out = json.loads(out)

    for client in out:
        if client['workspace']['id'] != workspace:
            continue

        if client['title'] != app:
            continue

        return True

    return False


if workspace_contains_app(1, "Alacritty"):
    print("Is there")
    run_cmd(['hyprctl', '--batch', 'dispatch workspace 1;'])
else:
    print("Is not there")
    run_cmd(['hyprctl', '--batch', 'dispatch workspace 1;', 
             'dispatch exec alacritty -e /usr/bin/zsh -c "tmux new-session -A -s main -c ${HOME} && exec zsh"'])
