# EventForce Management System - Salesforce DX Project

A Salesforce CRM for event planners: clients, events, venues, vendors, feedback, cancellation approvals,
3-day reminder flow, Apex triggers (venue availability + double-booking prevention) and a nightly batch job.

GitHub: <PASTE YOUR REPO LINK HERE>

## What is in this repo
| Folder | Contents |
|---|---|
| `force-app/main/default/objects` | 6 custom objects, all fields, relationships, lookup filter, validation rule |
| `force-app/main/default/classes` | VenueStatusHelper, BatchCompleteEvents, ScheduleCompleteEvents + test classes |
| `force-app/main/default/triggers` | EventTrigger13, PreventDoubleBooking |
| `force-app/main/default/tabs, applications, layouts` | Event Planner Lightning App, tabs, page layouts |
| `force-app/main/default/permissionsets` | Feedback Manager, EventForce Full Access |
| `automation/main/default` | Flow (3-day reminder), email templates, approval process, workflow actions, roles, sharing rule |

## Deploy to your Developer Org
```bash
sf org login web --alias eventforce --set-default
sf project deploy start --source-dir force-app
sf project deploy start --source-dir automation
sf org assign permset --name EventForce_Full_Access
sf apex run test --test-level RunLocalTests --result-format human --wait 10
```
(Or in VS Code: Ctrl+Shift+P > "SFDX: Authorize an Org", then right-click `force-app` > "SFDX: Deploy Source to Org".)

## Steps that must be done in the org (not deployable as code)
1. Users: create Event Admin, Event Coordinator, Vendor Manager, Client users and assign roles. Set a **Manager** on the coordinator user (approval process uses it).
2. Profiles: clone System Administrator / Standard Platform User as per the project guide.
3. Schedule Apex: Setup > Apex Classes > Schedule Apex > `ScheduleCompleteEvents`, daily 8:00 PM.
4. Import sample data (Setup > Data Import Wizard) using the CSVs in `/sample_data`, in numeric order.
5. Report "Upcoming Events by Month" and "EventForce Operations Dashboard" (click steps in the documentation).

## Git commands
```bash
git init
git add .
git commit -m "EventForce Salesforce DX project"
git branch -M main
git remote add origin https://github.com/<your-username>/EventForce-Salesforce.git
git push -u origin main
```
