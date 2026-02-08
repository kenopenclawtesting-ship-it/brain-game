# OpenClaw Master Setup Guide
## Complete Installation & Configuration for Brain Training Game Project

**Time to Complete:** 2-3 hours
**Difficulty:** Intermediate (guided step-by-step)

---

## 🎯 WHAT THIS SETUP DOES

By the end, OpenClaw will automatically:
- ✅ Monitor Upwork for proposals every 2 hours
- ✅ Screen candidates and message top prospects
- ✅ Watch GitHub 24/7 for commits, PRs, issues
- ✅ Run automated tests on every code change
- ✅ Review code quality and flag issues
- ✅ Monitor Figma for design updates
- ✅ Check design accessibility and quality
- ✅ Send you daily status reports at 9 AM
- ✅ Alert you immediately for urgent issues
- ✅ Coordinate between developer and designer
- ✅ Track budget and timeline automatically

**Your involvement:** Just make final decisions (hire, approve, deploy)

---

## 📋 PREREQUISITES

### Required Accounts
- [ ] GitHub account
- [ ] Upwork account (post job first)
- [ ] Dribbble/Behance account (optional for designer)
- [ ] Telegram or WhatsApp (for notifications)
- [ ] Anthropic API key (Claude)

### Required Hardware
**Option A:** Dedicated computer (recommended)
- Mac Mini ($600) or
- Raspberry Pi 4 ($100) or
- Old laptop that stays on

**Option B:** Cloud server
- DigitalOcean Droplet ($12/month)
- AWS EC2 ($10/month)
- Any Linux VPS

**Why 24/7?** OpenClaw needs to run continuously to monitor and respond in real-time.

---

## PART 1: INSTALL OPENCLAW (20 minutes)

### Step 1.1: Choose Your Platform

**Mac/Linux (Recommended):**
```bash
# One-line install
curl -fsSL https://openclaw.sh/install.sh | bash

# Follow the wizard
openclaw onboard
```

**Windows (WSL2):**
```powershell
# Install WSL2 first
wsl --install

# Then inside WSL:
curl -fsSL https://openclaw.sh/install.sh | bash
openclaw onboard
```

**DigitalOcean (Cloud):**
```bash
# Use their 1-Click OpenClaw Droplet
# Or manual install:
ssh root@your-droplet-ip
curl -fsSL https://openclaw.sh/install.sh | bash
openclaw onboard
```

### Step 1.2: Connect Messaging (Choose One)

**Telegram (Recommended - Easiest):**
```bash
# OpenClaw will show you a QR code
# Scan with Telegram
# Sends test message to confirm
```

**WhatsApp:**
```bash
# Requires phone number
# Scans QR code with WhatsApp
# More setup but works great
```

**Discord/Slack:**
```bash
# Create webhook URL
# Paste into OpenClaw config
```

### Step 1.3: Configure Claude API

```bash
openclaw config set ANTHROPIC_API_KEY "sk-ant-xxxxx"

# Test it
openclaw chat "Hello, are you working?"

# Should respond via your messaging app
```

---

## PART 2: INSTALL PROJECT SKILLS (30 minutes)

### Step 2.1: Download Skills Package

```bash
# Create skills directory
mkdir -p ~/.openclaw/skills/brain-game/

# Copy the 3 skill files from this package:
# - upwork-recruiter.skill.md
# - github-pm.skill.md  
# - designer-manager.skill.md

# Into: ~/.openclaw/skills/brain-game/
```

### Step 2.2: Configure Upwork Skill

```bash
# Edit upwork-recruiter.skill.md

# Set your job ID (get from Upwork after posting)
UPWORK_JOB_ID="~01234567890abcdef"

# Set your Upwork credentials
# (OpenClaw will prompt for password securely)
openclaw config set UPWORK_USERNAME "your@email.com"
openclaw config set UPWORK_PASSWORD  # Will prompt securely

# Enable the skill
openclaw skill enable brain-game/upwork-recruiter

# Schedule auto-run every 2 hours
openclaw schedule brain-game/upwork-recruiter "0 */2 * * *"

# Test it manually
openclaw run brain-game/upwork-recruiter test
```

**Security Note:** OpenClaw stores credentials encrypted locally. Never shares with anyone.

### Step 2.3: Configure GitHub Skill

```bash
# Create GitHub personal access token
# Go to: github.com/settings/tokens
# Create token with 'repo' scope
# Copy the token (ghp_xxxxxxxxxxxx)

openclaw config set GITHUB_TOKEN "ghp_xxxxxxxxxxxx"
openclaw config set GITHUB_REPO "yourusername/brain-training-game"

# Enable skill
openclaw skill enable brain-game/github-pm

# Schedule daily report at 9 AM
openclaw schedule brain-game/github-pm "0 9 * * *"

# Enable real-time monitoring
openclaw watch brain-game/github-pm --realtime

# Test
openclaw run brain-game/github-pm test
```

