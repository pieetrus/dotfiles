return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    {
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
		    library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		    },
		},
	    },
	},
	config = function ()
	    vim.lsp.config("lua_ls", {})
	    vim.lsp.enable("lua_ls")
	    vim.filetype.add({
		extension = {
		    razor = "razor",
		    cshtml = "razor",
		},
	    })

	    vim.lsp.config("roslyn_ls", {
		filetypes = { "razor", "cs" },
		settings = {
		    -- better performance
		    ["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "openFiles",
		    },
		},
	    })
	    vim.lsp.enable("roslyn_ls")

	-- IMPORTANT: vim diagnostic configuration AFTER LSPs are loaded
	vim.diagnostic.config(
	  {
	    underline = false,
	    virtual_text = false,
	    update_in_insert = false,
	    severity_sort = true,
	    signs = {
	      text = {
		[vim.diagnostic.severity.ERROR] = " ",
		[vim.diagnostic.severity.WARN] = " ",
		[vim.diagnostic.severity.HINT] = " ",
		[vim.diagnostic.severity.INFO] = " ",
	      }
	    }
	  })
	end,
    },
}
