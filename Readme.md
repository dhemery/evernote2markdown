Dale's tools to translate Evernote's HTML exports to Markdown.

**To run `evernote2markdown`:**

1.  Install pandoc
1.  Export from Evernote as individual HTML files.
1.  Put the exported HTML files into `./from-evernote/`
1.  run `evernote2markdown.rb`

**Result:**

*   Markdown files in `./markdown/`
*   Intermediate HTML files in `./intermediate/,`
    in case you want to see what
    the 'patch-html' step did.
*   Original files unchanged in `./from-evernote/`

**The steps `evernote2markdown` takes:**

1.  Copy HTML files from `./from-evernote/` to `./intermediate/`
1.  Clean up the intermediate HTML files using `sed` with the `patch-html` script.
1.  Run `pandoc` to convert the intermediate HTML files to markdown,
    and place the results in `./markdown/`
1.  Clean up the markdown files using `sed` with the `patch-markdown` script.
1.  Collapse sequences of blank lines into single blank lines
    using `sed` with the `collapse-blank-lines` script.

# Caveats and Assumptions

*   `evernote2markdown` does nothing with any 'resources'
    (e.g. photos, pdf, rtf files, or other attachments)
    in your Evernote exports.
    You will have to handle those yourself.
*   I have only ever run `evernote2markdown` in this environment:
    *   Exports from evernote in mid-October, 2014.
    *   Mac OS X Yosemite.
        Perhaps my `sed` scripts are pecular to OS X.
        Dunno.
    *   Ruby version 2.0.0p481.
    *   pandoc version 1.13.1
*   I made no attempt to optimize for runtime.
    It translated my 400-note exports
    in 10 seconds or so,
    and that was fast enough for me.
*   I was re-learning `sed` as I wrote this.
    The `sed` scripts are surely not exemplary.
*   Use `evernote2markdown` at your own risk.
    **I offer no support whatsoever.**
*   My notes were reasonably simple.
    I offer no guarantee that `evernote2markdown`
    will work for your files.