### Step 2.4: Configure Designer Skill

```bash
# Get Figma token
# Go to: figma.com/developers/api
# Generate personal access token
# Copy token

openclaw config set FIGMA_TOKEN "figd-xxxxxxxxxxxx"
openclaw config set FIGMA_FILE_ID "your-file-id-from-url"

# Enable skill
openclaw skill enable brain-game/designer-manager

# Schedule daily check at 10 AM
openclaw schedule brain-game/designer-manager "0 10 * * *"

# Enable Figma webhooks (optional but recommended)
openclaw webhook create figma \
  --url "https://your-openclaw-instance/webhook/figma" \
  --skill brain-game/designer-manager

# Test
openclaw run brain-game/designer-manager test
```

---

## PART 3: CREATE GITHUB REPOSITORY (20 minutes)

### Step 3.1: Initialize Repo

```bash
# Create on GitHub first
# Then locally:

git clone https://github.com/yourusername/brain-training-game.git
cd brain-training-game

# Copy our complete project structure
# (All files from brain-game/ folder in this package)

# Initial commit
git add .
git commit -m "Initial project setup with complete structure"
git push origin main

# Create development branch
git checkout -b develop
git push origin develop

# Set up branch protection rules on GitHub:
# - Require PR reviews
# - Require status checks
# - No direct commits to main
```

### Step 3.2: Set Up CI/CD

```bash
# GitHub Actions workflows already included in package
# Located in: .github/workflows/

# They will automatically:
# - Run tests on every PR
# - Check code quality
# - Build production bundle
# - Deploy to staging on develop branch
# - Deploy to production on main branch

# Just enable GitHub Actions in repo settings
```

### Step 3.3: Set Up Hosting

**Vercel (Recommended - Free):**
```bash
# Install Vercel CLI
npm install -g vercel

# Link repo
vercel link

# Set up auto-deploy
vercel --prod

# Now git pushes auto-deploy!
```

**Netlify (Alternative):**
```bash
# Connect via Netlify dashboard
# Point to your GitHub repo
# Build: npm run build
# Publish: dist/
```

---

## PART 4: POST JOBS & ACTIVATE (30 minutes)

### Step 4.1: Post Upwork Job

```bash
# Use the job post from:
# openclaw-package/docs/UPWORK_JOB_POST.md

# Copy entire text
# Paste into Upwork job posting form
# Set budget: $3,500 fixed or $60-75/hr
# Post job

# Save the job ID (from URL)
# Example: ~01234567890abcdef

# Update OpenClaw:
openclaw config set UPWORK_JOB_ID "~01234567890abcdef"
```

### Step 4.2: Post Dribbble Job (If Using Designer)

```bash
# Use the job post from:
# openclaw-package/docs/DRIBBBLE_JOB_POST.md

# Post on Dribbble/Behance job board
# Or directly message designers you like

# Save designer contact info:
openclaw config set DESIGNER_EMAIL "designer@email.com"
```

### Step 4.3: Verify Everything Works

```bash
# Test full system
openclaw test all

# Should run all 3 skills and report status
# Check your Telegram/WhatsApp for test messages

# If all green, you're live!
```

---

## PART 5: DAILY OPERATIONS (5-10 min/day)

### Your Daily Routine

**Morning (9:00 AM):**
```
📱 Check Telegram for daily report from OpenClaw

Reports include:
- Upwork proposals (any top candidates?)
- GitHub status (dev progress, PRs to review)
- Design updates (Figma changes, feedback needed)
- Budget tracking
- Timeline status
- Action items for you
```

**Quick Actions:**
```bash
# Approve a PR
Reply: "approve pr 18"

# Hire a candidate
Reply: "hire candidate Sarah Chen"

# Request design changes
Reply: "scale balance needs bigger input boxes"

# Check status anytime
Reply: "status update"
```

**Weekly Review (30 minutes):**
- Review staging build yourself
- Check deliverables against milestones
- Approve payments in Upwork/contracts
- Adjust timeline if needed

---

## PART 6: TROUBLESHOOTING

### OpenClaw Not Responding

```bash
# Check if running
openclaw status

# Restart if needed
openclaw restart

# Check logs
openclaw logs --tail 100

# View errors
openclaw errors
```

### Skills Not Running

```bash
# List all skills
openclaw skills list

# Check specific skill status
openclaw skill status brain-game/github-pm

# Re-enable if needed
openclaw skill disable brain-game/github-pm
openclaw skill enable brain-game/github-pm
```

