import chalk from 'chalk';
import ora from 'ora';

export class Logger {
  constructor() {
    this.spinner = null;
  }

  info(message) {
    console.log(chalk.cyan(`ℹ️  ${message}`));
  }

  success(message) {
    console.log(chalk.green(`✅ ${message}`));
  }

  warning(message) {
    console.log(chalk.yellow(`⚠️  ${message}`));
  }

  error(message) {
    console.log(chalk.red(`❌ ${message}`));
  }

  startSpinner(message) {
    this.spinner = ora(message).start();
  }

  succeedSpinner(message) {
    if (this.spinner) {
      this.spinner.succeed(message);
      this.spinner = null;
    }
  }

  failSpinner(message) {
    if (this.spinner) {
      this.spinner.fail(message);
      this.spinner = null;
    }
  }
  
  // --- INI FUNGSI BARU ANTI-NYANGKUT ---
  warnSpinner(message) {
    if (this.spinner) {
      this.spinner.warn(message); // Pake fungsi .warn() bawaan 'ora'
      this.spinner = null;
    } else {
      // Kalo spinner gak nyala, yaudah, tampil Pake warning biasa
      this.warning(message);
    }
  }
}

export const logger = new Logger();
