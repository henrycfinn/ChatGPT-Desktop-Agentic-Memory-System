# Optional QMD

QMD can improve retrieval and duplicate detection but is optional. The ChatGPT Desktop connector uses QMD when available and falls back to local lexical search if QMD fails or returns no usable candidates. It does not automatically index the vault or guarantee that a partly stale index will find every new note.

The QMD CLI, its indexed collections, and a Hermes `memory.provider` plugin are separate. This project does not install a Hermes QMD memory provider or automatically inject QMD results into every conversation. Do not select `memory.provider: qmd` just because the QMD CLI is installed. If Hermes reports that provider missing, run `hermes memory status` in the affected profile, then use the built-in/default provider or separately install and verify a compatible provider.

Check index freshness with `qmd status`. After reviewing the configured collections and their update behavior, explicitly run `qmd update` and, if semantic vectors need refreshing, `qmd embed`. No index-maintenance task is scheduled by this project.

Keep Librarian `qmd_sync: off` unless you deliberately enable it after reviewing the local configuration. Never index Librarian proposal or receipt directories as canonical knowledge.
