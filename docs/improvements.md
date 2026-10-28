# Grocery App – Improvement Ideas & Discussions

This file is used to record ideas, discussions, and planned improvements for the Grocery App.

---

## Current Status

- Basic grocery list is working
- Users can add, check, and delete items
- APK builds automatically via GitHub Actions
- **List is now saved permanently** (using shared_preferences)

---

## Planned Improvements

### High Priority
- [x] Save the list permanently (so it doesn't reset when the app is closed)
- [ ] Add quantity (example: 2x Milk, 1kg Rice)

### Medium Priority
- [ ] Add categories (Fruits, Dairy, Snacks, Household, etc.)
- [ ] Dark mode support
- [ ] Better empty state / animations

### Low Priority / Future Ideas
- [ ] Share the list with others
- [ ] Sort items (alphabetical, by category, bought first)
- [ ] Search / filter items
- [ ] Custom app icon

---

## Discussion Log

### 2026-10-28
- Implemented permanent list saving using `shared_preferences`.
- List now survives app restarts and phone reboots.
- Next suggested focus: Add quantity support.

### 2026-10-24
- App is running well on phone.
- Decided to create this `docs/improvements.md` file to record future ideas and discussions.
- Next possible focus: saving the list so data is not lost when closing the app.

---

## Notes

- Keep ideas short and clear.
- Mark items with `[x]` when completed.
- Add new discussion entries at the top of the Discussion Log section.
