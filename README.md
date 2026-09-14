# tmliu06.github.io

Personal academic homepage — [tmliu06.github.io](https://tmliu06.github.io/)

A single static page. No Jekyll, no Ruby, no bundler, no build step.

```
index.html          the whole page (content + structure)
assets/site.css     all styling
images/             avatar + favicons
pdfs/               paper PDFs (see pdfs/README.md for naming)
sitemap.xml         hand-written; bump <lastmod> when the page changes
robots.txt          allows everything, points at the sitemap
serve.ps1           optional local preview server for Windows
.nojekyll           tells GitHub Pages to serve the files as-is
```

## Previewing locally (Windows)

Either:

- **Double-click `index.html`.** That's it — it opens in your browser and looks
  exactly like the deployed site.
- Or run a local server, if you want a real `http://` origin:

  ```powershell
  powershell -ExecutionPolicy Bypass -File .\serve.ps1
  ```

  then open <http://localhost:4321/>. Uses only built-in Windows .NET, so
  nothing needs to be installed.

## Editing

Everything lives in `index.html`.

**Adding a publication** — copy an existing `<li>` block in the `<ol class="pubs">`
list and edit it. Entries are numbered automatically, so the order in the file
is the order on the page (newest first).

```html
<li>
  <div class="title">Paper title goes here</div>
  <div class="authors">Co Author, <span class="me">Tianming Liu</span>, Another Author</div>
  <div class="meta">
    <span class="venue">CONF 2027</span>
    <a class="paper" href="pdfs/shortname-conf2027.pdf">PDF</a>
  </div>
</li>
```

- `<span class="me">` bolds your own name.
- `<sup>#</sup>`, `*`, `<sup>(s)</sup>` mark co-first / corresponding / advised
  student, matching the legend above the list.
- `<span class="award">` renders a gold badge; drop it if there's no award.
- The `<a class="paper">` badge is optional — omit it for papers not yet online.
  Use it for a hosted PDF (`pdfs/…`) or a publisher page; add two if you want both.
- Every link except `mailto:` carries `target="_blank" rel="noopener"`, so the
  homepage stays open when a reader follows one. Copy that onto new links too;
  `rel="noopener"` is what stops the opened page from reaching back into this one.

**Colors, spacing, fonts** — `assets/site.css`. The palette is a short block of
CSS variables at the top; there's a matching dark-mode block at the bottom that
follows the reader's OS setting.

## Deploying

Push to `main`. GitHub Pages serves the repository root directly.
