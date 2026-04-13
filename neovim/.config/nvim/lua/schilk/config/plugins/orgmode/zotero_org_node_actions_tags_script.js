// @author schilkp
// @link
// @usage
// @update Tue Apr  7 11:44:56 AM CEST 2026

// === UTILS ===================================================================

function openInTerminal(args, env) {
  const term = Components.classes["@mozilla.org/file/local;1"].createInstance(
    Components.interfaces.nsIFile,
  );
  term.initWithPath("/usr/bin/kitty"); // TODO config?

  const environment = Components.classes[
    "@mozilla.org/process/environment;1"
  ].getService(Components.interfaces.nsIEnvironment);
  for (const [k, v] of Object.entries(env)) {
    environment.set(k, v);
  }

  const proc = Components.classes["@mozilla.org/process/util;1"].createInstance(
    Components.interfaces.nsIProcess,
  );
  proc.init(term);

  const kitty_args = ["--"].concat(args);
  proc.runAsync(kitty_args, kitty_args.length);
}

// === SCRIPT ==================================================================

if (collection) {
  return "[CreateRoamNode] collection not supported";
}
if (items && items.length > 1) {
  return "[CreateRoamNode] multiple items not supported";
}
if (!item) {
  return "[CreateRoamNode] no item selected";
}
if (item.isPDFAttachment()) {
  return "[CreateRoamNode] selected PDF attachement - select entry instead"; // TODO automate?
}
if (item.isAnnotation()) {
  return "[CreateRoamNode] annotations not supported";
}

item_data = JSON.parse(JSON.stringify(item));

item_data.pdf_attachment = (await item.getBestAttachments()).find((att) =>
  att.isPDFAttachment(),
);

item_data = JSON.stringify(item_data);

cmd = ["nvim", "-c", 'lua require("schilk.config.plugins.orgmode.zotero_org_node").env_node()'];
env = { ZOTERO_ITEM: item_data };

openInTerminal(cmd, env);

return "[OK]";
