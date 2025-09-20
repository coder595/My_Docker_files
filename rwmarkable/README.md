# rwMarkable

> A simple, self-hosted app for your checklists and notes.  
> [GitHub Repository](https://github.com/fccview/rwMarkable)

---

## 📌 What is rwMarkable?

**rwMarkable** is a lightweight, self-hosted web application for managing checklists and notes.  
It’s designed with **simplicity, privacy, and flexibility** in mind:

- All data is stored locally on your server – no third-party cloud needed.
- Supports **Markdown** for notes and **drag & drop checklists**.
- Easily extensible with **themes, emojis, and API integrations**.

---

## ⚙️ Key Features

- 📝 **Notes** with Markdown + rich editor (powered by TipTap).  
- ✅ **Checklists** with categories, drag-and-drop ordering, and progress bars.  
- 🎨 **Custom themes & emojis** via configuration files.  
- 🌐 **REST API** for automation and integrations.  
- 💾 **File-based storage** (Markdown + JSON) — no database required.  
- ⚡ Built with:
  - [Next.js 14 (App Router)](https://nextjs.org/)
  - [TypeScript](https://www.typescriptlang.org/)
  - [Tailwind CSS](https://tailwindcss.com/)
  - [Zustand](https://github.com/pmndrs/zustand)

---

## 🚀 Use Cases

| Scenario | How rwMarkable Helps |
|----------|-----------------------|
| **Personal Task Management** | Keep track of todos, errands, or goals with simple checklists. |
| **Private Note Taking** | Markdown + WYSIWYG editor for flexible note writing. |
| **Small Team Collaboration** | Share notes and checklists with users on the same instance. |
| **Automation / Scripting** | Use the REST API to generate tasks, pull data, or integrate into dashboards. |
| **Self-Hosting Enthusiasts** | Run it on a home server, Raspberry Pi, or VPS with full control of your data. |
| **Customization Lovers** | Apply custom themes, emojis, and configs to make it yours. |

---

## 📂 Data Structure

rwMarkable uses **file-based storage**, keeping everything transparent and easy to back up:

- `data/checklists/` → checklists stored as `.md` files  
- `data/notes/` → notes stored as `.md` files  
- `data/users/` → user metadata & session data  
- `data/sharing/` → shared items metadata  

👉 **Backups are simple**: just copy the `data/` directory.  
👉 You can even version-control your notes and tasks with Git.

---

## 🛠️ Deployment

### Docker Compose (recommended)

```yaml
version: '3.8'

services:
  rwmarkable:
    image: fccview/rwmarkable:latest
    container_name: rwmarkable
    ports:
      - "3000:3000"
    volumes:
      - ./data:/app/data
      - ./config:/app/config
    restart: unless-stopped
    user: "1000:1000"

