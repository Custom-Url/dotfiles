-- This is the main configuration file for Neovim. It sets up basic settings, plugins, LSP configurations, and keybindings.
-----------------------------------------------------------
-- BASIC SETTINGS
-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.mouse = ""

-- System clipboard
vim.opt.clipboard = "unnamedplus"

vim.cmd.colorscheme("retrobox")

-----------------------------------------------------------
-- LAZY.NVIM
-----------------------------------------------------------

local lazypath = "/mnt/data/dg765/.local/share/nvim/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.notify("lazy.nvim not found at " .. lazypath, vim.log.levels.ERROR)
    return
end

vim.opt.rtp:prepend(lazypath)


-----------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------

require("lazy").setup({

    -------------------------------------------------------
    -- GitHub Copilot
    -------------------------------------------------------

    {
        "github/copilot.vim",
    },


    -------------------------------------------------------
    -- LSP
    -------------------------------------------------------

    {
        "neovim/nvim-lspconfig",
    },


    -------------------------------------------------------
    -- Completion
    -------------------------------------------------------

    {
        "hrsh7th/nvim-cmp",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },

        config = function()

            local cmp = require("cmp")

            cmp.setup({

                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({

                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                    }),

                    ["<Tab>"] = cmp.mapping.select_next_item(), 
                    
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                    ["<C-e>"] = cmp.mapping.abort(),

                }),

                sources = cmp.config.sources({

                    { name = "nvim_lsp" },

                }, {

                    { name = "buffer" },
                    { name = "path" },

                }),

            })

        end,
    },


    -------------------------------------------------------
    -- Treesitter
    -------------------------------------------------------

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },


    -------------------------------------------------------
    -- Git integration
    -------------------------------------------------------

    {
        "lewis6991/gitsigns.nvim",

        opts = {},
    },


    -------------------------------------------------------
    -- Telescope
    -------------------------------------------------------

    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },


    -------------------------------------------------------
    -- Status line
    -------------------------------------------------------

    {
        "nvim-lualine/lualine.nvim",

        opts = {},
    },


    -------------------------------------------------------
    -- Which-key
    -------------------------------------------------------

    {
        "folke/which-key.nvim",

        opts = {},
    },

})


-----------------------------------------------------------
-- LSP CAPABILITIES
-----------------------------------------------------------

local capabilities =
    require("cmp_nvim_lsp").default_capabilities()


-----------------------------------------------------------
-- PYTHON / PYRIGHT
-----------------------------------------------------------

vim.lsp.config("pyright", {

    cmd = {
        "/mnt/data/dg765/.venvs/nvim/bin/pyright",
    },

    capabilities = capabilities,

    filetypes = {
        "python",
    },

})

vim.lsp.enable("pyright")


-----------------------------------------------------------
-- FORTRAN / FORTLS
-----------------------------------------------------------

vim.lsp.config("fortls", {

    cmd = {
        "/mnt/data/dg765/.venvs/nvim/bin/fortls",

        "--lowercase_intrinsics",
        "--hover_signature",
        "--hover_language=fortran",

    },

    capabilities = capabilities,

    filetypes = {
        "fortran",
    },

})

vim.lsp.enable("fortls")


-----------------------------------------------------------
-- LSP KEYBINDINGS
-----------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {

    callback = function(event)

        local opts = {
            buffer = event.buf,
            silent = true,
        }

        -- Go to definition
        vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            opts
        )

        -- Go to declaration
        vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            opts
        )

        -- Find references
        vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            opts
        )

        -- Documentation / hover
        vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            opts
        )

        -- Rename symbol
        vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            opts
        )

        -- Code actions
        vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
        )

        -- Show diagnostic
        vim.keymap.set(
            "n",
            "<leader>e",
            vim.diagnostic.open_float,
            opts
        )

        -- Previous diagnostic
        vim.keymap.set(
            "n",
            "[d",
            vim.diagnostic.goto_prev,
            opts
        )

        -- Next diagnostic
        vim.keymap.set(
            "n",
            "]d",
            vim.diagnostic.goto_next,
            opts
        )

    end,

})


-----------------------------------------------------------
-- DIAGNOSTICS
-----------------------------------------------------------

vim.diagnostic.config({

    virtual_text = true,

    signs = true,

    underline = true,

    update_in_insert = false,

    severity_sort = true,

    float = {
        border = "rounded",
        source = true,
    },

})


-----------------------------------------------------------
-- GIT / GITSIGNS
-----------------------------------------------------------

vim.keymap.set(
    "n",
    "<leader>gp",
    ":Gitsigns preview_hunk<CR>",
    { silent = true }
)

vim.keymap.set(
    "n",
    "<leader>gb",
    ":Gitsigns blame_line<CR>",
    { silent = true }
)

vim.keymap.set(
    "n",
    "<leader>gd",
    ":Gitsigns diffthis<CR>",
    { silent = true }
)


-----------------------------------------------------------
-- TELESCOPE
-----------------------------------------------------------

vim.keymap.set(
    "n",
    "<leader>ff",
    ":Telescope find_files<CR>",
    { silent = true }
)

vim.keymap.set(
    "n",
    "<leader>fg",
    ":Telescope live_grep<CR>",
    { silent = true }
)

vim.keymap.set(
    "n",
    "<leader>fb",
    ":Telescope buffers<CR>",
    { silent = true }
)


-----------------------------------------------------------
-- TERMINAL
-----------------------------------------------------------

vim.keymap.set(
    "n",
    "<leader>t",
    ":split | terminal<CR>",
    { silent = true }
)


-----------------------------------------------------------
-- FORTRAN SETTINGS
-----------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {

    pattern = {
        "fortran",
    },

    callback = function()

        -- Your Fortran code uses conventional 3-space indentation
        vim.opt_local.tabstop = 3
        vim.opt_local.shiftwidth = 3
        vim.opt_local.expandtab = false

        -- Don't wrap long AMITEX/UMAT lines
        vim.opt_local.wrap = false

    end,

})


-----------------------------------------------------------
-- PYTHON SETTINGS
-----------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {

    pattern = {
        "python",
    },

    callback = function()

        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true

    end,

})


-----------------------------------------------------------
-- COPILOT
-----------------------------------------------------------

vim.g.copilot_enabled = true

-- Don't let Copilot take over <Tab>
vim.g.copilot_no_tab_map = true


-- Accept Copilot suggestion
vim.keymap.set(
    "i",
    "<C-J>",
    'copilot#Accept("<CR>")',
    {
        expr = true,
        replace_keycodes = false,
    }
)


-- Next Copilot suggestion
vim.keymap.set(
    "i",
    "<C-K>",
    "<Plug>(copilot-next)"
)


-- Previous Copilot suggestion
vim.keymap.set(
    "i",
    "<C-L>",
    "<Plug>(copilot-previous)"
)


-----------------------------------------------------------
-- USEFUL GENERAL KEYBINDINGS
-----------------------------------------------------------

-- Save
vim.keymap.set(
    "n",
    "<leader>w",
    ":write<CR>",
    { silent = true }
)

-- Quit
vim.keymap.set(
    "n",
    "<leader>q",
    ":quit<CR>",
    { silent = true }
)

-- Clear search highlighting
vim.keymap.set(
    "n",
    "<Esc>",
    ":nohlsearch<CR>",
    { silent = true }
)

