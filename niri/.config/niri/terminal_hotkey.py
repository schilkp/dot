import json
import subprocess

MAIN_KITTY_TITLE='kitty [main]'

def run_cmd(cmd):
    print("> " + ' '.join(cmd))
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    if p.returncode != 0:
        raise Exception(f"cmd error! ({p.returncode}): {err.decode('utf-8')}")
    return out, err


def find_main_output() -> str:
    outputs_json, _ = run_cmd(['niri', 'msg', '--json', 'outputs'])
    outputs_json = json.loads(outputs_json)

    outputs = list(outputs_json.keys())

    if len(outputs) == 0:
        raise Exception("no main output?")

    if len(outputs) == 1:
        return outputs[0]

    # Sort monitors by x:
    outputs = sorted(
        outputs, key=lambda item: outputs_json[item]["logical"]["x"])

    return outputs[1]


def focus_output(output: str):
    run_cmd(['niri', 'msg', 'action', 'focus-monitor', output])


def focus_workspace(idx: int):
    run_cmd(['niri', 'msg', 'action', 'focus-workspace', str(idx)])


def focus_window(window_id: int):
    run_cmd(['niri', 'msg', 'action', 'focus-window', '--id', str(window_id)])


def launch_kitty():
    run_cmd(['niri', 'msg', 'action', 'spawn', '--', 'kitty',
            '--session', 'tmux_session', '--title', MAIN_KITTY_TITLE])


def find_output_workspace(output: str, idx: int) -> int | None:
    workspaces, _ = run_cmd(['niri', 'msg', '--json', 'workspaces'])
    workspaces = json.loads(workspaces)

    # filter to correct output:
    workspaces = [w for w in workspaces if w["output"] == output]
    if len(workspaces) == 0:
        print(f"No workspaces on output {output}!")
        return None

    # filter to idx:
    workspaces = [w for w in workspaces if w["idx"] == idx]
    if len(workspaces) == 0:
        print(f"No workspaces with idx {idx} on output {output}!")
        return None

    return workspaces[0]["id"]


def find_workspace_window(workspace_id: int, app_id: str | None, title: str | None) -> int | None:
    windows, _ = run_cmd(['niri', 'msg', '--json', 'windows'])
    windows = json.loads(windows)

    for window in windows:
        if window['workspace_id'] != workspace_id:
            continue
        
        if app_id:
            if window['app_id'] != app_id:
                continue
        
        if title:
            if window['title'] != title:
                continue

        return window['id']

    return None


def main():
    main_output = find_main_output()
    print(f"main output: {main_output}")
    focus_output(main_output)

    main_workspace = find_output_workspace(main_output, 1)
    print(f"main workspace: {main_workspace}")
    if main_workspace is None:
        print("launching kitty in workspace 1")
        focus_workspace(1)
        launch_kitty()
        return

    kitty_window = find_workspace_window(main_workspace, "kitty", MAIN_KITTY_TITLE)
    print(f"kitty window: {kitty_window}")
    if kitty_window is None:
        print("launching kitty in main workspace")
        focus_workspace(main_workspace)
        launch_kitty()
        return

    print("focusing kitty")
    focus_window(kitty_window)


if __name__ == '__main__':
    main()
