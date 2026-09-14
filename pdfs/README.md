# Paper PDFs

Drop camera-ready PDFs here and link to them from `index.html`.

## Naming

`<short-name>-<venue><year>[<track>].pdf`, all lowercase, no spaces.
Hyphens separate the parts; the track, when there is one, attaches directly to
the year with no hyphen:

```
llmdroid-fse2025.pdf
atvhunter-icse2021.pdf
maddroid-www2020.pdf
ios-ads-fse2025industry.pdf
chatgpt-chats-msr2024challenge.pdf
```

Always spell out a non-main track (`industry`, `challenge`, …). Without it a
downloaded file looks like a main-track paper.

Use hyphens, never underscores: search engines treat a hyphen as a word break
but not an underscore, and a link's own underline visually swallows `_`.

## Linking

In the entry's `<div class="meta">`, point the badge at the file and label it `PDF`:

```html
<a class="paper" href="pdfs/llmdroid-fse2025.pdf">PDF</a>
```

Keeping the publisher page as well is fine — just use two badges:

```html
<a class="paper" href="pdfs/llmdroid-fse2025.pdf">PDF</a>
<a class="paper" href="https://dl.acm.org/doi/10.1145/3715763">DOI</a>
```

## Before uploading

Check what the venue's copyright agreement allows. ACM and IEEE generally
permit hosting the author's accepted version on a personal page, sometimes
with a required notice; the publisher's typeset version usually may not be
posted. USENIX papers are open access and can be hosted freely.
