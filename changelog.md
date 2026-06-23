# Changelog — SecuritasWall headless developer VNC image

## 2026-06-23 — Technology freshen (tag `2026-06-23-r1`)

* **Base OS:** Ubuntu 18.04 → **24.04 LTS** (`libaio1` → `libaio1t64` for the 64-bit `time_t` transition).
* **Runtime:** OpenJDK 8 → **OpenJDK 21 (LTS)**.
* **App server:** Tomcat 8.5.40 → **10.1**.
* **Database:** MySQL 8.0.15 → **8.4 (LTS)** (generic-linux tarball suffix `glibc2.12` → `glibc2.28`).
* **IDE / build:** Eclipse 2019-03 → **2024-09**; Gradle 5.0 → **8.10**.
* **HTML5 client:** noVNC 1.0.0 → **1.5.0**; websockify 0.6.1 → **0.12.0**.
* **Fixed broken builds:**
  * TigerVNC was fetched from the now-defunct `dl.bintray.com` (Bintray shut down in 2021).
    Replaced with the maintained Ubuntu `tigervnc-standalone-server` packages.
  * `python-numpy` (Python 2, EOL) → `python3-numpy`.
* **Docs:** README rewritten for the SecuritasMachina project (removed upstream-fork content and
  donation cruft), added architecture / build-pipeline / desktop diagrams under `docs/images/`,
  tech-stack badges, and a corrected `how-to-release.md`.
* **Housekeeping:** dropped a stray tracked `config` file that leaked an old Bitbucket remote;
  renamed `setup{Tomcat,MySQL}v8.x.sh` → `setup{Tomcat,MySQL}.sh`; modernized OCI image labels;
  removed deprecated `MAINTAINER` instructions.

## Version 1.0.0

* Initial build.
