# Upwork Recruiter Skill for OpenClaw

## Trigger
This skill runs automatically every 2 hours AND on-demand when user says "check upwork"

## Job ID Reference
Store the Upwork job ID after posting: `UPWORK_JOB_ID={paste_your_job_id_here}`

## Primary Objectives
1. Monitor for new proposals on the React Developer job posting
2. Screen candidates against technical criteria
3. Message qualified candidates with screening questions
4. Score and rank responses
5. Alert user for final hiring decisions

## Execution Flow

### Step 1: Fetch New Proposals
```bash
# Log into Upwork (use stored credentials)
# Navigate to job posting: UPWORK_JOB_ID
# Fetch all proposals submitted in last 2 hours
# Store in proposals_data.json
```

### Step 2: Initial Screening (Auto-filter)
For each proposal, check:

**REQUIRED (Must have ALL):**
- ✅ React experience >= 5 years (mentioned in proposal or profile)
- ✅ TypeScript mentioned in skills or proposal
- ✅ Portfolio link provided (GitHub, personal site, or Upwork portfolio)
- ✅ Hourly rate <= $80/hr OR fixed price <= $5,000
- ✅ Available >= 30 hours/week (check availability status)
- ✅ Proposal length >= 100 words (shows effort, not spam)

**STRONG PREFERENCE (Bonus points):**
- ⭐ Canvas/WebGL/game dev mentioned (+2 points)
- ⭐ Animation library experience (GSAP, Framer, React Spring) (+1 point)
- ⭐ GitHub with visible React projects (+2 points)
- ⭐ 100% job success score on Upwork (+1 point)
- ⭐ Top Rated or Top Rated Plus badge (+1 point)

**AUTO-REJECT if:**
- ❌ Generic copy-paste proposal (check for template language)
- ❌ No portfolio/GitHub link
- ❌ Rate > $100/hr or asks > $6,000
- ❌ Less than 3 years React experience
- ❌ Availability < 20 hours/week
- ❌ Job success score < 80%

### Step 3: Score Candidates (0-10 scale)

**Scoring Algorithm:**
```
Base Score: 5

Experience:
+ 3-5 years React: +1
+ 5-8 years React: +2  
+ 8+ years React: +3

Portfolio Quality:
+ GitHub with 5+ React repos: +2
+ Live demos/deployed projects: +1
+ Game/animation projects visible: +2

Communication:
+ Proposal shows they read requirements: +1
+ Asks intelligent questions: +1
+ Clear, professional writing: +1

Availability:
+ Can start immediately: +1
+ 40+ hours/week available: +1

Pricing:
+ Within budget ($60-75/hr): +1
+ Offers fixed price in range: +1

Reputation:
+ Top Rated Plus: +2
+ Top Rated: +1
+ 100% job success: +1
+ 10+ jobs completed: +1

MAX SCORE: 10
```

**Pass threshold:** >= 7/10

### Step 4: Send Screening Questions (Auto-message candidates scoring >= 7)

**Message Template:**
```
Subject: Technical Screening Questions - Brain Training Game

Hi [NAME],

Thanks for your proposal! Your background looks promising. Before moving forward, I'd like to ask a few technical questions to ensure we're aligned:

1. CANVAS EXPERIENCE:
Have you built anything using HTML5 Canvas before? If yes, please describe the most complex Canvas-based feature you've implemented and any performance challenges you faced.

2. ANIMATION APPROACH:
How would you approach animating a 3D isometric block that needs to "pop in" when rendered? What animation library would you use and why?

3. GAME LOOP ARCHITECTURE:
For a game that needs to run at 60fps with moving objects (like our Asteroid Sorting game), how would you structure the game loop using React? Would you use requestAnimationFrame, intervals, or another approach?

4. TESTING GAMES:
What's your approach to testing game logic? Have you written tests for interactive, time-based components before?

5. AVAILABILITY:
Can you confirm you can commit 30-40 hours/week starting immediately? What's your typical working timezone?

6. CODE SAMPLE:
Please share a link to one React project you're most proud of (GitHub preferred). What was the most challenging technical problem you solved in that project?

Please respond within 48 hours. Looking forward to your answers!

Best,
[USER_NAME]
```

