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

## Recommended Branch Naming and Versioning
### Versioning
- X.X.X format.
- Each time a branch is merged into main, the version number and changelog should be updated.
- First X is for major changes (new mechanics/systems, overhauls, new levels, etc.)
- Second X is for minor changes (adding small features or moderate/small changes to existing ones)
- Third X is for patches (bug fixes, small graphics updates, changed sfx, tweaking values, etc.)

### Example Branch Prefix Types
- feat: A new feature (major or minor)
- refactor: Non-overhaul code refactoring or style changes (minor or patch)
- art: Graphical/audio updates (minor or patch)
- fix: Bug fixes (patch)
- tweak: Tweaking values (patch)
- perf: Performance improvements (patch)
- build: Builds/deploys/updates (patch)
- docs: Updating docs or comments (patch)
- chore: Maintenance tasks (patch)

### Example Branches
- `feature/grid-system` (major)
- `fix/audio-looping-bug` (patch)
- `feat/outer-walls` (major)
- `art-zombie-sprites` (minor)
- `refactor-state-machines` (minor)
- `tweak-changing-wave-times` (patch)

---

Thanks for listening to my TED-talk.
