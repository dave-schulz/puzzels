/** Shared QWERTY rows for letter-based puzzles (NL latin alphabet for now). */
export const QWERTY_ROWS: string[][] = [
  [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
  ],
  [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
  ],
  [
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
  ],
]

export function isLatinLetterKey(key: string): boolean {
  return /^[a-z]$/i.test(key)
}

export function normalizeLetterKey(key: string): string | null {
  if (!isLatinLetterKey(key)) {
    return null
  }

  return key.toLowerCase()
}
