#!/usr/bin/env node

const cp = require("child_process");
cp.execSync(`cd ${__dirname}; npm ci`);

const exec = cmd => cp.execSync(cmd).toString().trim();

const re = new RegExp(/^v(\d+\.){2}\d+(-\S+)?$/);
const commitMessage = exec(`git log -1 --pretty=format:%s${process.env.GITHUB_SHA}}`);

if (commitMessage.match(re) === null) {
    console.error('Not a release commit');
    process.exit(78);
} else {
    console.log('Release commit');
    process.exit(0);
}
