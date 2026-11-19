#!/bin/zsh
# Write the rest of the book AFK: one fresh Claude session per step (same as /clear between them).
#   ./run_book.sh        run every step, from step 1
#   ./run_book.sh 3      start at step 3
# Logs: build/logs/<step>.log. Stops at the first step whose gates fail; rerun with that step's number.
cd "${0:A:h}"
mkdir -p build/logs

steps=(
  "session 0 of PLAN.md §11 (setup, no chapters). Run the 3 Sonnet transcription agents and do not end your turn until all three have reported and been spot-checked."
  "block 4-6"
  "block 7-8"
  "block 9-11"
  "block 12-14"
  "block 15-18"
  "block 19"
  "block 20-22"
  "block 23-25"
  "block 26-28"
)

afk="AFK run: nobody is watching. Follow PLAN.md §7 and §11. Never ask a question: where a choice is his, take the plan's default and list it in the hand-over. Mark finished chapters drafted, commit each step, push at the end, and finish with the hand-over lines."

start=${1:-1}
for i in {$start..${#steps}}; do
  echo "== step $i: ${steps[$i]}  ($(date +%H:%M))"
  caffeinate -i claude -p "/euclid-book ${steps[$i]} $afk" \
    --permission-mode auto > build/logs/$i.log 2>&1
  if ! make build check >/dev/null 2>&1; then
    echo "!! step $i: gates fail; see build/logs/$i.log, fix, then ./run_book.sh $i"; exit 1
  fi
  tail -15 build/logs/$i.log
done
echo "Book done. Study it with /star-student."
