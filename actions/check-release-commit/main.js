#!/usr/bin/env node

/**
 * Check the commit formatting.
 * eg. v1.0.2
 */

const exec = require('@actions/exec');

const re = new RegExp(/^v(\d+\.){2}\d+(-\S+)?$/);
const commitMessage = exec.exec(`git log -1 --pretty=format:%s${process.env.GITHUB_SHA}}`);

if (commitMessage.match(re) === null) {
    console.error('Not a release commit');
    process.exit(78);
} else {
    console.log('Release commit');
    process.exit(0);
}
