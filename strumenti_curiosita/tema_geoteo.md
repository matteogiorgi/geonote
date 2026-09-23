# Ereditare lo stile da `geoteo.net`

Questo repository non definisce un proprio tema: la GitHub-Page generata da *Jekyll* eredita layout, stile, favicon, configurazione *MathJax* e rendering *Mermaid* da `geoteo.net`. Il layout arriva come tema remoto (`jekyll-remote-theme`) dal repository `matteogiorgi/matteogiorgi.github.io`, mentre *CSS* e *JS* sono richiamati via URL da `geoteo.net`. In questo modo lo stile resta centralizzato e coerente tra tutti i repository che lo adottano, senza duplicare in locale né il layout né *CSS* o *JS*.




## 1. Cosa fa il tema

- **Layout condiviso**: `_layouts/default.html` vive solo in `matteogiorgi/matteogiorgi.github.io`; a ogni build `jekyll-remote-theme` lo scarica e lo applica come se fosse un tema installato in locale.
- **CSS condiviso**: `https://geoteo.net/static/style.css`, incluse le variabili per la modalità chiara/scura.
- **Toggle tema**: un pulsante in pagina alterna `data-theme="light"`/`"dark"` su `<html>` e salva la scelta in `localStorage`.
- **Favicon dinamica**: al cambio di tema viene ricaricata un'icona diversa (`favicon.svg` / `favicon-dark.svg`) da `geoteo.net`, con query string dedicata per forzare il refresh della cache del browser.
- **Matematica**: `mathjax-config.js` da `geoteo.net` + libreria *MathJax* da *CDN*.
- **Diagrammi**: `mermaid-render.js` da `geoteo.net` per il rendering dei blocchi *Mermaid*.
- **Ancore automatiche** sui titoli tramite `anchor-js`.




## 2. Passi per replicarlo in un altro repository

### 2.1 Configurazione

Crea `_config.yml` nella directory di root con il seguente contenuto:

```yaml
remote_theme: matteogiorgi/matteogiorgi.github.io
plugins:
  - jekyll-seo-tag
```

