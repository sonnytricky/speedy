Mit dem Aufbau ist ein Update später ziemlich einfach und sicher, weil:

* Registrierung persistent in `runner-data/.runner` liegt
* Config außerhalb des Containers liegt
* Workspace und Cache gemountet sind

Dadurch kannst du den Container jederzeit neu bauen oder ersetzen.

---

# Standard-Update Ablauf

## 1. Version im Dockerfile ändern

Zum Beispiel:

```dockerfile
ENV GITEA_RUNNER_VERSION=0.2.13
```

---

# 2. Container neu bauen

Im Projektordner:

```bash
docker compose build --no-cache
```

---

# 3. Container neu starten

```bash
docker compose up -d
```

Fertig.

Der Runner:

* behält seine Registrierung
* erscheint weiterhin gleich in Gitea
* verliert keine Tokens
* verliert keine Labels

weil alles in:

```text
runner-data/.runner
```

liegt.

---

# Was dabei NICHT gelöscht wird

Bleibt erhalten:

```text
runner-data/
workspace/
cache/
config.yaml
.env
```

Gelöscht wird nur:

* der alte Container
* das alte Image

---

# Vorher Backup machen (empfohlen)

Vor größeren Updates:

```bash
tar czf runner-backup.tar.gz \
  runner-data \
  config.yaml \
  .env
```

Dann kannst du immer zurück.

---

# Sicheres produktives Update

Ich würde später meistens so updaten:

```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

Das verhindert:

* alte Layer
* kaputte Builds
* inkonsistente States

---

# Nach dem Update prüfen

Logs ansehen:

```bash
docker logs -f speedy
```

Du solltest sehen:

```text
🚀 Starte Runner...
```

OHNE neue Registrierung.

Wichtig:
Du darfst NICHT sehen:

```text
🔧 Registriere neuen Runner...
```

Wenn doch:
→ `.runner` Datei fehlt.

---

# Prüfen ob Registrierung erhalten blieb

Im Container:

```bash
ls -la runner-data
```

Du solltest sehen:

```text
.runner
```

---

# Updates von Ubuntu / Node / Docker

Genau gleich.

Zum Beispiel:

* Ubuntu 24.04 → 26.04
* Node 20 → 22

Einfach Dockerfile anpassen und rebuilden.

---

# Komplettes Clean Rebuild

Falls irgendwann alles kaputt ist:

```bash
docker compose down
docker system prune -af
docker compose build --no-cache
docker compose up -d
```

ABER:
Nicht `runner-data/` löschen.

---

# Was du NIEMALS löschen solltest

Diese Datei ist kritisch:

```text
runner-data/.runner
```

Wenn die weg ist:

* neuer Runner
* neue ID
* neue Registrierung in Gitea

---
