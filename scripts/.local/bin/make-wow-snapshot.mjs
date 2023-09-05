#!/usr/bin/env node

import { exec } from "child_process";

function execa(cmd, opts) {
    return new Promise((resolve, reject) => {
        exec(cmd, opts, (err, stdout) => {
            if (err) {
                reject(err);
                return;
            }
            resolve(stdout);
        })
    })
}

const directory = `${process.env.HOME}/Games/battlenet/drive_c/"Program Files (x86)"/"World of Warcraft"`;

try {
    const now = new Date();
    const commitMessage = `Backup: ${now.toLocaleDateString("en-GB")}`;

    await execa(`git commit -am "${commitMessage}"`, {
        cwd: directory
    });
    await execa("git push", {
        cwd: directory
    });
} catch (error) {
    console.error("WoW WTF backup failed with error:");
    console.error(error);
}
