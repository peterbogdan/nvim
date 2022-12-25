local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print("[Error]Comment not found!")
  return
end

comment.setup {
    ignore = '^$',
}
