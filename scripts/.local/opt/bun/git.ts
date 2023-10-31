import { Command } from "commander";

const program = new Command();

const httpPrefix = "https://github.com/elkjopnordic";
const sshPrefix = "git@github.com:elkjopnordic";

program
    .command("clone <url>")
    .option("-o, --output [path]", "Clone output directory")
    .action(async (url: string, options: { output?: string }) => {
        let cloneUrl = url;
        if (!(url.startsWith(httpPrefix) || url.startsWith(sshPrefix))) {
            cloneUrl = `${sshPrefix}/${url}`;
        }

        const serviceName = url.split("elkjopnordic/").pop()!;
        let outputDir = options.output ?? "";

        if (!outputDir) {
            outputDir = `${process.env.ELKJOP_GIT_REPOSITORIES}/${serviceName.replaceAll(
                ".",
                "/",
            )}`;
        }

        const proc = Bun.spawn(["git", "clone", cloneUrl, outputDir]);
        await proc.exited;
    });

program.parse();
