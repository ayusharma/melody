workflow "New workflow" {
  on = "push"
  resolves = [
    "Install",
  ]
}

action "Install" {
  uses = "trivago/melody/actions/yarn@github-actions"
  args = "install --frozen-lockfile --non-interactive"
}