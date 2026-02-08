# GitHub Project Manager Skill for OpenClaw

## Trigger
- **Automatic:** Daily at 9:00 AM
- **On-Demand:** When user says "git status" or "check github"
- **Real-time:** On any new commit, PR, or issue

## Repository Setup
```
GITHUB_REPO="yourusername/brain-training-game"
GITHUB_TOKEN="ghp_xxxxxxxxxxxx"  # Personal access token with repo scope
```

## Primary Objectives
1. Monitor all development activity 24/7
2. Run automated testing on every commit
3. Review code quality and flag issues
4. Manage PRs (review, test, recommend merge/reject)
5. Track progress against milestones
6. Generate daily status reports
7. Coordinate developer communication

---

## EXECUTION FLOW

### Step 1: Monitor Repository (Real-time)

**Watch for:**
- New commits pushed
- Pull requests opened/updated
- Issues created/commented
- Branch changes
- Merge conflicts

**Action on each event:**
```bash
# On new commit
1. Pull latest code: git pull origin main
2. Run test suite: npm test
3. Run build: npm run build
4. Check types: npm run type-check
5. Run linter: npm run lint
6. Log results

# On new PR
1. Checkout PR branch
2. Run full test suite
3. Analyze code changes (diff review)
4. Check against project specs
5. Post automated review comment
6. Notify user if action needed

# On new issue
1. Analyze issue description
2. Categorize (bug, feature, question)
3. Check if related to existing code
4. Suggest potential causes (if bug)
5. Assign priority
6. Notify developer if urgent
```

---

### Step 2: Automated Code Review (On every PR)

**Review Checklist:**

**TypeScript Quality:**
```typescript
// Check for:
✅ No 'any' types (strict mode compliance)
✅ All props interfaces defined
✅ Return types on functions
✅ Proper null/undefined handling
❌ Unused imports or variables
❌ Console.logs (except intentional logging)
❌ Commented-out code blocks
```

**React Best Practices:**
```typescript
✅ useCallback for event handlers
✅ useMemo for expensive calculations
✅ Proper dependency arrays in useEffect
✅ Keys on list items
❌ Inline function definitions in JSX
❌ Missing cleanup in useEffect
❌ setState in render (infinite loops)
```

**Game-Specific Checks:**
```typescript
✅ Timer cleanup on component unmount
✅ Canvas context disposal
✅ Animation frame cancellation
✅ Event listener removal
❌ Memory leaks (uncleaned intervals/timeouts)
❌ Missing error boundaries
❌ Performance issues (60fps violations)
```

**Testing Coverage:**
```bash
✅ Game logic has unit tests
✅ Score calculations tested
✅ Timer mechanics tested
✅ Edge cases covered
❌ Coverage < 80%
❌ Missing integration tests
```

**Auto-comment on PR:**
```markdown
## 🤖 Automated Code Review

### ✅ Passing Checks
- TypeScript compilation successful
- All 47 tests passing
- Linter passed (0 errors, 0 warnings)
- Build successful (bundle size: 245KB)

### 📊 Test Coverage
- Overall: 85% (+3% from main)
- New code: 92%
- Untested: `src/games/QuickMath.tsx` lines 45-52

### 🎯 Code Quality Score: 8.5/10

**Strengths:**
- Clean component architecture
- Proper TypeScript usage
- Good test coverage
- Performance optimized (no unnecessary re-renders)

### ⚠️ Issues Found (3)

**BLOCKER - Must Fix:**
1. **Memory leak in Asteroid Game (line 87)**
   ```typescript
   // Missing cleanup
   useEffect(() => {
     const interval = setInterval(updateAsteroids, 16);
     // ❌ No return cleanup function
   }, []);
   
   // Should be:
   return () => clearInterval(interval);
   ```

**MINOR - Should Fix:**
2. **Performance concern (line 123)**
   Inline arrow function in render (creates new function every render)
   Suggest: Extract to useCallback
   
3. **Type safety (line 201)**
   Using `as any` - can we type this properly?

### 📋 Recommendations
- [ ] Fix memory leak (blocker)
- [ ] Add cleanup test for asteroid game
- [ ] Consider extracting magic numbers to constants
- [ ] Document the scoring algorithm

### 🎬 Next Steps
After fixes, this PR will be **APPROVED FOR MERGE** ✅

Current Status: **CHANGES REQUESTED**

---
*Automated review by OpenClaw • [Report issue](link)*
```