### Step 5: Evaluate Responses

When candidate responds, analyze their answers:

**Red Flags (Auto-lower score by -2 each):**
- ❌ No Canvas experience at all
- ❌ Vague, generic answers
- ❌ Can't describe specific technical approaches
- ❌ Doesn't answer all questions
- ❌ Takes > 48 hours to respond

**Green Flags (Boost score +1 each):**
- ✅ Detailed Canvas experience with specifics
- ✅ Mentions performance optimization (memoization, RAF throttling, etc.)
- ✅ Shows understanding of React + imperative Canvas mixing
- ✅ Has written tests for interactive components
- ✅ Provides thoughtful code sample with explanations
- ✅ Responds within 24 hours

### Step 6: Generate Candidate Report

**Daily at 9 AM, send to user via Telegram:**
```
🎯 UPWORK RECRUITING UPDATE

📊 PROPOSALS:
- Total received: 12
- Auto-rejected: 7 (didn't meet criteria)
- Screening in progress: 3
- Awaiting responses: 2

⭐ TOP CANDIDATES:

#1 - Sarah Chen (Score: 9.5/10) ⭐ STRONG RECOMMEND
- 8 years React + TypeScript
- Canvas game portfolio: github.com/sarach/canvas-games
- Top Rated Plus, 100% job success
- Rate: $70/hr, available 40 hrs/week
- RESPONDED to screening questions (excellent answers)
- Key strength: Built 3 Canvas-based games before
- Question: Wants to know about design handoff process

#2 - Alex Kumar (Score: 8/10) ✅ GOOD FIT
- 6 years React, TypeScript expert
- Strong portfolio but no game dev
- Top Rated, 95% job success
- Rate: $65/hr, available 35 hrs/week
- AWAITING response to screening questions
- Sent questions 18 hours ago

#3 - Team "WebMasters" (Score: 6.5/10) ⚠️ AGENCY
- Agency with 4 developers
- Mixed experience levels
- Rate: $75/hr, claims 80 hrs/week availability
- Concern: May outsource or split work
- Auto-rejected due to agency model

📋 ACTIONS NEEDED:
1. URGENT: Respond to Sarah's question about design handoff
2. Consider interviewing Sarah (scheduled call?)
3. Wait for Alex's screening response (due in 30 hours)

💬 SUGGESTED NEXT MESSAGE TO SARAH:
"Hi Sarah, great answers! For design handoff, we'll provide Figma files with exported assets (SVG, PNG) and a design system. The designer will be available for questions during development. Would you like to schedule a quick 15-min call to discuss the project timeline?"

[APPROVE] [EDIT MESSAGE] [WAIT]
```

### Step 7: Interview Coordination (If user approves)

**When user says "Schedule call with Sarah":**

Auto-send message:
```
Hi Sarah,

I'd love to schedule a brief call to discuss the project. 

My availability this week:
- Tuesday 2-4pm EST
- Wednesday 10am-12pm EST
- Thursday 3-5pm EST

Please let me know what works for you. We can use Zoom, Google Meet, or Skype - your preference.

Looking forward to chatting!
```

