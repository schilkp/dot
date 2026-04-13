local M = {}

local function wordwrap(text, width)
  local lines = {}
  local line = ""
  for word in text:gmatch("%S+") do
    if #line == 0 then
      line = word
    elseif #line + 1 + #word <= width then
      line = line .. " " .. word
    else
      table.insert(lines, line)
      line = word
    end
  end
  if #line > 0 then
    table.insert(lines, line)
  end
  return table.concat(lines, "\n")
end

local function content(data)
  local result = "* " .. data.title .. "\n\n"

  -- authors:
  if data.creators ~= nil and #data.creators > 0 then
    local authors = {}
    for _, creator in ipairs(data.creators) do
      if creator.creatorType == "author" then
        local name = ""
        if creator.firstName and creator.lastName then
          name = creator.firstName .. " " .. creator.lastName
        elseif creator.lastName then
          name = creator.lastName
        elseif creator.name then
          name = creator.name
        end
        if name ~= "" then
          table.insert(authors, name)
        end
      end
    end
    if #authors > 0 then
      result = result .. "Authors: " .. table.concat(authors, ", ") .. "\n"
    end
  end

  -- date:
  if data.date ~= nil and data.date ~= "" then
    result = result .. "Date: " .. data.date .. "\n"
  end

  -- publication/conference:
  if data.proceedingsTitle ~= nil and data.proceedingsTitle ~= "" then
    result = result .. "In: " .. data.proceedingsTitle .. "\n"
  elseif data.publicationTitle ~= nil and data.publicationTitle ~= "" then
    result = result .. "Journal: " .. data.publicationTitle .. "\n"
  end

  -- series:
  if data.series ~= nil and data.series ~= "" then
    result = result .. "Series: " .. data.series .. "\n"
  end

  -- doi/url:
  if data.DOI ~= nil and data.DOI ~= "" then
    result = result .. "DOI: https://doi.org/" .. data.DOI .. "\n"
  elseif data.url ~= nil and data.url ~= "" then
    result = result .. "URL: " .. data.url .. "\n"
  end

  -- item link:
  result = result .. "Zotero Entry: zotero://select/library/items/" .. data.key .. "\n"

  -- pdf link:
  if data.pdf_attachment ~= nil then
    result = result .. "Zotero PDF: zotero://open-pdf/library/items/" .. data.pdf_attachment.key .. "\n"
  end

  if data.abstractNote ~= nil and data.abstractNote ~= "" then
    result = result .. "\n\n** Abstract\n" .. wordwrap(data.abstractNote, 80) .. "\n"
  end

  return result
end

function M.env_node()
  if vim.env.ZOTERO_ITEM == nil then
    error("[ZoteroToRoam]: ZOTERO_ITEM not set!")
    return
  end

  local success, data = pcall(vim.json.decode, vim.env.ZOTERO_ITEM)
  if not success then
    error("[ZoteroToRoam]: ZOTERO_ITEM is invalid JSON")
    return
  end
  local node_content = content(data)

  local roam = require("org-roam")
  local title = vim.trim(data.title)
  roam.api.capture_node({
    title = "@" .. title,
    origin = "",
    templates = {
      z = {
        target = "@%[slug].org",
        template = node_content,
      },
    },
  })
end

return M
