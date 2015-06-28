---
title: 'Automatically clean up "Previous Mobile Applications"'
date: 2015-06-27T21:19:59-07:00
date-display: June 27, 2015
---
iTunes keeps a "Previous Mobile Applications" folder of questionable value, which always annoys me. It eats into disk space and wastes syncing/backup cycles and bandwidth; you can easily find horror stories online about [100GB+ PMA folders](http://forums.macrumors.com/threads/5-years-of-deleted-iphone-apps-accumulated-in-my-itunes-library.1781676/#post-19749496). The value? You might be able to roll back to an earlier version, or restore an app pulled from the App Store. Really? I never had that need in my life[^disclosure]; have you? Worst of all, there should be a periodic clean up option — just like how deleted mail are automatically purged after one month, but the option is missing.

[^disclosure]: Full disclosure: unlike many people, I'm not very obsessed with my phone, and I only have about two dozen third-party apps.

Therefore, I wrote a trivial Python script to do the periodic cleanup. Feel free to grab my script below (also available at <http://git.io/previous-mobile-applications>) to save a few minutes of hacking. It should be plugged into a daily or weekly or monthly cron job (or the equivalent), and it writes data to `~/.local/share/itunes/previous-mobile-applications.json` by default. To customize, just modify the global constants.

```python
#!/usr/bin/env python3

"""Periodically clean up "Previous Mobile Applications" of iTunes."""

import arrow
import datetime
import json
import os
import sys

OFFENDING_DIR = os.path.expanduser("~/Music/iTunes/iTunes Media/Mobile Applications/Previous Mobile Applications")
STORAGE_DIR = os.path.expanduser("~/.local/share/itunes")
STORAGE_FILE = os.path.join(STORAGE_DIR, "previous-mobile-applications.json")

DELETE_AFTER = datetime.timedelta(days=7)

def load_storage():
    """Load stored dictionary of seen apps from STORAGE_FILE.

    Returns
    -------
    seen_app_dict : dict
        Dictionary of (app_filename, first_seen_date) key-value pairs,
        where app_filename is str, and last_seen_date is datetime.date.

    """
    os.makedirs(STORAGE_DIR, mode=0o700, exist_ok=True)
    try:
        with open(STORAGE_FILE, encoding="utf-8") as fp:
            serializable_seen_app_dict = json.load(fp)
            return {app_filename: arrow.get(serialized_first_seen_date).date()
                    for app_filename, serialized_first_seen_date in serializable_seen_app_dict.items()}
    except OSError:
        return {}

def write_storage(seen_app_dict):
    """Write the dictionary of seen apps to STORAGE_FILE.

    Parameters
    ----------
    seen_app_dict : dict
        See the return format of load_storage().

    Returns
    -------
    0 or 1
        Return code indicating success or failure.

    """
    # convert datetime.time to str (ISO 8601)
    serializable_seen_app_dict = {app_filename: first_seen_date.isoformat()
                                  for app_filename, first_seen_date in seen_app_dict.items()}
    os.makedirs(STORAGE_DIR, mode=0o700, exist_ok=True)
    try:
        with open(STORAGE_FILE, mode="w", encoding="utf-8") as fp:
            json.dump(serializable_seen_app_dict, fp, indent=2, sort_keys=True)
        return 0
    except OSError as err:
        sys.stderr.write("error: failed to write to '%s': %s" % (STORAGE_FILE, str(err)))
        return 1

def main():
    """Main.

    Returns
    -------
    0 or 1
        Return code indicating success or failure.

    """
    if not os.path.isdir(OFFENDING_DIR):
        # good, you don't have that junk
        return 0

    today = datetime.date.today()
    seen_app_dict = load_storage()
    current_app_list = os.listdir(OFFENDING_DIR)

    # boot already disappeared apps
    for app in [app for app in seen_app_dict if app not in current_app_list]:
        seen_app_dict.pop(app)

    # add newly appeared apps
    for app in [app for app in current_app_list if app not in seen_app_dict]:
        seen_app_dict[app] = today

    # delete expired apps
    returncode = 0
    newly_deleted_apps = []
    for app in seen_app_dict:
        if today >= seen_app_dict[app] + DELETE_AFTER:
            app_path = os.path.join(OFFENDING_DIR, app)
            try:
                os.remove(app_path)
                newly_deleted_apps.append(app)
            except OSError as err:
                sys.stderr.write("error: failed to remove '%s': %s" % (app_path, str(err)))
                returncode = 1

    for app in newly_deleted_apps:
        seen_app_dict.pop(app)

    # write data to disk
    returncode |= write_storage(seen_app_dict)

    return returncode

if __name__ == "__main__":
    exit(main())
```
