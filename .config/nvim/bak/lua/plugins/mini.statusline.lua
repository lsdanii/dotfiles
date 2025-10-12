return {
  'echasnovski/mini.statusline',
  config = function()
    local statusline = require('mini.statusline')
    statusline.setup()
    -- Store a reference to the original `section_mode` function.
    local original_section_mode = statusline.section_mode
    statusline.section_mode = function(...)
      -- Call the original function to get the default mode and highlight.
      local mode, mode_hl = original_section_mode(...)
      -- Return the modified mode string, keeping the original highlight.
      return string.upper(mode), mode_hl
    end
  end,
}
