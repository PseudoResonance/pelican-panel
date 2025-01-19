# Local directory for development environment

Holds files local to this computer that should never be committed.

Caddyfile, crontab and supervisord.conf are symlinked from this directory to their respective locations in the container to be run. Symlinks to the default files are provided so that the application can run immediately, however these may be deleted and replaced with custom configuration if needed.
