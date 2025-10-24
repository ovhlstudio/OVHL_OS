import chalk from 'chalk';
import ora from 'ora';

export class Logger {
  constructor() {
    this.spinner = null;
  }

  info(message) {
    console.log(chalk.cyan(`ℹ️  ${message}`));
  }

  // --- REVISI SIMPEL ---
  success(message, filePath = null) {
    let output = chalk.green(`✅ ${message}`);
    if (filePath) {
      // Print path-nya apa adanya. Terminal elu udah pinter
      output += ` ${chalk.dim(`(${filePath})`)}`;
    }
    console.log(output);
  }
  // --- END REVISI ---

  warning(message) {
    console.log(chalk.yellow(`⚠️  ${message}`));
  }

  error(message) {
    console.log(chalk.red(`❌ ${message}`));
  }

  startSpinner(message) {
    this.spinner = ora(message).start();
  }

  // --- REVISI SIMPEL ---
  succeedSpinner(message, filePath = null) {
    if (this.spinner) {
      let output = message;
      if (filePath) {
        // Print path-nya apa adanya.
        output += ` ${chalk.dim(`(${filePath})`)}`;
      }
      this.spinner.succeed(output);
      this.spinner = null;
    }
  }
  // --- END REVISI ---

  failSpinner(message) {
    if (this.spinner) {
      this.spinner.fail(message);
      this.spinner = null;
    }
  }
  
  warnSpinner(message) {
    if (this.spinner) {
      this.spinner.warn(message);
      this.spinner = null;
    } else {
      this.warning(message);
    }
  }
}

export const logger = new Logger();