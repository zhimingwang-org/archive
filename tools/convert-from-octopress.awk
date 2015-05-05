#!/usr/bin/env gawk -f
/---/ { meta_delim_count++ }
{
    if (meta_delim_count >= 2) {
        # remove additional metadata (title, url, link text) other than the
        # language from a Octopress fenced (backtick) code block
        if (match($0, /\s*```\s*[[:alnum:]_-]+/, matchobj)) {
            print matchobj[0]
            next
        }

        # convert Octopress {% %} plugin blocks to verbatim (in fenced code
        # blocks); this can't really handle multiline plugins (e.g.,
        # blockquote), but sacrifices need to be made anyway
        if (match($0, /\s*{%.+%}\s*/)) {
            print "```"
            print
            print "```"
            next
        }

        # correct internal links
        $0 = gensub(/\/blog\/([0-9]{4})\/([0-9]{2})\/([0-9]{2})\/([a-zA-Z0-9%_-]+)\//, \
                    "/blog/\\1-\\2-\\3-\\4.html", "g")
        print
    } else if ($1 == "layout:" || $1 == "comments:" || $1 == "categories:") {
        next
    } else if ($1 == "date:") {
        # Convert
        #
        #     date: 2015-05-03 17:15:49 -0700
        #
        # to
        #
        #     date: 2015-05-03T17:15:49-0700
        #     date-display: May  3, 2015
        #
        # Requires date from coreutils; BSD date doesn't work.
        printf "date: %sT%s%s\n", $2, $3, $4
        printf "date-display: "
        system("date -d "$2" +'%B %_d, %Y'")
    } else {
        print
    }
}
