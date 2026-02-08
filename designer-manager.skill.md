# Designer Management Skill for OpenClaw

## Trigger
- **Daily:** 10:00 AM (check Figma + Dribbble messages)
- **On-Demand:** "check design" or "design status"
- **Real-time:** Figma webhook notifications

## Configuration
```yaml
FIGMA_FILE_ID: "your-figma-file-id"
FIGMA_TOKEN: "figma-personal-access-token"
DRIBBBLE_USERNAME: "designer-username"
DESIGNER_EMAIL: "designer@email.com"
```

---

## PRIMARY OBJECTIVES

1. Monitor Figma file for updates
2. Review designs against specifications
3. Check accessibility compliance
4. Verify asset export quality
5. Communicate feedback to designer
6. Track deliverables against timeline
7. Coordinate with developer for implementation

---

## EXECUTION FLOW

### Step 1: Monitor Figma (Daily + Webhook)

**Check for changes:**
```javascript
// Connect to Figma API
const figma = new FigmaAPI(FIGMA_TOKEN);
const file = await figma.getFile(FIGMA_FILE_ID);

// Track changes since last check
const changes = {
  pages_added: [],
  pages_modified: [],
  components_added: [],
  assets_exported: [],
  comments_new: []
};

// Store version history
saveVersion({
  timestamp: Date.now(),
  version: file.version,
  changes: changes
});
```

**What to track:**
- New artboards/frames created
- Component updates
- Color/typography changes
- Asset exports
- Designer comments/annotations

---

### Step 2: Automated Design Review

**Design System Compliance:**
```yaml
Check against source.md specifications:

Color Palette:
  ✅ Matches specified color scheme
  ✅ Consistent across all games
  ✅ Proper contrast ratios (WCAG AA)
  ❌ Flag any off-brand colors

Typography:
  ✅ Font family consistent
  ✅ Size scale matches spec
  ✅ Line heights appropriate
  ❌ Flag readability issues

Spacing:
  ✅ Consistent padding/margins
  ✅ Grid system followed
  ❌ Flag alignment issues

Components:
  ✅ Button styles consistent
  ✅ Cards follow template
  ✅ Icons uniform style
  ❌ Flag inconsistencies
```

**Accessibility Audit:**
```javascript
// Auto-check each design
const auditResults = {
  contrast: checkColorContrast(designs),
  textSize: checkMinimumTextSize(designs),
  touchTargets: checkMinimumTapSize(designs),
  colorBlind: simulateColorBlindness(designs)
};

// Generate report
if (auditResults.contrast.failures > 0) {
  flagIssue({
    type: 'accessibility',
    severity: 'high',
    description: `${auditResults.contrast.failures} elements fail contrast requirements`,
    elements: auditResults.contrast.failedElements
  });
}
```

**Asset Quality:**
```yaml
Export Settings Check:
  SVG Icons:
    ✅ Outline mode (not fills)
    ✅ Proper viewBox
    ✅ Clean paths (no unnecessary points)
    ✅ Optimized file size
    
  PNG Sprites:
    ✅ @2x and @3x versions
    ✅ Transparent backgrounds
    ✅ Proper dimensions
    ✅ Compressed
    
  Lottie Animations:
    ✅ JSON format
    ✅ < 100KB file size
    ✅ Smooth framerate
    ✅ Looping configured
```

---

### Step 3: Game-Specific Reviews

**For each of 12 games, verify:**

```markdown
## Block Counting Game Review

### Visual Design ✅
- [x] 3D isometric blocks rendered clearly
- [x] Shadow depth appropriate
- [x] Color differentiation good
- [x] Fits within 800x600 game area

### User Interface ✅
- [x] Timer visible and clear
- [x] Score display prominent
- [x] Input field appropriately sized
- [x] Submit button obvious

### Feedback States ✅
- [x] Correct answer: Green flash + confetti
- [x] Incorrect answer: Red shake
- [x] Timer warning: Yellow pulse at 10s
- [x] Game over: Clear transition

### Mobile Considerations 🟡
- [x] Touch targets >= 44px
- [ ] Text size >= 16px (currently 14px)
- [x] Landscape orientation works
- [x] Portrait orientation works

### Issues Found (2)

**MUST FIX:**
1. Input field text too small (14px → 18px minimum)

**NICE TO HAVE:**
2. Consider adding subtle background animation

**Status:** CHANGES REQUESTED
**ETA:** Designer can fix in < 1 hour
```

---

### Step 4: Daily Designer Report

**Every morning at 10 AM:**

