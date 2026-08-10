import { DateTime, Duration } from 'luxon'

export const AMSTERDAM_ZONE = 'Europe/Amsterdam'

/** Calendar date YYYY-MM-DD in Europe/Amsterdam. */
export function getAmsterdamDate(date: Date = new Date()): string {
  return DateTime.fromJSDate(date, {
    zone: AMSTERDAM_ZONE,
  }).toISODate()!
}

/** Previous calendar day relative to a YYYY-MM-DD Amsterdam date string. */
export function getPreviousAmsterdamDate(date: string): string {
  return DateTime.fromISO(date, {
    zone: AMSTERDAM_ZONE,
  }).minus({
    days: 1,
  }).toISODate()!
}

export function formatDuration(ms: number): string {
  return Duration.fromMillis(Math.max(0, ms)).toFormat('mm:ss')
}
