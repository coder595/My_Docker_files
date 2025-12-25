#!/usr/bin/env bash
set -euo pipefail

# =========================
# SYSTEM INFORMATION
# =========================

HOSTNAME="$(hostname)"
DATE="$(date)"
UPTIME="$(uptime -p)"
LOAD="$(uptime | awk -F'load average:' '{ print $2 }')"

CPU_MODEL="$(grep -m1 'model name' /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ //')"
CPU_CORES="$(nproc)"

MEM_TOTAL="$(free -h | awk '/Mem:/ {print $2}')"
MEM_USED="$(free -h | awk '/Mem:/ {print $3}')"
MEM_FREE="$(free -h | awk '/Mem:/ {print $4}')"

DISK_USAGE="$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')"

# =========================
# DOCKER STATUS (OPTIONAL)
# =========================

DOCKER_INFO="Docker not installed"

if command -v docker >/dev/null 2>&1; then
  RUNNING_CONTAINERS="$(docker ps -q | wc -l)"
  TOTAL_CONTAINERS="$(docker ps -aq | wc -l)"

  DOCKER_INFO=$(cat <<EOF
Docker Status:
- Running containers : ${RUNNING_CONTAINERS}
- Total containers   : ${TOTAL_CONTAINERS}

Container list:
$(docker ps --format "table {{.Names}}\t{{.Status}}" || true)
EOF
)
fi

# =========================
# OUTPUT REPORT
# =========================

cat <<EOF
System Health Report
====================

Host      : ${HOSTNAME}
Date      : ${DATE}

Uptime    : ${UPTIME}
Load Avg  : ${LOAD}

CPU:
- Model   : ${CPU_MODEL}
- Cores   : ${CPU_CORES}

Memory:
- Total   : ${MEM_TOTAL}
- Used    : ${MEM_USED}
- Free    : ${MEM_FREE}

Disk:
- Root FS : ${DISK_USAGE}

${DOCKER_INFO}
EOF
