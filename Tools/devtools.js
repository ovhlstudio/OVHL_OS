#!/usr/bin/env node
// 🚀 OVHL Core DevTools Runner (MVP)

import path from 'path';
import chalk from 'chalk';
import ora from 'ora';
import { fileURLToPath } from 'url';
import { pathToFileURL } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename); // /d/OVHL_STUDIO/OVHL_OS/Tools
const projectRoot = path.resolve(__dirname, '..'); // /d/OVHL_STUDIO/OVHL_OS

// Get command line arguments, excluding 'node' and the script path
const args = process.argv.slice(2);
const command = args[0];
const commandArgs = args.slice(1);

async function main() {
    console.log(chalk.cyan('🔥 OVHL Core DevTools Runner V1 (MVP)'));

    if (!command) {
        console.log(chalk.yellow('ℹ️  Usage: node Tools/devtools.js <command> [...args]'));
        console.log('Available commands (MVP): run:task <task_file_path_relative_to_root>');
        return;
    }

    const spinner = ora('Executing command: ' + chalk.bold(command) + '...').start();

    try {
        switch (command) {
            case 'run:task':
                if (!commandArgs[0]) throw new Error('Missing argument: <task_file_path_relative_to_root> required for run:task');
                const taskPathArg = commandArgs[0];
                const taskPath = path.resolve(projectRoot, taskPathArg);
                
                spinner.text = 'Loading task: ' + chalk.blue(path.basename(taskPath)) + '...';
                
                const taskModule = await import(pathToFileURL(taskPath).href);
                
                if (typeof taskModule.default !== 'function') {
                    throw new Error("Task script '" + taskPath + "' does not export a default function.");
                }
                
                spinner.text = 'Running task: ' + chalk.blue(path.basename(taskPath)) + '...';
                
                const report = await taskModule.default();
                
                spinner.stop();
                printReport(report);
                break;
            
            // TODO: Add routing for other commands (create:module, etc.) later

            default:
                throw new Error("Unknown command: '" + command + "'.");
        }
    } catch (error) {
        spinner.fail(chalk.red("Command '" + command + "' failed!"));
        console.error(chalk.red('Error Details:'), error.message);
        process.exitCode = 1;
    }
}

function printReport(report) {
    console.log('\n--- ' + chalk.bold('MISSION REPORT') + ' ---');
    console.log('Mission: ' + chalk.yellow(report.mission));
    
    if (report.status === "SUCCESS") {
        console.log('Status: ' + chalk.green.bold(report.status) + ' ✅');
    } else {
        console.log('Status: ' + chalk.red.bold(report.status) + ' ❌');
    }

    console.log('\n' + chalk.underline('Logs:'));
    if (report.logs && report.logs.length > 0) {
        report.logs.forEach(log => console.log('- ' + log));
    } else {
        console.log('- No logs recorded.');
    }

    if (report.summary && Object.keys(report.summary).length > 0) {
        console.log('\n' + chalk.underline('Summary:'));
        for (const key in report.summary) {
            console.log('- ' + key + ': ' + report.summary[key]);
        }
    }

    if (report.error) {
        console.log('\n' + chalk.red.underline('Error:'));
        console.log(chalk.red(report.error));
    }
    console.log('--- END REPORT ---');
}

main();