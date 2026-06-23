# How to release

1. **Update the version pins** in `Dockerfile.base.1` (the `ARG *_FLAVOR` lines) and the
   download versions in `src/common/install/no_vnc.sh`. Update the matching badges/table in
   `README.md`.
2. **Bump the image tag.** The four images share one release tag (currently `2026-06-23-r1`).
   Update it consistently in `Dockerfile`, `Dockerfile.base.2.devTools`, `Dockerfile.base.3.xfce`
   and the `build-base.*.sh` / `build.sh` scripts.
3. **Update `changelog.md`** with the notable changes.
4. **Build every stage** on a clean, throwaway VM:

   ```bash
   ./buildAll.sh
   ```

   `build.sh` virus-scans the final image with ClamAV and runs the `goss.yaml` smoke tests
   (`dgoss`). Do not push if a virus is found or a test fails.
5. **Push the four tagged images** (the exact `docker push` commands are printed at the end of a
   successful `build.sh` run).
6. **Tag the release** on GitHub:
   <https://github.com/SecuritasMachina/docker-headless-securitaswall/releases/new>

> Major/minor `.x` releases are built and pushed from a Compute VM that is spun up only for the
> build and shut down afterwards, to minimise exposure.
