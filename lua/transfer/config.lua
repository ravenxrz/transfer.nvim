local M = {}

M.defaults = {
  -- deployment config template: can be a string, a function or a table of lines
  config_template = [[
return {
  ["wuli38"] = {
    host = "wuli38",
    mappings = {
      {
        ["local"] = ".",
        ["remote"] = "/data04/zhangxingrui/Projects/pagestore",
      },
    },
    excludedPaths = {
      "build", -- local path relative to project root
    },
    auto_download = {
      enable = true,
      interval = 60, -- in seconds
      mappings = {
        --
        -- 如果是目录，末尾添加/
        --
        {
          ["local"] = "build/src/pagestore/proto/",
          ["remote"] = "/data04/zhangxingrui/Projects/pagestore/build/src/pagestore/proto/pst_proto/",
        },
        {
          ["local"] = "build/src/pagestore/qos/proto/",
          ["remote"] = "/data04/zhangxingrui/Projects/pagestore/build/src/pagestore/qos/proto/",
        },
        {
          ["local"] = "build/src/pagestore/server/delta_db/proto/",
          ["remote"] = "/data04/zhangxingrui/Projects/pagestore/build/src/pagestore/server/delta_db/proto/",
        },
        {
          ["local"] = "build/compile_commands.json.tmp",
          ["remote"] = "/data04/zhangxingrui/Projects/pagestore/build/compile_commands.json",
          post_hook = "sed -i '' 's|/data04/zhangxingrui/Projects/pagestore|/Users/leo/Projects/pagestore|g' /Users/leo/Projects/pagestore/build/compile_commands.json.tmp; cp -f /Users/leo/Projects/pagestore/build/compile_commands.json.tmp /Users/leo/Projects/pagestore/build/compile_commands.json"
        },
      },
    },
  },
}

]],
  close_diffview_mapping = "<leader>b", -- buffer related mapping to close diffview, set to nil to disable mapping
  upload_rsync_params = {               -- a table of strings or functions
    "-rlzi",
    "--delete",
    "--checksum",
    "--exclude",
    ".git",
    "--exclude",
    ".idea",
    "--exclude",
    ".DS_Store",
    "--exclude",
    ".nvim",
    "--exclude",
    "*.pyc",
  },
  download_rsync_params = { -- a table of strings or functions
    "-rz",
    "--delete",
    "--checksum",
    "--exclude",
    ".git",
    "--exclude",
    ".nvim",
  },
  auto_download = {
    enable = false,
    interval = 300, -- in seconds
    mappings = {},
  },
}

M.options = {}

M.setup = function(opts)
  opts = opts or {}
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
