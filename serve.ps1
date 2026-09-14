# Local preview server — no Python / Node / Ruby required.
#
#   Right-click this file -> "Run with PowerShell"
#   or, in a terminal:  powershell -ExecutionPolicy Bypass -File .\serve.ps1
#
# Then open http://localhost:4321/ . Press Ctrl+C to stop.
#
# (You can also just double-click index.html — the site is plain static files
#  and works fine straight off the filesystem. The server is only nicer for
#  testing absolute paths and for previewing on a phone on the same Wi-Fi.)

param([int]$Port = 4321)

$root = $PSScriptRoot

$types = @{
  '.html' = 'text/html; charset=utf-8'
  '.css'  = 'text/css; charset=utf-8'
  '.js'   = 'text/javascript; charset=utf-8'
  '.json' = 'application/json; charset=utf-8'
  '.xml'  = 'application/xml; charset=utf-8'
  '.txt'  = 'text/plain; charset=utf-8'
  '.md'   = 'text/plain; charset=utf-8'
  '.webmanifest' = 'application/manifest+json'
  '.png'  = 'image/png'
  '.jpg'  = 'image/jpeg'
  '.jpeg' = 'image/jpeg'
  '.gif'  = 'image/gif'
  '.svg'  = 'image/svg+xml'
  '.ico'  = 'image/x-icon'
  '.pdf'  = 'application/pdf'
  '.woff' = 'font/woff'
  '.woff2'= 'font/woff2'
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")

try { $listener.Start() }
catch { Write-Host "Could not bind port $Port. Try:  .\serve.ps1 -Port 5000" -ForegroundColor Red; exit 1 }

Write-Host ""
Write-Host "  Serving $root" -ForegroundColor DarkGray
Write-Host "  http://localhost:$Port/" -ForegroundColor Green
Write-Host "  Ctrl+C to stop." -ForegroundColor DarkGray
Write-Host ""

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
    if ($rel -eq '') { $rel = 'index.html' }

    $path = Join-Path $root $rel
    # keep requests inside the site directory
    $full = [IO.Path]::GetFullPath($path)
    $inside = $full.StartsWith([IO.Path]::GetFullPath($root), [StringComparison]::OrdinalIgnoreCase)

    try {
      if ($inside -and (Test-Path $full -PathType Leaf)) {
        $ext = [IO.Path]::GetExtension($full).ToLower()
        $ctx.Response.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }
        $ctx.Response.Headers['Cache-Control'] = 'no-store'
        $bytes = [IO.File]::ReadAllBytes($full)
        Write-Host ("  200  /" + $rel) -ForegroundColor DarkGray
      }
      else {
        $ctx.Response.StatusCode = 404
        $ctx.Response.ContentType = 'text/plain; charset=utf-8'
        $bytes = [Text.Encoding]::UTF8.GetBytes('404 Not Found')
        Write-Host ("  404  /" + $rel) -ForegroundColor DarkYellow
      }
      # Close(buffer, willBlock) sets Content-Length and closes the stream for us.
      $ctx.Response.Close($bytes, $true)
    }
    catch {
      # A browser that hangs up mid-response shouldn't take the server down.
      Write-Host ("  ---  /" + $rel + "  " + $_.Exception.Message) -ForegroundColor DarkYellow
      try { $ctx.Response.Abort() } catch {}
    }
  }
}
finally { $listener.Stop(); $listener.Close() }
