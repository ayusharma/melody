#!/usr/bin/env node

/**
 * Check the commit formatting.
 * eg. v1.0.2
 */

const temp = process.env.GITHUB_SHA;
const commit = temp.trim();
console.log(commit);

const re = new RegExp(/^v(\d+\.){2}\d+(-\S+)?$/);

if (commit.match(re) === null) {
    console.error('Not a release commit');
    process.exit(78);
} else {
    console.log('Release commit');
    process.exit(0);
}
