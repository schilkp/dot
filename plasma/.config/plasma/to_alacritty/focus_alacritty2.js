function FocusOrOpenAlacritty() {
    var allClients = workspace.windowList();

    for (var i = 0; i < allClients.length; ++i) {
        if(/Alacritty/.test(allClients[i].caption)) {
            print("FOUND!")
            workspace.activeWindow = allClients[i];
            workspace.raiseWindow(allClients[i]);
            return;
        }
    }

    print("Need to open...")

}

print("Running!")
FocusOrOpenAlacritty()
