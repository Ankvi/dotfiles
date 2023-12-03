import { Command } from "commander";
import { install } from "./installingPackages";

const program = new Command();

program
    .command("install-packages")
    .action(install);

program.parse();
