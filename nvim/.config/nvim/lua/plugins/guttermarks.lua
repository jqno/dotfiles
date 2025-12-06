return {
    "dimtion/guttermarks.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },

    opts = {
        special_mark = {
            enabled = true,
            priority = 1,
        }
    }
}
