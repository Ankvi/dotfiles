#!/usr/bin/env bun

const directory = `${process.env.HOME}/Games/battlenet/drive_c/"Program Files (x86)"/"World of Warcraft"`;

try {
    const now = new Date();
    const commitMessage = `Backup: ${now.toLocaleDateString("en-GB")}`;

    console.log(`Making WoW backup with message:\n${commitMessage}`);

    const commitProcess = Bun.spawn(["git", "commit", "-am", commitMessage], {
        cwd: directory,
    });

    const exitCode = await commitProcess.exited;
    if (exitCode) {
        throw new Error(commitProcess.stderr);
    }

    await Bun.spawn(["git", "push"], {
        cwd: directory,
    }).exited;
} catch (error) {
    console.error("WoW WTF backup failed with error:");
    console.error(error);
}