```markdown
# 🎨 DESIGN STATUS REPORT
**Date:** February 8, 2026 (Week 2, Day 4)

---

## 📊 PROGRESS OVERVIEW

**Deliverables:**
```
Design System:    ████████████████████ 100% ✅
Character Design: ████████████████████ 100% ✅
Games 1-6:        ████████████████████ 100% ✅
Games 7-12:       ████████████░░░░░░░░  60% 🚧
UI Screens:       █████████████░░░░░░░  65% 🚧
Animations:       ██████░░░░░░░░░░░░░░  30% 🚧
```

**Timeline:** Day 18/28 • 64% elapsed, 73% complete • ✅ AHEAD OF SCHEDULE

---

## ✅ COMPLETED THIS WEEK

### Games Designed (3 new)
4. ✅ Asteroid Sorting - Approved, assets exported
5. ✅ Hexagon Path - Approved, assets exported
6. ✅ Scale Balance - In review (feedback pending)

### Animations
- ✅ Button press animation (Lottie ready)
- ✅ Confetti effect (3 variations)
- ✅ Character celebration dance

---

## 🚧 IN PROGRESS

### Current Work
- Scale Balance revisions (estimated 2 hours)
- Object Sequence game (50% complete)
- Puzzle Pieces game (starting today)

### Figma Activity (Last 24h)
- 47 changes made
- 12 new artboards
- 23 components updated
- 8 assets exported

---

## 🎨 DESIGN REVIEW FINDINGS

### Game #6 - Scale Balance (Needs Minor Changes)

**Overall Score:** 8.5/10 ✅ Strong work

**Strengths:**
- Clean, intuitive layout
- Scale animation looks great
- Color coding for weight clarity
- Accessible contrast ratios

**Changes Needed (2):**

1. **Input Area Too Small** (Priority: High)
   - Current: Input boxes 120px wide
   - Required: 180px minimum for 3-digit numbers
   - Fix time: ~15 minutes

2. **Missing State** (Priority: Medium)
   - Need "checking answer" loading state
   - Designer oversight, quick add
   - Fix time: ~30 minutes

**Mockup Comparison:**
- [View Figma Frame](link)
- [See Feedback Annotations](link)

**Status:** Requested changes via Dribbble message
**ETA:** Designer responsive, expects update by 2 PM

---

## 📋 UPCOMING THIS WEEK

### To Design (Remaining 6 games)
- [ ] Object Sequence (50% done, due Tomorrow)
- [ ] Puzzle Pieces (starting today, due Friday)
- [ ] Pattern Match (starting Fri, due Monday)
- [ ] Number Sequence (due Tuesday)
- [ ] Visual Transform (due Wednesday)
- [ ] Sushi Memory (due Thursday)

### Animations Queue
- [ ] Score increment (due Friday)
- [ ] Screen transitions (due Monday)
- [ ] Timer warning pulse (due Tuesday)

---

## 🎯 QUALITY METRICS

### Design System Compliance
```
Color Usage:      100% ✅ (all colors from palette)
Typography:       100% ✅ (system followed)
Component Usage:   95% ✅ (5% custom components approved)
Spacing:           98% ✅ (minor alignment tweaks needed)
```

### Accessibility Score
```
Color Contrast:    96% ✅ (2 elements flagged, fixing)
Text Size:         92% 🟡 (3 instances below minimum)
Touch Targets:    100% ✅ (all >= 44px)
Color Blind Safe: 100% ✅ (tested all modes)
```

### Asset Quality
```
SVG Optimization:  98% ✅ (well optimized)
PNG Compression:   95% ✅ (good compression)
Lottie File Size:  100% ✅ (all < 100KB)
Export Settings:   100% ✅ (configured correctly)
```

---

## 💬 DESIGNER COMMUNICATION

### Messages Sent Today

**10:05 AM - Feedback on Scale Balance:**
```
Hi [Designer Name],

Great work on the Scale Balance game! Really love the 
animation and color coding. Two small tweaks needed:

1. Input boxes: Please increase width to 180px 
   (need room for 3-digit numbers)

2. Loading state: Add a "checking..." state between 
   submit and result display

Should be quick fixes. Can you update by 2 PM today?

Everything else looks perfect - approved! 🎉

Assets exported: https://figma.com/file/xyz/exports
```

**Designer Reply (10:22 AM):**
```
Absolutely! Making those changes now. Should have 
updated version in Figma within the hour. Will ping 
you when ready for re-review.

