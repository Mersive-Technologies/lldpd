Mersive LLDPD for PoE Negotiation
=================================

See [this feature specification](https://mersive.atlassian.net/wiki/spaces/PDO/pages/1754333229/LLDP+Support) for more info.

# Build

Your system will need docker installed and the current user needs to be a member of the `docker` group.

 1. Run `mersive/build.sh`.
 2. When successful, the compiled files will be placed under `dist/`.
# Integrating into the Gen3 (Stonehenge) Image