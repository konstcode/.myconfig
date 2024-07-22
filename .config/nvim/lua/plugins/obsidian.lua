return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  --ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/Documents/notes/personal/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/notes/personal/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Define the Lua function to prompt for a new name and execute the rename command
    function ObsidianRename()
      local new_name = vim.fn.input("New name: ")
      if new_name ~= "" then
        vim.cmd("ObsidianRename " .. new_name)
      end
    end
    -- Map a key combination to the Lua function
    vim.api.nvim_set_keymap(
      "n",
      "<leader>or",
      ":lua ObsidianRename()<CR>",
      { noremap = true, silent = true }
    )
    vim.keymap.set("v", "<leader>ol", "<CMD>ObsidianLinkNew<CR>", {})

    local opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/notes/personal",
        },
        {
          name = "lseg",
          path = "~/Documents/notes/lseg",
        },
      },

      mappings = {
        ["<leader><leader>"] = {
          action = function()
            return "<CMD>ObsidianQuickSwitch<CR>"
          end,
          opts = { buffer = true, expr = true },
        },
        ["<leader>ot"] = {
          action = function()
            return "<CMD>ObsidianTemplate<CR>"
          end,
          opts = { buffer = true, expr = true },
        },
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["<leader>oo"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>oc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "daily",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },

      -- Optional, for templates (see below).
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      new_notes_location = "inbox",

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local inbox_dir = spec.dir / "inbox"
        local path = inbox_dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        --        vim.fn.jobstart({ "open", url }) -- Mac OS
        vim.fn.jobstart({ "xdg-open", url }) -- linux
      end,

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets/imgs", -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },

      disable_frontmatter = false,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        -- Get the current date and time.
        local date_time = os.date("%Y-%m-%d %H:%M:%S")
        local out = { id = note.id, aliases = note.aliases, tags = note.tags, date = date_time }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
    }

    require("obsidian").setup(opts)

    -- Enable spell checking
    vim.cmd("setlocal spell")
    vim.cmd("setlocal spelllang=en_us,ru")
  end,
}
