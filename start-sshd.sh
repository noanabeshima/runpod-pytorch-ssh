#!/usr/bin/env bash
set -euo pipefail

mkdir -p /run/sshd /root/.ssh /workspace
chmod 700 /root/.ssh

touch /root/.ssh/authorized_keys

if [ -n "${SSH_PUBLIC_KEY:-}" ]; then
  printf '%s\n' "$SSH_PUBLIC_KEY" >> /root/.ssh/authorized_keys
fi

if [ -n "${PUBLIC_KEY:-}" ]; then
  printf '%s\n' "$PUBLIC_KEY" >> /root/.ssh/authorized_keys
fi

awk 'NF && !seen[$0]++' /root/.ssh/authorized_keys > /root/.ssh/authorized_keys.tmp
mv /root/.ssh/authorized_keys.tmp /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

ssh-keygen -A

echo "sshd ready on port 22"
exec /usr/sbin/sshd -D -e -p 22