- `remote_theme` sostituisce la copia locale di `_layouts/default.html`: a ogni build viene scaricato il repository `matteogiorgi/matteogiorgi.github.io` e ne viene applicata la cartella `_layouts`. Se nel repository esiste ancora un `_layouts/default.html` locale, ha la precedenza su quello remoto: va quindi rimosso.
- `plugins` attiva `jekyll-seo-tag`, richiesto dal tag `{% raw %}{% seo %}{% endraw %}` usato nel layout (vedi [§2.3](#23-nessun-gemfile)).


### 2.2 (Opzionale) Apici nelle formule

Se il repo contiene formule matematiche con apici (es. `f'`, `f''`), aggiungi a `_config.yml`:

```yaml
kramdown:
  # apici dritti richiesti da MathJax per f' f'' ecc. dentro $...$
  smart_quotes: ["apos", "apos", "quot", "quot"]
```

Non è necessario per ereditare lo stile grafico, ma evita che *Kramdown* converta gli apici dritti in apici tipografici dentro `$...$`. Questa parte resta locale perché un tema remoto porta con sé solo file (`_layouts`, `_includes`, `_sass`, `assets`), non impostazioni di configurazione.


### 2.3 Nessun Gemfile

`jekyll-remote-theme` e `jekyll-seo-tag` fanno parte della gem `github-pages` con cui GitHub-Pages compila i siti, quindi non serve un `Gemfile`. Serve però dichiararli nel modo giusto:

- `jekyll-remote-theme` viene attivato in automatico quando `_config.yml` contiene `remote_theme`;
- `jekyll-seo-tag` **non** è attivo di default: senza un tema dichiarato funzionerebbe solo perché GitHub-Pages applica il tema predefinito `jekyll-theme-primer`, che se lo porta dietro. Con `remote_theme` va dichiarato in `plugins`, altrimenti la build rischia di fallire con `Unknown tag 'seo'`.


### 2.4 Abilitare GitHub-Pages

Nelle impostazioni del repository: *Settings $\to$ Pages $\to$ Build and deployment $\to$ Deploy from a branch*, selezionando il branch (es. `main`) e la cartella root (`/`). Al primo push, GitHub compila il sito con *Jekyll* scaricando il layout da `matteogiorgi/matteogiorgi.github.io`, come descritto al [§2.1](#21-configurazione).




## 3. Cosa è condiviso con `geoteo.net` e cosa resta locale

Tutto ciò che riguarda il tema (layout, colori, favicon, toggle) è condiviso e vive in un solo posto, `matteogiorgi/matteogiorgi.github.io`; tutto ciò che riguarda il rendering di una pagina markdown vive solo nei repository con GitHub-Pages, perché `geoteo.net` non ne ha bisogno.

**Condiviso con `geoteo.net`** (fa parte del tema base, replicato apposta anche in `haunt.scm`, generatore della home page):

- tema chiaro/scuro, font, colori;
- switch chiaro/scuro, incluso il fix per bfcache/reload;
- `.badge-link` sui repository con GitHub-Pages — nativo di `geoteo.net`.

**Non presente su `geoteo.net`** (funzionalità legate al *rendering del contenuto Markdown*, presenti in `_layouts/default.html` ma non usate dalla home page):

- bottone "powered by Geoteo" / link al repo in fondo pagina (`.gh-footer`);
- bottone di copia ed etichetta del linguaggio nei blocchi di codice — `geoteo.net` non ha blocchi di codice nel suo contenuto;
- tabelle responsive, blockquote, liste ristilizzate, overflow delle formule *MathJax* — tutto scoped su `.markdown-body`, classe non presente nella home page;
- *MathJax*/*Mermaid* stessi non sono caricati su `geoteo.net` (gli script sono inclusi solo nel layout *Jekyll*).

`_layouts/default.html` si trova nella root di `matteogiorgi/matteogiorgi.github.io`, fuori da `docs/`: la home page viene pubblicata da `docs/`, quindi il layout non interferisce con il sito generato da *Haunt*.




## 4. Aggiornare il tema per tutti i repository

Per cambiare il layout di *tutti* i repository che lo ereditano basta modificare `_layouts/default.html` in `matteogiorgi/matteogiorgi.github.io` e fare push.

Un tema remoto viene scaricato solo quando un repository viene ricompilato, quindi di per sé la modifica arriverebbe a ciascuno solo al suo push successivo. Per questo `matteogiorgi/matteogiorgi.github.io` contiene il workflow `.github/workflows/rebuild-themed-pages.yml`, che ricompila automaticamente tutti i repository che ereditano il tema.

Le modifiche a `style.css`, `mathjax-config.js` e `mermaid-render.js` invece sono immediate, perché questi file vengono richiamati via URL da `geoteo.net` a ogni caricamento della pagina, non durante la build.


### 4.1 Come funziona il workflow

Il workflow parte a ogni push su `main` che modifica `_layouts/` (o `_includes/`) e fa due cose:

1. **Scoperta**: elenca i repository non archiviati con GitHub-Pages attivo e ne legge il `_config.yml`; quelli che contengono `remote_theme: matteogiorgi/matteogiorgi.github.io` ereditano il tema. Non c'è una lista da mantenere: un nuovo repository configurato come al [§2.1](#21-configurazione) viene incluso da solo.
2. **Rebuild**: per ciascuno di questi chiede a GitHub una nuova build di GitHub-Pages, tramite l'API `POST /repos/{owner}/{repo}/pages/builds`. L'effetto è lo stesso di un push, ma senza aggiungere commit ai repository.

Si può anche lanciare a mano da *Actions $\to$ Rebuild themed Pages $\to$ Run workflow*, per esempio per verificare che funzioni.


### 4.2 Il token `PAGES_REBUILD_TOKEN`

Il token che GitHub-Actions assegna in automatico a un workflow (`GITHUB_TOKEN`) vale solo per il repository in cui il workflow gira: basta per leggere i `_config.yml` degli altri repository (pubblici), ma non per avviarne la build. Per questo serve un *fine-grained personal access token*, salvato come secret `PAGES_REBUILD_TOKEN` in `matteogiorgi/matteogiorgi.github.io`, con:

- **Repository access**: *All repositories*, così un nuovo repository che eredita il tema funziona senza aggiornare il token;
- **Permissions**: solo *Pages: Read and write*, quindi il token può avviare build di GitHub-Pages ma non leggere né modificare codice, issue o impostazioni;
- **Expiration**: un anno.

Per crearlo: *Settings $\to$ Developer settings $\to$ Personal access tokens $\to$ Fine-grained tokens $\to$ Generate new token*. Per salvarlo: nel repository `matteogiorgi/matteogiorgi.github.io`, *Settings $\to$ Secrets and variables $\to$ Actions $\to$ New repository secret*.

Quando il token scade il workflow fallisce (lo si vede nella tab *Actions* e GitHub manda una mail): basta rigenerarlo con *Regenerate token*, che mantiene le stesse impostazioni, e aggiornare il valore del secret.
