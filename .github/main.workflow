workflow "build and test" {
  on = "push"
  resolves = [
    "lint",
    "coverage",
    "bundlesize",
    "verdaccio",
    "test",
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

action "coverage" {
  uses = "./actions/yarn"
  needs = ["test"]
  args = "run coverage"
}

action "verdaccio" {
  uses = "./actions/verdaccio"
  needs = ["test"]
  args = "-ddd"
}

workflow "node 10" {
  on = "push"
  resolves = ["node 10: test"]
}

action "node 10: install" {
  uses = "./actions/nvm"
  args = "n 10"
}

action "node 10: build" {
  uses = "./actions/nvm"
  needs = ["node 10: install"]
  args = "yarn install --frozen-lockfile --non-interactive"
}

action "node 10: test" {
  uses = "./actions/nvm"
  needs = ["node 10: build"]
  args = "yarn run test"
}
