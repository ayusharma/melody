workflow "build and test" {
  on = "push"
  resolves = [
    "lint",
    "verdaccio",
    "coverage",
    "\t./actions/verdaccio",
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

action "verdaccio" {
  uses = "./actions/verdaccio"
  needs = ["bundlesize"]
  args = "-ddd"
}

action "coverage" {
  uses = "./actions/yarn"
  needs = ["test"]
  args = "run coverage"
}

action "\t./actions/verdaccio" {
  uses = "\t./actions/verdaccio"
  needs = ["test"]
}
