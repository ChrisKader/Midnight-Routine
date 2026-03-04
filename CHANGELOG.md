# Midnight Routine

## [v12.0.13](https://github.com/LoyalFTW/Midnight-Routine/tree/v12.0.13) (2026-03-04)
[Full Changelog](https://github.com/LoyalFTW/Midnight-Routine/compare/v12.0.12...v12.0.13) [Previous Releases](https://github.com/LoyalFTW/Midnight-Routine/releases)

### Fixed
- **Rares frame not updating on kill** — `Scan` was never calling `RefreshRares`, so killing a rare updated the quest flag but the frame stayed stale until the next zone change or manual toggle; `Scan` now always calls `RefreshRares` and `RefreshRenown` after running
- **Unnecessary refreshes when frames are hidden** — `RefreshRaresFrame` and `RefreshRenownFrame` now early-return if their frame is not currently shown, preventing wasted work on every scan

---

## [v12.0.12](https://github.com/LoyalFTW/Midnight-Routine/tree/v12.0.12) (2026-03-04)
[Full Changelog](https://github.com/LoyalFTW/Midnight-Routine/compare/v12.0.11...v12.0.12) [Previous Releases](https://github.com/LoyalFTW/Midnight-Routine/releases)

### Added
- **Rares Frame toggle in Options panel** — "Open Rares Window" checkbox added under a new RARES FRAME section, matching the existing Renown Tracker layout
- **Rares Frame in Welcome screen** — Rares window can now be enabled during first-time setup alongside the Renown window, with its own styled panel and description
- **`EnsureRenownShown` / `EnsureRaresShown`** — new internal functions that show and refresh the respective frames without toggling them off, used on all world entry events

### Fixed
- **Rares frame disappearing on zone change / teleport** — `OnEnteringWorld` was calling `ToggleRares` which would hide the frame if it was already visible; now calls `EnsureRaresShown` which only ever shows or rebuilds
- **Renown frame disappearing on zone change / teleport** — same root cause as above; `OnEnteringWorld` now calls `EnsureRenownShown` instead of `ToggleRenown`

### Changed
- **Event system cleanup** — all eligible events converted to `RegisterBucketEvent` to reduce redundant handler calls:
  - `CHALLENGE_MODE_COMPLETED` and `WEEKLY_REWARDS_UPDATE` grouped into a shared vault bucket (1s)
  - `MAJOR_FACTION_RENOWN_LEVEL_CHANGED` folded into the existing renown bucket alongside `UPDATE_FACTION` and `COMBAT_TEXT_UPDATE`
  - `AREA_POIS_UPDATED` merged into the main Scan bucket (was a separate 2s bucket, now 1s with the rest)
  - `UNIT_SPELLCAST_SUCCEEDED`, `ENCOUNTER_END`, and `PLAYER_ENTERING_WORLD` kept as direct `RegisterEvent` calls (require immediate or per-arg handling)
- **All comments removed** from addon Lua source files — libs untouched

---

## [v12.0.11](https://github.com/LoyalFTW/Midnight-Routine/tree/v12.0.11) (2026-03-03)
[Full Changelog](https://github.com/LoyalFTW/Midnight-Routine/compare/v12.0.10...v12.0.11) [Previous Releases](https://github.com/LoyalFTW/Midnight-Routine/releases)

- Remove comment for resize dragger
    Removed comment about resize dragger in UI.lua.
- Merge pull request #1 from fostot/feature/height-option-and-resize-handle
    Add HEIGHT option and drag-to-resize handle
- Add HEIGHT option and drag-to-resize handle
    - Add a HEIGHT slider to the Options panel (between WIDTH and FONT SIZE)
      allowing users to set a fixed frame height (100-800px, step 10)
    - Frame now uses the stored height instead of auto-sizing to content,
      letting content scroll when it overflows
    - Add a resize grip in the bottom-right corner of the main frame using
      the standard WoW chat resize grabber texture
    - Dragging the grip adjusts both width and height in real-time, and on
      release saves the new values to the database (updating the config
      sliders if the Options panel is open)
    - Resize grip respects Lock Frame (disabled when locked) and hides
      when the frame is minimized
