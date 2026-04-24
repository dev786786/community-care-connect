# 🏥 LifeLink — Community Health & Crisis Response

*Empowering communities through seamless health connectivity, donor matching, and emergency response.*

LifeLink is a full-stack web application designed to bridge the gap in emergency healthcare. By combining real-time SOS alerts, a private health vault, and a gamified referral system, the platform ensures that help is always just a click away.

---

## 🚀 Key Features

### 🆘 Smart SOS System
* *Instant Alerts:* One-tap emergency trigger for immediate assistance.
* *Real-time Tracking:* Integrated with community response protocols to ensure rapid help.

### 🩸 Donor & Resource Matching
* *Blood & Medicine:* Connects those in need with local donors and medicine providers.
* *Reminders:* Automated medication and appointment tracking.

### 🔐 Secure Health Vault
* *Private Storage:* A secure, encrypted space for storing critical health records and documents.
* *Access Control:* Ensures only authorized users can view sensitive medical data.

### 🤝 Referral & Rewards (Gamification)
* *Invite System:* Seamlessly invite friends via WhatsApp or unique referral links.
* *Coin Rewards:* Users earn *100 Coins* for every successful referral, encouraging community growth.
* *Live Dashboard:* Real-time tracking of invites, active referrals, and total coins earned.

---

## 🛠️ Tech Stack

* *Frontend:* React.js, Tailwind CSS, Lucide Icons
* *Backend & Auth:* Supabase (PostgreSQL, Row Level Security)
* *Logic:* Built and iterated with Lovable.ai
* *Deployment:* Lovable Cloud / Vercel

---

## 🏗️ Technical Implementation: Referral Logic

The referral system is powered by a robust backend architecture:

1. *Database Schema:* - A referrals table tracks the mapping between the referrer and the new_user.
   - The profiles table includes a coins integer column and a unique referral_code.
2. *Attribution:* - Uses URL parameters (?ref=CODE) and localStorage to persist referral data across sessions.
3. *Reward Triggers:* - A Supabase trigger automatically updates the referrer's balance by *100 coins* upon a successful new account creation.
4. *Viral Loop:* - Integrated with the *WhatsApp Web API* for one-click community sharing.

---

## 👨‍💻 Author

*Dev Maheshwari*
* First-year B.Tech Student at JIIT Noida
* Full-Stack Developer | MERN & Next.js
* IoT & Hardware Enthusiast (ESP32, Drones)

---

## 🏆 Project Context
LifeLink was developed to address information fragmentation in campus and community healthcare. It focuses on high-performance UI and real-time database synchronization to provide a reliable tool during medical emergencies.

---
“Helping someone breathe easier, one referral at a time.”