---

### Step 3: Daily Status Report (9:00 AM)

**Generate comprehensive report:**

```markdown
# 🧠 BRAIN GAME PROJECT - Daily Status Report
**Date:** February 8, 2026 (Day 14 of 28)
**Timeline:** 50% elapsed, 40% complete

---

## 📊 OVERVIEW

**Progress:**
```
████████████░░░░░░░░░░░░ 40%

Games Complete: 4/12 (33%)
Tests Passing: 87/112 (78%)
Code Coverage: 81%
```

**Health:** 🟡 ON TRACK (minor concerns)

---

## ✅ COMPLETED (Since last report)

### Games Shipped
1. ✅ **Block Counting** - Fully tested, deployed
2. ✅ **Memory Cards** - Fully tested, deployed
3. ✅ **Quick Math** - Fully tested, deployed
4. ✅ **Asteroid Sorting** - In QA (PR #18)

### Infrastructure
- ✅ CI/CD pipeline configured
- ✅ Staging environment live
- ✅ Test coverage reporting
- ✅ Performance monitoring setup

---

## 🚧 IN PROGRESS

### Active Work (Developer)
**Current Branch:** `feature/hexagon-path`
**Last Commit:** 2 hours ago
**Status:** SVG hexagon grid rendering complete

**Progress:**
- Hexagon grid layout ✅
- Path generation algorithm ✅
- Path display logic 🚧 (In progress)
- Path validation ⏳ (Not started)
- Testing ⏳ (Not started)

**ETA:** Friday EOD (48 hours)

### Open PRs (Needs Review)
**PR #18 - Asteroid Sorting Game**
- Created: 6 hours ago
- Status: Tests passing ✅
- Code review: Auto-approved ✅
- **ACTION NEEDED:** Your approval to merge

---

## ⚠️ ISSUES & BLOCKERS

### 🔴 BLOCKERS (0)
*None - all clear!*

### 🟡 CONCERNS (2)

**1. Timer Accuracy Issue (Issue #23)**
- Reported: Yesterday
- Severity: Minor
- Impact: Timer drifts by ~200ms after 30 seconds
- Status: Developer investigating
- Expected fix: Today

**2. Mobile Performance (Issue #24)**
- Reported: This morning
- Severity: Minor
- Impact: 45fps on iPhone SE (target: 60fps)
- Status: Profiling in progress
- Expected fix: Next week

### 🟢 RESOLVED (1)
- ✅ Memory leak in Asteroid game (fixed in PR #17)

---

## 📈 METRICS

### Development Velocity
```
Week 1: 2 games completed
Week 2: 2 games completed
Current pace: 1 game per 3.5 days

At this pace:
- Remaining 8 games: ~28 days
- ⚠️ 2 weeks over budget

Recommendation: Increase velocity or adjust scope
```

### Code Quality
```
Test Coverage:    81% ✅ (target: 80%)
TypeScript Strict: 100% ✅
Linter Warnings:   0 ✅
Bundle Size:       287KB 🟡 (target: 250KB)
Performance:       58fps avg 🟡 (target: 60fps)
```

### Git Activity (Last 24h)
- Commits: 8
- Files changed: 23
- Lines added: +847
- Lines removed: -123
- PRs opened: 1
- Issues closed: 1

---

## 🎯 UPCOMING MILESTONES

### This Week (By Friday)
- [ ] Merge PR #18 (Asteroid Sorting)
- [ ] Complete Hexagon Path game
- [ ] Start Scale Balance game
- [ ] Fix timer accuracy issue
- [ ] Target: 5/12 games complete

### Next Week (Days 15-21)
- [ ] Complete 3 more games (8/12 total)
- [ ] Mobile performance optimization
- [ ] Code cleanup / refactoring sprint
- [ ] Designer delivers remaining assets

---

## 💬 DEVELOPER COMMUNICATION

### Messages Sent
```
Yesterday 6:42 PM:
"Great progress on Asteroid game! Quick question about the 
collision detection - are we using pixel-perfect or radius-based? 
Radius should be fine for this use case and much more performant."

