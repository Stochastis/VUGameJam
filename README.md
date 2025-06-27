# Game Jam Github Guidelines

Sup, guys! Here's a quick guide to keep us moving fast **without breaking `main`**.

## TL;DR Workflow

- Work in your **own branch** (e.g., `feature-movement`, `sound-fx`, `jam-alex-level1`, `bugfix`, `usernameDev`, etc.)
- When you're ready to merge into `main`:
  1. Open a **pull request** to `main`
  2. Do a quick review and approval (kinda like a last-minute self-check)
  3. Use **Squash and Merge** when merging to keep history clean
  4. Consider deleting your branch after you've tested your changes in main and verified that you're new code is working and didn't break something else. Not necessary, but it might be good to keep things clean.

## Main Branch Rules

- ✅ Pull requests are **required** to merge into `main` (but only require yourself to approve it unless you want someone else to look at it)
- ❌ You can't push directly to `main`
- ✅ You can still freely push to your own branches
- ✅ You can merge your PR after **1 teammate approves it** (this teammate can be yourself)

## Tips

- **Keep commits small, meaningful, and regular** in your own branch. This makes it easier to backtrack/debug and also keeps your progress saved.
- Conflicts? Try `git pull origin main` on your branch before merging to grab the latest code in case it's been updated since you made your branch.

## Recommended Branch Naming (not really important for a game jam, but might be useful)

- `feature/player-jump`
- `fix/audio-loop`
- `level/jungle-scene`
- `yourname-whatever`

---

Thanks for listening to my TED-talk.
