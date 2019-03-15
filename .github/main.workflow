workflow "build and test" {
  on = "push"
  resolves = [
    "lint",
    "E2E: Verdaccio",
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

action "bundlesize" {
  uses = "./actions/yarn"
  needs = ["test"]
  args = "run bundlesize"
}

action "E2E: Verdaccio" {
  uses = "./actions/verdaccio"
  needs = ["bundlesize"]
  args = "-ddd"
}
