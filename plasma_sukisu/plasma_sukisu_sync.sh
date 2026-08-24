#!/system/bin/sh
# Sync persist.plasma.root_enabled / persist.plasma.adb_root → ksud features.
# Install only libadbroot.so into /data/adb/ksu/lib — do NOT copy ksud into /data/adb,
# so a user-installed Manager can own /data/adb/ksud without conflict.

# Wait until userdata is up (property trigger can fire too early)
[ "$(getprop sys.boot_completed)" = "1" ] || exit 0
[ -d /data ] || exit 0

ROOT_ENABLED="$(getprop persist.plasma.root_enabled)"
if [ -z "$ROOT_ENABLED" ]; then
  ROOT_ENABLED=1
fi

ADB_ENABLED="$(getprop persist.plasma.adb_root)"
if [ -z "$ADB_ENABLED" ]; then
  ADB_ENABLED=1
fi

if [ "$ROOT_ENABLED" = "0" ]; then
  ADB_ENABLED=0
fi

LIB_SRC=""
for c in /system_ext/lib64/libadbroot.so /system/lib64/libadbroot.so; do
  if [ -f "$c" ]; then
    LIB_SRC="$c"
    break
  fi
done

if [ -n "$LIB_SRC" ]; then
  mkdir -p /data/adb/ksu/lib 2>/dev/null || exit 0
  if [ ! -f /data/adb/ksu/lib/libadbroot.so ]; then
    cp -f "$LIB_SRC" /data/adb/ksu/lib/libadbroot.so
    chmod 644 /data/adb/ksu/lib/libadbroot.so
  fi
fi

KSUD=""
for c in /data/adb/ksud /system_ext/bin/ksud /system/bin/ksud; do
  if [ -x "$c" ]; then
    KSUD="$c"
    break
  fi
done

if [ -z "$KSUD" ]; then
  exit 0
fi

"$KSUD" feature set su_compat "$ROOT_ENABLED" >/dev/null 2>&1 || true
"$KSUD" feature set adb_root "$ADB_ENABLED" >/dev/null 2>&1 || true

# Legacy built-in Manager (com.android.settings.manager, Plasma signature) conflicts with
# official com.resukisu.resukisu — remove for all users after dirty flash / upgrade.
if pm path com.android.settings.manager >/dev/null 2>&1; then
  for u in 0 10; do
    pm uninstall --user "$u" com.android.settings.manager >/dev/null 2>&1 || true
    pm hide --user "$u" com.android.settings.manager >/dev/null 2>&1 || true
  done
  pm disable-user --user 0 com.android.settings.manager >/dev/null 2>&1 || true
fi

# Hide user-installed official Manager from other apps (Settings opens via explicit component).
if pm path com.resukisu.resukisu >/dev/null 2>&1; then
  pm hide --user 0 com.resukisu.resukisu >/dev/null 2>&1 || true
fi

setprop ctl.restart adbd >/dev/null 2>&1 || true
exit 0
