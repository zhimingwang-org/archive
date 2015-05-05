---
title: "Back up OS X app icons"
date: 2015-03-22T16:58:50-0700
date-display: March 22, 2015
---
OS X application icons are valuable assets, and it's interesting to see how they evolve over time. This is especially the case when we upgraded to OS X 10.10 Yosemite, when Apple and many design-aware third party developers overhauled (mainly flattened) their icons.

However, we lose all the old icons when we do a major OS upgrade. Technically they still live in Time Machine backups, but those are a pain to pull out. Therefore, I wrote a script just now to back up app icons of all applications living in `/Applications` (including those symlinked to `/Applications`, e.g., apps installed through `brew cask`) and its level-one subdirectories, and `/System/Library/CoreServices` (for `Finder.app` and such). Here's the script:

```bash
#!/usr/bin/env bash
function app_version
{
    # $1 is the path to the app
    /usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "$1"/Contents/Info.plist 2>/dev/null || date +%Y%m%d
}
 
function app_icon_path
{
    # $1 is the path to the app
    filename=$(/usr/libexec/PlistBuddy -c "print CFBundleIconFile" "$1"/Contents/Info.plist 2>/dev/null)
    [[ -n ${filename} ]] || return
    filename=$(basename "${filename}" .icns)
    echo "$1/Contents/Resources/${filename}.icns"
}
 
function process_app
{
    # $1 is the path to the app
    name=$(basename "$1" .app | tr -d ' ')
    path=$(realpath -e "$1") || { echo "${RED}error: broken link '${path}'${RESET}" >&2; return 1; }
    version=$(app_version "${path}")
    icon_path=$(app_icon_path "${path}")
    [[ -n ${icon_path} ]] || { echo "${YELLOW}warning: '$1' has no app icon${RESET}"; return 1; }
    [[ -f ${icon_path} ]] || { echo "${RED}error: '${icon_path}' does not exist${RESET}" >&2; return 1; }
    cp "${icon_path}" "${name}-${version}.icns"
    echo "${name}-${version}.icns"
}
 
find /Applications -maxdepth 2 -name '*.app' | while read app; do process_app "${app}"; done
find /System/Library/CoreServices -maxdepth 1 -name '*.app' | while read app; do process_app "${app}"; done
```

The script is also available as a [gist](https://gist.github.com/zmwangx/fad97e085045a21ebc1d).
