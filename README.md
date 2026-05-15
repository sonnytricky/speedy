![Release Status](https://github.com/sonnytricky/Speedy-Gitea-Runner/actions/workflows/release.yml/badge.svg)
![Version](https://img.shields.io/github/v/release/sonnytricky/Speedy-Gitea-Runner?label=version&style=flat-square)

# # Speedy-Gitea-Runner

<p align="center">

 <img src=".images/speedy.png" alt="Ein Bild">

</p>

### 🧱 Projektstruktur, diese Dateien müssen erstellt werden.
```
speedy/
├── docker-compose.yml
├── Dockerfile
├── .env
├── entrypoint.sh
│
├── runner-data/
│   └── config.yaml
│   └── .runner              # wird automatisch erstellt
│
├── workspace/
│
├── cache/
│
├── scripts/
│   └── cleanup.sh
│
└── logs/
```

---

## Starten

```bash
docker compose build --no-cache
docker compose up -d
```

---

## Prüfen

Logs:

```bash
docker logs -f speedy
```

---

## Ergebnis

Damit hast du:

* persistenten Runner
* automatische Wiederverbindung
* Cache
* parallele Jobs
* sauberen Docker-Zugriff
* sichere Cleanup-Basis *sobald Cron eingerichtet wird*
* globale Gitea-Nutzung
* updatefähigen Betrieb

---

# Update:

[Update-Anleitung](https://github.com/sonnytricky/speedy/blob/main/.docs/Update-Anleitung.md)

## License

This project is licensed under the GPL-3.0 License.