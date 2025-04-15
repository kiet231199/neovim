local status_ok, codecompanion = pcall(require, "codecompanion")
if not status_ok then
	print("Error: codecompanion")
	return
end

codecompanion.setup({
    adapters = {
        ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
                env = {
                    url = "localhost:11434",
                },
                schema = {
                    model = {
                        default = "deepseek-coder:1.3b",
                    },
                    num_ctx = {
                        default = 2048, -- Default number of Ollama
                    },
                },
            })
        end,
    },
    strategies = {
        chat = {
            adapter = "ollama",
        },
        inline = {
            adapter = "ollama",
        },
        cmd = {
            adapter = "ollama",
        },
    },
})