**Prepare interview guide for user:**
```
📞 INTERVIEW GUIDE - Sarah Chen

⏰ DURATION: 15 minutes

🎯 KEY QUESTIONS:
1. Walk me through how you'd build the Block Counting game
   (Looking for: isometric math, Canvas rendering, performance considerations)

2. How do you handle state management for 12 separate games?
   (Looking for: Zustand knowledge, modular architecture understanding)

3. What's your testing strategy for interactive/timed games?
   (Looking for: Experience with game logic testing, mocking timers)

4. Can you start this week? Timeline concerns?
   (Confirm 30-40 hrs/week commitment)

5. Questions for me?
   (Assess communication style, thoughtfulness)

✅ GREEN FLAGS:
- Asks about specs/documentation (we have it!)
- Mentions performance early
- Wants to see design mockups
- Asks about testing expectations

❌ RED FLAGS:
- Vague technical answers
- Overpromises timeline
- No questions (shows lack of interest)
- Unclear about availability

🎬 AFTER CALL:
Send me: [HIRE SARAH] or [PASS - reason]
```

### Step 8: Contract Drafting (If user says "HIRE")

**Auto-generate Upwork contract:**
```
CONTRACT TERMS - React Developer for Brain Training Game

SCOPE:
Build 12 mini-game brain training application per provided specifications.

DELIVERABLES:
1. 12 working mini-games (detailed spec provided)
2. Complete game flow (menu, transitions, results)
3. Test suite (unit + integration tests)
4. Production deployment to Vercel/Netlify
5. Documentation for future maintenance

TIMELINE:
- Week 1: Setup + 3 games working
- Week 2: 4 more games complete (7 total)
- Week 3: Final 5 games complete (12 total)
- Week 4: Testing, bug fixes, deployment

Total: 40-60 hours over 4 weeks

PAYMENT:
Fixed Price: $3,500
OR
Hourly: $70/hr (estimated 50 hours)

Milestones (if fixed price):
1. Setup + 3 games: $875 (25%)
2. 7 games complete: $1,225 (35%)
3. All 12 games: $875 (25%)
4. Testing + deployment: $525 (15%)

TERMS:
- Communication via GitHub issues + Slack/Telegram
- Daily commits expected
- Weekly check-in calls (15 min)
- Code must pass all tests before milestone payment
- 2 rounds of revisions included per milestone

TECHNICAL REQUIREMENTS:
- React 18 + TypeScript (strict mode)
- Zustand for state management
- Vitest for testing
- Code must be documented
- Must follow provided architecture

START DATE: [Within 3 days of acceptance]

[APPROVE CONTRACT] [EDIT] [CANCEL]
```

## Monitoring & Logging

**Store all data in:**
```
/openclaw/projects/brain-game/recruiting/
├── proposals_raw.json          # All proposals received
├── candidates_screened.json    # Scored candidates
├── messages_sent.json          # Tracking outreach
├── responses.json              # Candidate responses
└── daily_reports/
    ├── 2026-02-08.md
    ├── 2026-02-09.md
    └── ...
```

## Error Handling

**If Upwork API fails:**
- Retry 3 times with exponential backoff
- If still failing, notify user: "⚠️ Upwork API down, will retry in 1 hour"

**If candidate link is broken:**
- Note in scoring: "Portfolio link dead (-1 point)"

**If budget exceeded:**
- Alert user immediately: "🚨 Candidate asking $120/hr (exceeds $80 limit)"

## User Commands

User can message OpenClaw:
- `"check upwork"` → Run immediately
- `"upwork status"` → Send latest report
- `"pause upwork"` → Stop auto-checking
- `"resume upwork"` → Resume auto-checking
- `"hire [candidate name]"` → Generate contract
- `"reject all"` → Send polite rejections to pending candidates

## Success Metrics

Track and report monthly:
- Proposals received vs. quality candidates (ratio)
- Time to first qualified candidate
- Response rate to screening questions
- Hired candidates vs. total screened
- Average time from post to hire

---

## INSTALLATION

Save this as: `~/.openclaw/skills/upwork-recruiter.skill`

Then tell OpenClaw:
```
"Install upwork-recruiter skill"
"Set UPWORK_JOB_ID to [your_job_id]"
"Enable auto-run every 2 hours"
"Send reports to Telegram daily at 9am"
```

**DONE. Let it run.**