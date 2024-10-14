if vim.fn.has("nvim-0.9.0") ~= 1 then
	vim.api.nvim_err_writeln("Dataform.nvim requires at least nvim-0.9.0.")
end

-- Dataform sqlx files are a combination of sql interpolated with javascript,
-- it also contains some framework specific tokens for the custom sqlx format.
-- Because of this neither the js or the sql parser do a proper job with highlight,
-- comments, and understanding context.
--
-- The ideal approach is to write a simple grammar for dataform and build a
-- custom parser to be used by this extension.
-- Good thing is a generic parser can be reused in other enviroments other than
-- neovim.
--
-- The dataform-co/dataform project contains the tokenizer user by the dataform
-- runtime, and also a simple LSP server that powers the vscode extension.
-- Both the server and the file extension offer a gross developer experience.
-- Maybe there is an opportunity to build better LSP powered by my custom parser.

-- Creates a simple filetype for dataform
-- Eventually will add a callback to understand project strucuture.
vim.filetype.add({
	extension = {
		sqlx = "dataform",
	},
	pattern = {
		[".*/definitions/.*.sqlx"] = "dataform",
	},
})

-- Setting sql syntax highlight for sqlx files
vim.treesitter.language.register("sql", "dataform")
