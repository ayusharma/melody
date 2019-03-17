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
  uses = "./actions/cli"
  args = "yarn install --frozen-lockfile --non-interactive"
}

action "test" {
  uses = "./actions/cli"
  needs = ["build"]
  args = "yarn run test"
}

action "lint" {
  uses = "./actions/cli"
  needs = ["build"]
  args = "yarn run lint"
}

action "bundlesize" {
  uses = "./actions/cli"
  needs = ["test"]
  args = "yarn run bundlesize"
}

action "coverage" {
  uses = "./actions/cli"
  needs = ["test"]
  args = "yarn run coverage"
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
  uses = "./actions/cli"
  args = "n 10"
}

action "node 10: build" {
  uses = "./actions/cli"
  needs = ["node 10: install"]
  args = "n 10 && yarn install --frozen-lockfile --non-interactive"
}

action "node 10: test" {
  uses = "./actions/cli"
  needs = ["node 10: build"]
  args = "n 10 && yarn run test"
}

workflow "node 6" {
  on = "push"
  resolves = ["node 6: test"]
}

action "node 6: install" {
  uses = "./actions/cli"
  args = "n 6"
}

action "node 6: build" {
  uses = "./actions/cli"
  needs = ["node 6: install"]
  args = "n 6 && yarn install --frozen-lockfile --non-interactive"
}

action "node 6: test" {
  uses = "./actions/cli"
  needs = ["node 6: build"]
  args = "n 6 && yarn run test"
}
