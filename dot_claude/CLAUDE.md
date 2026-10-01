# Global instructions

## herdr
I usually run you inside herdr, a terminal multiplexer for coding agents
(workspaces → tabs → panes). `HERDR_ENV=1` means you are in a herdr pane.

- When I ask for something that involves herdr — its workspaces, tabs, panes,
  worktrees, or other agents running in it (e.g. "run the dev server in a
  split", "check on the agent in the other pane", "open a worktree for this") —
  first run `herdr --skill` and follow it. It is the guide bundled with the
  installed binary; don't use herdr commands or flags from memory.
- Don't reach for herdr on your own just because a task could run in the
  background or in parallel.
- If `HERDR_ENV` isn't `1`, say you're not inside herdr and don't control it.
