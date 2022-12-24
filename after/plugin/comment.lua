local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    print("Comment module not installed!")
    return
end
comment.setup {
    ignore = '^$',
    mappings = {
        basic = false,
        extra = false,
    },
    pre_hook = function(ctx)
        print(ctx.type)
        if vim.bo.filetype == 'py' then
            return comment.api.toggle.linewise(ctx)
        end
    end,
}
