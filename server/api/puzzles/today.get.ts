import type { WordlePuzzle } from '#shared/wordle/types'
import { getAmsterdamDate } from '#shared/game/date'

export default defineEventHandler(async (): Promise<{
  id: string
  date: string
  title: string
  puzzle: WordlePuzzle
}> => {
  const date = getAmsterdamDate()

  const daily = await prisma.dailyPuzzle.findFirst({
    where: {
      date,
      type: 'WORDLE',
      sortOrder: 0,
    },
    include: {
      wordle: true,
    },
  })

  if (!daily?.wordle) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Geen Wordle voor vandaag gevonden. Draai eerst de database-seed.',
    })
  }

  const allowedWords = (
    await prisma.wordleDictionaryEntry.findMany({
      select: {
        word: true,
      },
      orderBy: {
        word: 'asc',
      },
    })
  ).map(entry => entry.word)

  return {
    id: daily.id,
    date: daily.date,
    title: daily.title,
    puzzle: {
      word: daily.wordle.word,
      wordLength: daily.wordle.wordLength,
      maxAttempts: daily.wordle.maxAttempts,
      allowedWords,
    },
  }
})
