PAM_FILE="/etc/pam.d/greetd"
BACKUP_FILE="${PAM_FILE}.bak.$(date +%Y%m%d-%H%M%S)"

if [[ -f "$PAM_FILE" ]]; then
  cp -v "$PAM_FILE" "$BACKUP_FILE"
fi

sudo tee "$PAM_FILE" >/dev/null <<EOF
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
password   optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
EOF
