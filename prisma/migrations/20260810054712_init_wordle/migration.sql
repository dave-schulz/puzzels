-- CreateEnum
CREATE TYPE "PuzzleType" AS ENUM ('WORDLE', 'CONNECTIONS');

-- CreateTable
CREATE TABLE "DailyPuzzle" (
    "id" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "type" "PuzzleType" NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DailyPuzzle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WordlePuzzle" (
    "id" TEXT NOT NULL,
    "dailyPuzzleId" TEXT NOT NULL,
    "word" TEXT NOT NULL,
    "wordLength" INTEGER NOT NULL DEFAULT 5,
    "maxAttempts" INTEGER NOT NULL DEFAULT 6,

    CONSTRAINT "WordlePuzzle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WordleDictionaryEntry" (
    "word" TEXT NOT NULL,
    "isSolution" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "WordleDictionaryEntry_pkey" PRIMARY KEY ("word")
);

-- CreateIndex
CREATE INDEX "DailyPuzzle_date_idx" ON "DailyPuzzle"("date");

-- CreateIndex
CREATE UNIQUE INDEX "DailyPuzzle_date_type_sortOrder_key" ON "DailyPuzzle"("date", "type", "sortOrder");

-- CreateIndex
CREATE UNIQUE INDEX "WordlePuzzle_dailyPuzzleId_key" ON "WordlePuzzle"("dailyPuzzleId");

-- AddForeignKey
ALTER TABLE "WordlePuzzle" ADD CONSTRAINT "WordlePuzzle_dailyPuzzleId_fkey" FOREIGN KEY ("dailyPuzzleId") REFERENCES "DailyPuzzle"("id") ON DELETE CASCADE ON UPDATE CASCADE;
