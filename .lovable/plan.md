
# Social Impact & Health — Build Plan

A community-focused web app with five integrated services. Built on Lovable Cloud (managed Postgres + Auth + Realtime + Edge Functions + Storage).

## Defaults I'm assuming (tell me to change any)
- **Auth**: anonymous-first. Chat & SOS work without login. Reminders, Donor Finder, and Health Vault require a free account.
- **Realtime/cron**: Supabase Realtime in place of Socket.io; pg_cron + Edge Functions in place of node-cron (same behavior, no separate server to host).
- **Maps**: Leaflet + OpenStreetMap (free, no API key) with Overpass API for hospital/police lookup.
- **Family alerts**: Email via Lovable's built-in email system. SMS can be added later via Twilio.

## App shell
- Responsive layout with top nav: Home, Chat, Reminders, Donors, SOS, Vault, Account
- Mobile-first, large tap targets (elderly-friendly), high-contrast theme, accessible font sizes
- Calming health palette (soft teal/green primary, warm accent) defined in the design system
- Floating SOS button visible on every page

## 1. Anonymous Mental Health Chat
- Real-time 1:1 chat with a trained-style AI companion (Lovable AI Gateway, no key needed) — no account required
- Session stored only in the browser; "Clear conversation" button
- Crisis trigger: keyword + intent detection ("suicide", "kill myself", "end it", "hurt myself", "help", etc.)
  - Instantly surfaces a Crisis Support panel with helplines (configurable by region: US 988, India iCall 9152987821, UK Samaritans 116 123, international fallback)
  - Banner stays visible for the rest of the session
- Gentle, non-judgmental tone; disclaimers that this is not a substitute for professional care
- Optional: switch to "Peer chat" room (anonymous, ephemeral, moderated by AI)

## 2. Smart Medicine Reminder
- Dashboard to add medications: name, dosage, times per day, start/end date, notes, photo
- Daily schedule view with "Mark as Taken" / "Skip" buttons
- Each scheduled dose creates a row with status (pending/taken/missed)
- Background job (every minute) checks pending doses
  - Browser/push notification at scheduled time
  - If not marked Taken within 30 minutes → status becomes "missed" → automated email to the emergency contact with medication name, time, and patient name
- Emergency contact configured in profile (name + email)
- History view with adherence percentage

## 3. Nearby Blood Donor Finder
- **Donor registration**: blood group, city, approximate location (map pin), willingness toggle, last donation date (must be ≥3 months)
- **Request blood**: blood group, units, hospital, urgency, contact preference
- Map view (Leaflet) showing matching donors within an adjustable radius (5–50 km) using haversine distance
- **Privacy-first contact flow**: donor contact details are never exposed. Requester clicks "Request to Contact" → donor receives an in-app + email notification → donor decides to share contact or decline. Only after consent are details revealed.
- Donors can pause visibility anytime

## 4. Emergency SOS Dashboard
- Large red one-tap SOS button (works without login)
- Captures GPS via browser Geolocation API (with permission prompt + manual location fallback)
- Queries Overpass API for nearest 24/7 hospitals and police stations within 10 km
- Results shown as map pins + sortable list (distance, name, phone if available, "Call" and "Directions" buttons)
- Quick-dial emergency numbers based on detected country
- If user is logged in: also notifies their emergency contact with location link

## 5. Digital Health Vault
- Login required
- Upload PDFs and images (prescriptions, reports, scans) to a private storage bucket
- Files stored encrypted at rest; access scoped per-user via RLS (no one else, including other logged-in users, can view)
- Tag/categorize: Prescription, Lab Report, Scan, Insurance, Other
- Inline preview for images and PDFs; download button
- Optional notes per document; search by tag/name
- "Share with doctor" generates a time-limited signed URL (expires in 24h)

## Data model (high level)
- `profiles` (user metadata, emergency contact)
- `medications`, `medication_doses` (scheduled instances + status)
- `donors`, `blood_requests`, `donor_contact_requests`
- `vault_documents` (metadata; files in private storage bucket)
- `chat_sessions` optional (only if user opts to save) — chat is anonymous by default
- All tables protected with strict Row-Level Security; user roles in a separate `user_roles` table

## Build order
1. Design system + responsive shell + auth pages + floating SOS
2. Anonymous Mental Health Chat (with crisis trigger)
3. Emergency SOS Dashboard (anonymous)
4. Medicine Reminder + scheduled job + family email alert
5. Blood Donor Finder with map + privacy-first contact flow
6. Digital Health Vault with private storage and signed sharing
7. Polish, accessibility pass, mobile QA
