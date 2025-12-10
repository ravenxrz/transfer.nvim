local transfer = require("transfer.transfer")
local config = require("transfer.config")
local commands = require("transfer.commands")

transfer.setup = function(opts)
  config.setup(opts)
  commands.setup()
  -- delay execution to allow user config to be loaded
  vim.defer_fn(function()
    transfer.start_auto_download()
  end, 1000)
end

return transfer
