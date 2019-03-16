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

workflow "node6" {
  on = "push"
  resolves = ["./actions/cli"]
}

action "Node 6" {
  uses = "./actions/cli"
  args = "'nvm install 6' 'nvm use 6'"
}

action "./actions/cli" {
  uses = "./actions/cli"
  needs = ["Node 6"]
  args = "'yarn' 'yarn run test'"
}