### Notifications Not Coming Through

```bash
# Test messaging
openclaw notify test "Hello from OpenClaw"

# Check connection
openclaw connection status

# Reconnect if needed
openclaw connect telegram  # or whatsapp
```

### API Rate Limits

```bash
# Check usage
openclaw usage

# Adjust request frequency if hitting limits
openclaw config set REQUEST_DELAY 5000  # 5 second delay

# Upgrade API plan if needed
```

---

## PART 7: SECURITY & PERMISSIONS

### What OpenClaw CAN Do (Configured)

✅ Read GitHub repositories
✅ Comment on PRs and issues  
✅ Run tests locally
✅ Message candidates on Upwork
✅ Check Figma files
✅ Send you notifications

### What OpenClaw CANNOT Do (Locked)

❌ Merge PRs (you approve)
❌ Hire people (you approve)
❌ Spend money (you approve)
❌ Delete anything
❌ Access personal data outside project
❌ Make major project decisions

### Permission Locks

```bash
# View current permissions
openclaw permissions list

# Lock specific actions
openclaw permissions lock --action merge_pr
openclaw permissions lock --action spend_money
openclaw permissions lock --action delete_data

# Require approval for:
openclaw permissions require-approval --action hire_candidate
openclaw permissions require-approval --action approve_payment
```

---

## PART 8: COST TRACKING

### Monthly Costs

```
OpenClaw Itself:           $0 (open source)
Claude API (heavy use):    $50-100/mo
GitHub:                    $0 (free tier)
Vercel/Netlify:           $0 (free tier)
DigitalOcean Droplet:     $12/mo (if cloud hosting)

Total Infrastructure:      $60-112/mo
```

### Project Costs

```
Developer (fixed):         $3,500 (one-time)
Designer (fixed):          $2,800 (one-time)
Audio Designer:            $600 (one-time)

Total Project:             $6,900
Timeline:                  6-8 weeks
```

---

## 📚 REFERENCE LINKS

**OpenClaw Documentation:**
- Official Docs: https://openclaw.ai/docs
- GitHub: https://github.com/openclaw/openclaw
- Community: https://discord.gg/openclaw

**Project Files:**
- All skills: `openclaw-package/skills/`
- All docs: `openclaw-package/docs/`
- Repo structure: `openclaw-package/repo-structure/`

**Support:**
- OpenClaw issues: GitHub issues
- Project questions: Message me in Telegram/WhatsApp
- Emergency: openclaw logs → paste in message

---

## 🎬 FINAL CHECKLIST

Before going live, verify:

- [ ] OpenClaw installed and running
- [ ] Claude API connected and working
- [ ] Telegram/WhatsApp notifications working
- [ ] All 3 skills installed and enabled
- [ ] GitHub repo created with structure
- [ ] Upwork job posted with correct job ID
- [ ] Designer hired (or Dribbble post live)
- [ ] CI/CD pipeline working
- [ ] Staging environment accessible
- [ ] Received test daily report
- [ ] Can approve actions via messaging
- [ ] All credentials secured
- [ ] Permissions properly locked
- [ ] Backup strategy in place

**If all checked:** 🚀 YOU'RE LIVE! Let it run.

---

## 💬 QUICK COMMAND REFERENCE

```bash
# Status checks
openclaw status              # Overall status
openclaw skills list        # List all skills
openclaw config show        # Show configuration

# Manual runs
openclaw run [skill]        # Run specific skill
openclaw test all          # Test everything

# Logs
openclaw logs              # View logs
openclaw errors            # View errors only
openclaw report            # Generate report

# Control
openclaw start             # Start OpenClaw
openclaw stop              # Stop OpenClaw
openclaw restart           # Restart OpenClaw

# Help
openclaw help              # Show all commands
openclaw help [command]    # Help for specific command
```

---

## 🎉 YOU'RE DONE!

OpenClaw is now your autonomous project manager.

**What happens next:**
1. OpenClaw monitors Upwork → finds candidates → you hire
2. OpenClaw monitors GitHub → reviews code → you approve
3. OpenClaw monitors Figma → checks designs → you approve
4. Repeat until project complete

**Your job:**
- Read daily reports (5 min)
- Make decisions (10 min)
- Approve payments (5 min)
- Test the game yourself weekly (30 min)

**Total time commitment:** ~1-2 hours/week

**Project completion:** 6-8 weeks

**Final cost:** ~$7,000

**Result:** Professional brain training game, fully tested, deployed, ready to launch.

---

*Setup guide by Claude*
*Questions? Message OpenClaw: "help setup"*