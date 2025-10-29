local M = {}

function M.yaml_schemas()
  return require("schemastore").yaml.schemas({
    -- select subset from the JSON schema catalog:
    select = {
      -- 'docker-compose.yml'
    },

    -- additional schemas (not in the catalog):
    extra = {
      -- {
      --     description = 'test',
      --     fileMatch = 'max77654.yaml',
      --     name = 'out.json',
      --     url = 'file:///home/schilkp/reps/reginald/reginald/out.json',
      -- },
    },
  })
end

function M.json_schemas()
  return require("schemastore").json.schemas({
    -- select subset from the JSON schema catalog:
    select = {},

    -- additional schemas (not in the catalog):
    extra = {
      -- {
      --     description = 'test',
      --     fileMatch = 'max77654.json',
      --     name = 'out.json',
      --     url = 'file:///home/schilkp/reps/reginald/reginald/out.json',
      -- },
    },
  })
end

return M
