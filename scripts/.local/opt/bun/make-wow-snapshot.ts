const directory = `${process.env.HOME}/Games/battlenet/drive_c/Program\ Files\ (x86)/World\ of\ Warcraft`;

const options = {
    cwd: directory,
    stderr: "pipe"
} as const;

try {
    console.log("World of Warcraft folder: ", directory);

    const now = new Date();
    const commitMessage = `Backup: ${now.toLocaleDateString("en-GB")}`;

    const statusProcess = Bun.spawn(["git", "status", "--short"], options);
    let exitCode = await statusProcess.exited;
    if (exitCode) {
        const error = await new Response(statusProcess.stderr).text();
        throw new Error(error);
    }

    const filesChanged = (await new Response(statusProcess.stdout).text()).split("\n");
    if (!filesChanged.length) {
        console.log("No files have been changed. Exiting.");
    }

    console.log(`Staging ${filesChanged.length} files`);
    const stagingProcess = Bun.spawn(["git", "add", "-A"], options);

    exitCode = await stagingProcess.exited;
    if (exitCode) {
        const error = await new Response(stagingProcess.stderr).text();
        throw new Error(error);
    }

    console.log(`Making WoW backup with message:\n${commitMessage}`);
    const commitProcess = Bun.spawn(["git", "commit", "-m", commitMessage], options);

    exitCode = await commitProcess.exited;
    if (exitCode) {
        const error = await new Response(commitProcess.stderr).text();
        throw new Error(error);
    }

    console.log("Pushing to git");
    await Bun.spawn(["git", "push"], options).exited;

    console.log("WoW backed up successfully");
} catch (error) {
    console.error("WoW WTF backup failed with error:");
    console.error(error);
}
