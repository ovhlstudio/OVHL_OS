import dayjs from 'dayjs';

export function getTimestamp() {
  return dayjs().format('HHmmss');
}

export function getDateFolder() {
  return dayjs().format('YYYY-MM-DD');
}

export function getFullDateTime() {
  return dayjs().format('YYYY-MM-DD HH:mm:ss');
}

export function formatFileTimestamp() {
  return dayjs().format('YYYYMMDDHHmmss');
}
