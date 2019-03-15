workflow "build and test" {
  on = "push"
  resolves = [
    "lint",
    "./actions/yarn",
  ]
}

action "build" {
  uses = "./actions/yarn"
  args = "install --frozen-lockfile --non-interactive"
}

action "test" {
  uses = "./actions/yarn"
  needs = ["build"]
  args = "run test"
}

action "lint" {
  uses = "./actions/yarn"
  needs = ["build"]
  args = "run lint"
}

action "./actions/yarn" {
  uses = "./actions/yarn"
  needs = ["test"]
  args = "run bundlesize"
}
