import { PrismaPg } from '@prisma/adapter-pg'
import { DateTime } from 'luxon'
import { AMSTERDAM_ZONE } from '../shared/game/date'
import { dutchFiveLetterWords } from './data/dutchWords'
import { PrismaClient, PuzzleType } from './generated/client'
import 'dotenv/config'

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL!,
})
const prisma = new PrismaClient({
  adapter,
})

function uniqueFiveLetterWords(words: string[]): string[] {
  return [
    ...new Set(
      words
        .map(word => word.toLowerCase().trim())
        .filter(word => word.length === 5 && /^[a-z]+$/.test(word)),
    ),
  ].sort()
}

function pickSolutionForDate(date: string, solutions: string[]): string {
  let hash = 0
  for (let i = 0; i < date.length; i++) {
    hash = ((hash << 5) - hash + date.charCodeAt(i)) | 0
  }
  const index = Math.abs(hash) % solutions.length
  return solutions[index]!
}

async function main() {
  const words = uniqueFiveLetterWords(dutchFiveLetterWords)

  if (words.length < 30) {
    throw new Error(`Not enough valid 5-letter words after filtering (${words.length})`)
  }

  await prisma.wordleDictionaryEntry.deleteMany()
  await prisma.wordleDictionaryEntry.createMany({
    data: words.map(word => ({
      word,
      isSolution: true,
    })),
  })

  const today = DateTime.now().setZone(AMSTERDAM_ZONE).toISODate()!
  const word = pickSolutionForDate(today, words)

  await prisma.wordlePuzzle.deleteMany({
    where: {
      dailyPuzzle: {
        date: today,
        type: PuzzleType.WORDLE,
      },
    },
  })
  await prisma.dailyPuzzle.deleteMany({
    where: {
      date: today,
      type: PuzzleType.WORDLE,
    },
  })

  await prisma.dailyPuzzle.create({
    data: {
      date: today,
      type: PuzzleType.WORDLE,
      sortOrder: 0,
      title: 'Woord van vandaag',
      wordle: {
        create: {
          word,
          wordLength: 5,
          maxAttempts: 6,
        },
      },
    },
  })

  console.log(`Seeded ${words.length} dictionary words`)
  console.log(`Today (${today}) solution: ${word}`)
}

main()
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