Developer Response (7:15 PM):
"Using radius-based. Set hitbox to 80% of visual size for more 
forgiving gameplay. Testing feels good. Ready for review?"

Action: Approved for review
```

### Pending Questions
*None - developer is unblocked*

---

## 💰 BUDGET TRACKING

```
Developer Hours:
Week 1: 42 hours ($2,940)
Week 2: 38 hours ($2,660)
Total: 80 hours / ~100 estimated

Budget Used: $5,600 / $7,000 (80%)
Timeline: 50% complete
⚠️ Trending 30% over budget

Recommendation: 
- Option A: Reduce scope (10 games instead of 12)
- Option B: Add $2K to budget
- Option C: Accept deadline slip by 1-2 weeks
```

---

## 🎬 ACTIONS NEEDED FROM YOU

### URGENT (Today)
1. **Approve PR #18** - Asteroid game ready to merge
   - [View PR](link)
   - [APPROVE] [REQUEST CHANGES] [COMMENT]

### THIS WEEK
2. **Budget decision** - Trending over, adjust plan?
3. **Review staging build** - Test games yourself
   - Staging: https://brain-game-staging.vercel.app
   - Credentials: (see secure note)

### LOW PRIORITY
4. **Designer check-in** - They're ahead of schedule 🎉

---

## 📎 QUICK LINKS

- [GitHub Repo](link)
- [Staging Environment](link)
- [Test Coverage Report](link)
- [Performance Metrics](link)
- [Project Board](link)

---

## 🤖 OpenClaw Notes

**Monitoring:**
- Watching 1 repository
- Tracking 4 open issues
- Monitoring 2 active branches
- Running tests every commit

**Next automated actions:**
- Hourly: Check for new commits
- On commit: Run test suite
- On PR: Auto code review
- Tomorrow 9am: Next daily report

**Health check:** All systems operational ✅

---

*Generated by OpenClaw Project Manager*
*Questions? Message me: "openclaw help"*
```

---

### Step 4: PR Management (Automated Workflow)

**When developer opens PR:**

```yaml
1. IMMEDIATE (within 1 minute):
   - Checkout PR branch locally
   - Run: npm install
   - Run: npm test
   - Run: npm run build
   - Post initial comment: "🤖 Running automated checks..."

2. TESTING (5 minutes):
   - Unit tests
   - Integration tests
   - Visual regression tests (screenshots)
   - Performance tests (lighthouse)
   - Bundle size check
   
3. CODE ANALYSIS (5 minutes):
   - TypeScript compilation
   - Linter checks
   - Unused code detection
   - Complexity analysis
   - Security scan (npm audit)

4. SPEC VALIDATION (10 minutes):
   - Compare against source.md requirements
   - Check all acceptance criteria met
   - Verify game mechanics match spec
   - Test scoring algorithm accuracy
   
5. REVIEW COMMENT (Post results):
   - Summary of all checks
   - Detailed findings
   - Recommendations
   - Approval status

6. NOTIFICATION (Immediate):
   Send to user via Telegram:
   "📬 New PR #X: [title]
   Status: [APPROVED/CHANGES NEEDED]
   [Quick action buttons]"
```

**Auto-merge criteria** (if enabled by user):
```yaml
Auto-merge if ALL true:
- All tests passing ✅
- Coverage >= 80% ✅
- No TypeScript errors ✅
- No linter errors ✅
- Bundle size < 300KB ✅
- Performance score >= 90 ✅
- No security vulnerabilities ✅
- Approved by OpenClaw review ✅

Otherwise: Request user approval
```

---

### Step 5: Issue Triage (Automatic)

**When developer creates issue:**