Also started on Object Sequence - should have initial 
version by EOD for your feedback.
```

---

## 🔄 HANDOFF TO DEVELOPER

### Assets Ready for Implementation

**Games Ready (6):**
1. ✅ Block Counting - [Download Assets](link)
2. ✅ Memory Cards - [Download Assets](link)
3. ✅ Quick Math - [Download Assets](link)
4. ✅ Asteroid Sorting - [Download Assets](link)
5. ✅ Hexagon Path - [Download Assets](link)
6. 🟡 Scale Balance - Awaiting revisions (ETA: 2 PM)

**Asset Package Includes:**
- SVG icons (all optimized)
- PNG sprites (@2x, @3x)
- Lottie animations (JSON)
- Style tokens (CSS variables)
- Component specs (measurements, spacing)

**Developer Notified:**
Sent Slack message to dev with asset links and implementation notes.

---

## ⚠️ RISKS & ISSUES

### 🟢 NO BLOCKERS

### 🟡 MINOR CONCERNS (1)

**Timeline Pressure:**
- 6 games still to design in 10 days
- Current pace: ~1 game per 2 days
- Math: 6 games × 2 days = 12 days needed
- ⚠️ 2 days over if pace continues

**Mitigation:**
- Games 7-12 are simpler (established patterns)
- Designer confident in timeline
- Built-in buffer: Animations can slip if needed

**Action:** Monitor daily, flag if falling behind

---

## 🎬 ACTIONS NEEDED FROM YOU

### URGENT (Today)
*None - all clear! Designer is unblocked and on schedule*

### THIS WEEK
1. **Review Object Sequence** (Expected: Tonight)
   - Designer sending initial version EOD
   - Quick review turnaround helps maintain pace

2. **Approve Scale Balance revisions** (Expected: This afternoon)
   - Quick fixes, should be fast approval

---

## 📊 BUDGET TRACKING

```
Designer Contract: $2,800 (fixed price)

Milestones:
✅ Design System + Character: $840 (30%) - PAID
✅ Games 1-6 Complete: $1,120 (40%) - PAID
🚧 Games 7-12 + Screens: $560 (20%) - In Progress
⏳ Animations + Handoff: $280 (10%) - Pending

Paid to Date: $1,960 / $2,800 (70%)
Work Complete: 73%

Status: ✅ ON BUDGET
```

---

## 📎 QUICK LINKS

- [Figma File](link)
- [Asset Export Folder](link)
- [Design System Documentation](link)
- [Accessibility Report](link)
- [Dribbble Messages](link)

---

## 🤖 AUTOMATION STATUS

**Monitoring:**
- Checking Figma every 2 hours
- Webhook notifications enabled
- Auto-reviewing all changes
- Tracking version history

**Next Actions:**
- 2:00 PM: Check for Scale Balance update
- 6:00 PM: Review Object Sequence (if delivered)
- Tomorrow 10 AM: Next daily report

**All systems operational** ✅

---

*Generated by OpenClaw Design Manager*
*Questions? Message: "design help"*
```

---

### Step 5: Asset Preparation for Developer

**When design approved, auto-prepare assets:**

```bash
# Export from Figma
1. Download all SVGs
2. Download all PNGs (@2x, @3x)
3. Download Lottie animations
4. Extract design tokens

# Optimize Assets
svgo *.svg --multipass --pretty
pngquant --quality=80-95 *.png
gzip *.json

# Organize for Developer
/assets/
  /icons/
    block.svg
    card.svg
    ...
  /sprites/
    asteroid@2x.png
    asteroid@3x.png
    ...
  /animations/
    confetti.json
    celebration.json
    ...
  /tokens/
    colors.json
    typography.json
    spacing.json

# Generate Implementation Guide
create_asset_guide.md with:
- File locations
- Usage instructions
- Component mapping
- Animation parameters
```

---

## USER COMMANDS

```
"design status" → Latest report
"approve design [game]" → Approve specific game
"request changes [game]" → Flag issues
"design help" → Show available commands
"check figma" → Manual Figma check
"export assets [game]" → Prepare asset package
"designer message" → Draft message to designer
```

---

## ERROR HANDLING

```yaml
If Figma API fails:
  - Retry 3 times
  - Notify user if persistent
  - Fall back to manual check

If designer misses deadline:
  - Auto-send gentle reminder at deadline
  - Escalate to user if 24h overdue
  - Suggest timeline adjustment

If accessibility issues found:
  - Flag as high priority
  - Provide specific fix guidance
  - Block approval until resolved
```

---

## INSTALLATION

```bash
# Save as ~/.openclaw/skills/designer-manager.skill

# Configure
openclaw config set FIGMA_FILE_ID "your-file-id"
openclaw config set FIGMA_TOKEN "figd_xxxx"

# Enable
openclaw skill enable designer-manager
openclaw schedule designer-manager "0 10 * * *"

# Test
openclaw run designer-manager test
```

**DONE. Design process fully automated.**