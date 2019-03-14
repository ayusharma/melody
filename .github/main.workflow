workflow "build and test" {
  on = "push"
  resolves = ["yarn"]
}

action "build" {
  uses = "./actions/yarn"
  args = "install --frozen-lockfile --non-interactive"
}

action "yarn" {
  uses = "./actions/yarn"
  needs = ["build"]
  args = "run test"
}