```markdown
## 🤖 Auto-Triage

**Issue #X:** [Title]
**Created by:** Developer
**Auto-Analysis:**

**Category:** 🐛 Bug
**Severity:** 🟡 Medium
**Priority:** P2 (Should fix this sprint)

**Affected Component:** `src/games/MemoryCards.tsx`
**Potential Cause:** Timer drift due to setInterval accumulation

**Similar Issues:**
- Issue #12 (closed) - Had similar timer problem
- Solution was switching to requestAnimationFrame

**Suggested Fix:**
```typescript
// Replace setInterval with RAF
let lastTime = 0;
const gameLoop = (currentTime) => {
  const deltaTime = currentTime - lastTime;
  if (deltaTime >= 1000) { // 1 second passed
    setTimeLeft(t => t - 1);
    lastTime = currentTime;
  }
  requestAnimationFrame(gameLoop);
};
```

**Assigned to:** Developer
**Due:** This week
**Labels:** bug, timer, needs-testing

---
*Auto-triaged by OpenClaw*
```

---

### Step 6: Performance Monitoring

**Track and alert on:**

```yaml
Performance Thresholds:
  frame_rate:
    target: 60fps
    warning: < 55fps
    alert: < 50fps
    
  bundle_size:
    target: 250KB
    warning: > 300KB
    alert: > 400KB
    
  load_time:
    target: < 2s
    warning: > 3s
    alert: > 5s
    
  memory_usage:
    target: < 100MB
    warning: > 150MB
    alert: > 200MB

Alert Example:
"⚠️ PERFORMANCE ALERT
Bundle size: 315KB (target: 250KB)
Cause: Large Canvas library included
Recommendation: Use dynamic imports for games"
```

---

### Step 7: Developer Unblocking

**When developer comments with question:**

**Developer:** "How should I handle the hexagon click detection? Hexagons don't have perfect rectangular hitboxes."

**OpenClaw analyzes:**
1. Searches codebase for similar patterns
2. Checks our documentation/specs
3. Searches relevant Stack Overflow/GitHub
4. Generates solution with code

**Auto-response:**
```markdown
Great question! For hexagon click detection, use point-in-polygon algorithm:

```typescript
function pointInHexagon(clickX: number, clickY: number, hexCenter: {x: number, y: number}, size: number): boolean {
  // Convert to hex coordinate space
  const dx = clickX - hexCenter.x;
  const dy = clickY - hexCenter.y;
  
  // Hexagon bounds (flat-top orientation)
  const w = size;
  const h = size * Math.sqrt(3) / 2;
  
  // Check if point inside bounding hexagon
  const q2x = Math.abs(dx - hexCenter.x) / w;
  const q2y = Math.abs(dy - hexCenter.y) / h;
  
  return q2x + q2y <= 1;
}

// Usage in your click handler:
canvas.addEventListener('click', (e) => {
  const rect = canvas.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;
  
  hexagons.forEach(hex => {
    if (pointInHexagon(x, y, hex.center, hex.size)) {
      handleHexagonClick(hex);
    }
  });
});
```

This is more accurate than rectangular bounds and performs well.

**Reference:** Similar implementation in [link to similar code in repo]

Need help implementing or have follow-up questions? Let me know!
```

---

## DATA STORAGE

```
/openclaw/projects/brain-game/github/
├── daily_reports/
│   ├── 2026-02-08.md
│   └── 2026-02-09.md
├── pr_reviews/
│   ├── pr-001-review.json
│   └── pr-002-review.json
├── test_results/
│   ├── commit-abc123-results.json
│   └── commit-def456-results.json
├── performance/
│   ├── bundle-sizes.json
│   └── lighthouse-scores.json
└── metrics/
    ├── velocity.json
    ├── code-quality.json
    └── developer-activity.json
```

---

## USER COMMANDS

```
"git status" → Immediate status update
"approve pr 18" → Approve and merge PR #18
"git report" → Send latest full report
"check [game name]" → Run specific game tests
"deploy staging" → Deploy to staging environment
"benchmark" → Run performance tests
"pause github monitoring" → Stop automated checks
"resume github monitoring" → Resume automated checks
```

---

## INSTALLATION

```bash
# Save as ~/.openclaw/skills/github-pm.skill

# Configure:
openclaw config set GITHUB_REPO "username/brain-training-game"
openclaw config set GITHUB_TOKEN "ghp_xxxxx"

# Enable:
openclaw skill enable github-pm
openclaw schedule github-pm "0 9 * * *"  # Daily 9am
openclaw watch github-pm  # Real-time monitoring

# Test:
openclaw run github-pm test
```

**DONE. GitHub is now fully managed.**