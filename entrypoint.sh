#!/bin/bash
set -e

echo "📁 Working dir: /data"

mkdir -p /data /workspace /cache

ACT_RUNNER="/runner/act_runner"

if [ ! -f /data/.runner ]; then
  echo "🔧 Registriere neuen Runner..."

  $ACT_RUNNER register \
    --instance "${GITEA_INSTANCE_URL}" \
    --token "${GITEA_RUNNER_REGISTRATION_TOKEN}" \
    --name "${GITEA_RUNNER_NAME:-$(hostname)}" \
    --labels "${GITEA_RUNNER_LABELS:-docker,linux,x64}" \
    --config /data/config.yaml \
    --no-interactive
fi

echo "🚀 Starte Runner..."

exec $ACT_RUNNER daemon --config /data/config.yaml