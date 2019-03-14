workflow "New workflow" {
  on = "push"
  resolves = [
    "Install",
  ]
}

action "Install" {
  uses = "./actions/yarn"
  args = "install --frozen-lockfile --non-interactive"
}