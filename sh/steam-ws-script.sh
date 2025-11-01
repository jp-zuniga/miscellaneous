#!/usr/bin/env bash
# Emulate Steam Workshop content on a FAT32 loopback mount (e.g., for Proton/Steam quirks)

set -Eeuo pipefail
IFS=$'\n\t'

# ---------- Config ----------
: "${SIZE:=5G}"
USER_NAME="${USER}"
USER_UID="$(id -u)"
USER_GID="$(id -g)"
USER_HOME="${HOME}"

WORKSHOP_DIR_DEFAULT="${USER_HOME}/.local/share/Steam/steamapps/workshop"
WORKSHOP_DIR="${WORKSHOP_DIR:-$WORKSHOP_DIR_DEFAULT}"
CONTENT_DIR="${WORKSHOP_DIR}/content"
STEAM_APPS_DIR="$(dirname "$WORKSHOP_DIR")"
FAT32_IMG="${FAT32_IMG:-${STEAM_APPS_DIR}/civ6workshop-fat32.img}"
BACKUP_DIR="$(mktemp -d -t steamworkshop.XXXXXX)"
VOL_LABEL="STEAMWS"

# ---------- Helpers ----------
msg() { printf "%s\n" "$*"; }
die() {
    printf "ERROR: %s\n" "$*" >&2
    exit 1
}

need_cmd() {
    command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

# ---------- Preconditions ----------
if [[ $EUID -eq 0 ]]; then
    die "Do not run as root. Run as a normal user with sudo privileges."
fi

need_cmd sudo
need_cmd losetup
need_cmd mkfs.vfat
need_cmd mount
need_cmd umount
need_cmd mktemp

[[ -d "$CONTENT_DIR" ]] || die "Workshop content directory not found: $CONTENT_DIR"

if mountpoint -q "$CONTENT_DIR"; then
    die "Workshop content directory is already a mountpoint: $CONTENT_DIR"
fi

# Cache sudo credentials once (will prompt if needed)
sudo -v

# Keep sudo alive while we run
# shellcheck disable=SC2064
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT

(while true; do
    sleep 60
    sudo -n true || exit
done) &
SUDO_KEEPALIVE_PID=$!

# ---------- State for cleanup ----------
LOOP_DEV=""
MOUNTED=0

cleanup() {
    local code=$?

    trap - INT TERM QUIT EXIT

    if ((MOUNTED)); then
        msg "Syncing and unmounting ${CONTENT_DIR}..."
        sudo sync || true
        sudo umount "$CONTENT_DIR" || true
    fi

    if [[ -n "${LOOP_DEV}" ]]; then
        msg "Detaching loop device ${LOOP_DEV}..."
        sudo losetup -d "$LOOP_DEV" || true
    fi

    if [[ -f "$FAT32_IMG" ]]; then
        msg "Removing image ${FAT32_IMG}..."
        sudo rm -f -- "$FAT32_IMG" || true
    fi

    if [[ -d "$BACKUP_DIR" ]]; then
        msg "Removing temporary backup ${BACKUP_DIR}..."
        rm -rf -- "$BACKUP_DIR" || true
    fi

    exit "$code"
}

trap cleanup INT TERM QUIT EXIT

# ---------- Functions ----------
backup_workshop() {
    msg "Backing up Workshop contents to ${BACKUP_DIR}..."
    mkdir -p "${BACKUP_DIR}/content"

    if command -v rsync >/dev/null 2>&1; then
        # Copy links as real files so FAT32 can accept them
        rsync -a --delete --copy-links "${CONTENT_DIR}/" "${BACKUP_DIR}/content/"
    else
        # Portable fallback; include dotfiles
        shopt -s dotglob nullglob
        cp -a "${CONTENT_DIR}/." "${BACKUP_DIR}/content/"
        shopt -u dotglob nullglob
    fi

    msg "Backup complete."
}

create_image() {
    msg "Creating ${SIZE} FAT32 image at ${FAT32_IMG}..."
    sudo rm -f -- "$FAT32_IMG"

    # Prefer fallocate or truncate over dd for speed
    if command -v fallocate >/dev/null 2>&1; then
        sudo fallocate -l "$SIZE" "$FAT32_IMG"
    else
        need_cmd truncate
        sudo truncate -s "$SIZE" "$FAT32_IMG"
    fi

    sudo mkfs.vfat -F 32 -n "$VOL_LABEL" "$FAT32_IMG" >/dev/null
    msg "Image created and formatted."
}

attach_and_mount() {
    msg "Attaching loop device..."

    LOOP_DEV="$(sudo losetup --find --show "$FAT32_IMG")"

    [[ -n "$LOOP_DEV" ]] || die "Failed to allocate a loop device."

    msg "Mounting ${LOOP_DEV} to ${CONTENT_DIR}..."
    sudo mount -t vfat \
        -o "uid=${USER_UID},gid=${USER_GID},umask=002,shortname=mixed,utf8=1" \
        "$LOOP_DEV" "$CONTENT_DIR"

    MOUNTED=1

    msg "Mounted."
}

populate_emulated_workshop() {
    msg "Populating emulated Workshop (FAT32) with your backup..."

    if command -v rsync >/dev/null 2>&1; then
        rsync -a --delete --copy-links "${BACKUP_DIR}/content/" "${CONTENT_DIR}/"
    else
        shopt -s dotglob nullglob
        cp -a "${BACKUP_DIR}/content/." "${CONTENT_DIR}/"
        shopt -u dotglob nullglob
    fi

    msg "Emulated Workshop is ready."
}

# ---------- Main ----------
msg "+++ Ubuntify Steam Workshop +++"
msg "Using content dir: ${CONTENT_DIR}"
msg "Image size: ${SIZE}"
msg "Image file: ${FAT32_IMG}"
msg

backup_workshop
create_image
attach_and_mount
populate_emulated_workshop

msg
msg "Emulation of Workshop set up and running."
msg "Press [CTRL]+[C] to unmount and clean up."

# Keep running until interrupted
while :; do sleep 5; done
