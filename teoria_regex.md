# Espressioni regolari

Una **espressione regolare** è un modo compatto per descrivere un *pattern* (uno schema) che vogliamo cercare all'interno di un testo. Invece di dire a parole "una sequenza di cifre, seguita da uno slash, seguita da altre due cifre…", lo scriviamo in modo formale e la macchina lo cerca per noi.

Questa nota separa i **concetti** (validi ovunque) dalla **resa** in ciascun linguaggio, perché le regex sembrano uguali dappertutto ma cambiano il motore e il dialetto (*flavor*) della sintassi. Nove linguaggi ricorrono come illustrazioni: **C** e **Bash** per il mondo POSIX, **Java** e **JavaScript** per PCRE/ECMAScript, **Go** per RE2, **R** (vedi [fondamenti_r.md](fondamenti_r.md)) come ambiente con due flavor coesistenti, **Guile** (vedi [fondamenti_guile.md](fondamenti_guile.md)) con l'approccio SRFI-115 a s-espressioni, e **OCaml**/**Haskell** come approfondimenti idiomatici.




## 1. Cosa sono e a cosa servono

Le usi ogni volta che devi:

- **verificare** se una stringa rispetta un formato (è una email valida? un codice fiscale?);
- **cercare** una sottostringa che segue uno schema, non un testo fisso;
- **estrarre** pezzi di informazione (giorno, mese e anno da una data);
- **sostituire** testo secondo uno schema (togliere tutti gli spazi doppi);
- **spezzare** una stringa in parti (dividere un CSV sui `;`, gli spazi, ecc.).

Esempio mentale: il pattern `[0-9]{2}/[0-9]{2}/[0-9]{4}` significa "due cifre, uno slash, due cifre, uno slash, quattro cifre" — cioè una data tipo `27/08/2026`.




## 2. Un po' di teoria (leggera)

Non serve una laurea in informatica teorica, ma due idee chiariscono *perché* le regex si comportano come si comportano — e soprattutto cosa non possono fare.


### 2.1 Cosa descrive una regex

Formalmente, una regex descrive un **linguaggio regolare**: un insieme (anche infinito) di stringhe. Si costruisce da tre operazioni fondamentali, che ritrovi tali e quali nella sintassi:

- **Concatenazione** — una cosa dopo l'altra: $R_1 R_2$ → in regex si scrive semplicemente `ab`;
- **Unione (alternanza)** — una cosa *oppure* un'altra: $R_1 \cup R_2$ → in regex `a|b`;
- **Stella di Kleene** — "zero o più ripetizioni": $R^{*}$ → in regex `a*`.

Partendo dal carattere singolo e dalla stringa vuota $\varepsilon$, con queste tre operazioni costruisci qualsiasi pattern. Tutto il resto (`+`, `?`, `\d`, `[...]`) è zucchero sintattico: scorciatoie comode per cose che potresti scrivere anche con solo queste tre. Un linguaggio regolare si può anche definire ricorsivamente:

$$
L ::= \varnothing \;\mid\; \varepsilon \;\mid\; a \;\mid\; L_1 L_2 \;\mid\; L_1 \cup L_2 \;\mid\; L^{*}
$$


### 2.2 Perché "regolari": il legame con gli automi

Ogni linguaggio regolare corrisponde a un **automa a stati finiti**: una macchinetta con un numero fissato di stati che legge la stringa un carattere alla volta e decide se accettarla. "Numero finito di stati" è la chiave: l'automa non ha memoria per contare quantità arbitrarie.


### 2.3 Cosa le regex NON possono fare

Poiché l'automa non può contare all'infinito, le regex non sanno gestire strutture annidate e bilanciate di profondità arbitraria: parentesi aperte/chiuse, tag HTML dentro altri tag, JSON. Non si può scrivere una vera regex (nel senso teorico) che riconosca "tante `(` quante `)`, correttamente annidate", perché richiederebbe di *contare* e ricordare quante ne hai aperte — cosa che un numero finito di stati non permette.

> **Regola d'oro:** per HTML, JSON, XML, codice sorgente e in generale tutto ciò che è annidato, non usare le regex: usa un vero parser. Le regex vanno bene per l'analisi riga per riga o su pezzi "piatti", non per la struttura ad albero.
>
> Alcuni motori moderni (PCRE) aggiungono estensioni — pattern ricorsivi, gruppi bilancianti — che vanno oltre i linguaggi regolari "veri". Sono trucchi specifici e fragili: quando servono, quasi sempre conviene un parser.




## 3. Sintassi: i mattoni

Ogni voce ha un micro-esempio. La sintassi mostrata è quella PCRE/Perl-like, la più diffusa; le differenze tra flavor sono nel [§6](#6-i-flavor-perché-la-stessa-regex-non-funziona-ovunque).


### 3.1 Letterali e metacaratteri

La maggior parte dei caratteri corrisponde a se stessa: `casa` trova esattamente `casa`. Alcuni caratteri hanno un significato speciale (i *metacaratteri*): `. ^ $ * + ? ( ) [ ] { } | \`. Per cercare un metacarattere letteralmente lo si fa precedere da `\` (escaping): `\.` significa "un punto vero", non "un carattere qualsiasi". `3\.14` trova `3.14`; senza `\`, il `.` significherebbe "carattere qualsiasi".


### 3.2 Il jolly e le ancore

| Simbolo | Significato | Esempio |
|---|---|---|
| `.` | un carattere qualsiasi (di solito tranne il newline) | `c.sa` trova `casa`, `cosa`, `c3sa` |
| `^` | inizio della stringa (o della riga, con flag *multiline*) | `^Ciao` |
| `$` | fine della stringa (o della riga) | `fine$` |
| `\b` | confine di parola (tra `\w` e non-`\w`) | `\bgatto\b` trova `gatto` ma non `gatton` |
| `\B` | non confine di parola | `\Bgatto` |

`^` e `$` non "consumano" caratteri: sono àncore, indicano una posizione, non un carattere.


### 3.3 Classi di caratteri

Una classe `[...]` significa "uno dei caratteri elencati": `[abc]` è `a` oppure `b` oppure `c`; `[a-z]` è un intervallo (lettera minuscola); `[A-Za-z0-9]` è lettera o cifra; `[^0-9]` è la negazione, qualsiasi carattere tranne una cifra. Esistono classi predefinite:

| Abbreviazione | Equivale a | Significato |
|---|---|---|
| `\d` | `[0-9]` | una cifra |
| `\D` | `[^0-9]` | non una cifra |
| `\w` | `[A-Za-z0-9_]` | carattere di "parola" |
| `\W` | `[^A-Za-z0-9_]` | non di parola |
| `\s` | spazi, tab, newline… | uno spazio bianco |
| `\S` |  | non spazio bianco |

> `\d`, `\w`, `\s` non esistono nei flavor POSIX (C, Bash base): lì si usano `[0-9]`, `[[:digit:]]`, `[[:alpha:]]`, ecc. Vedi [§6](#6-i-flavor-perché-la-stessa-regex-non-funziona-ovunque).


### 3.4 Quantificatori

Dicono quante volte ripetere l'elemento che li precede:

| Quantificatore | Significato | Esempio |
|---|---|---|
| `*` | zero o più | `ab*` → `a`, `ab`, `abbbb` |
| `+` | uno o più | `ab+` → `ab`, `abbbb` (non `a`) |
| `?` | zero o uno (opzionale) | `colou?r` → `color`, `colour` |
| `{n}` | esattamente `n` volte | `\d{4}` → un anno a 4 cifre |
| `{n,}` | almeno `n` volte | `\d{2,}` → 2 o più cifre |
| `{n,m}` | da `n` a `m` volte | `\d{2,4}` → da 2 a 4 cifre |

**Greedy, lazy, possessive** — questa distinzione crea molti bug. Di default i quantificatori sono golosi (**greedy**): prendono il più possibile. Il quantificatore **lazy** (`.*?`) prende il minimo possibile; il **possessive** (`.*+`) prende il massimo e non molla mai (utile per le prestazioni, vedi [§4.5](#45-catastrophic-backtracking-e-redos)). Esempio su `<a><b>`:

| Pattern | Cosa trova | Perché |
|---|---|---|
| `<.*>` (greedy) | `<a><b>` (tutto!) | `.*` divora fino all'ultimo `>` |
| `<.*?>` (lazy) | `<a>` | `.*?` si ferma al primo `>` |

Nove volte su dieci, quando "la regex prende troppo", è perché è greedy e volevi lazy.


### 3.5 Alternanza e gruppi

- **Alternanza** `|` — "questo *oppure* quello": `gatto|cane|topo`.
- **Gruppo catturante** `(...)` — raggruppa e "cattura" (memorizza) la parte trovata, per poterla estrarre o riusare: `(\d{4})` cattura l'anno.
- **Gruppo non catturante** `(?:...)` — raggruppa senza memorizzare (più efficiente, non sporca la numerazione dei gruppi): `(?:ab)+`.
- **Gruppo con nome** `(?<anno>\d{4})` — come un gruppo catturante ma con un nome leggibile invece di un numero.

L'alternanza ha priorità bassissima: `^gatto|cane$` significa `(^gatto)|(cane$)`, non `^(gatto|cane)$`. In caso di dubbio, usa i gruppi: `^(?:gatto|cane)$`.


### 3.6 Backreference

Una **backreference** ti fa dire "di nuovo la stessa cosa che ho catturato prima". `\1` = "il testo catturato dal gruppo 1". Esempio: `(\w+) \1` trova una parola ripetuta, come `ciao ciao`.

> Le backreference non esistono in RE2 (Go) né, di regola, in POSIX ERE: è una delle differenze più importanti tra i flavor.


### 3.7 Lookaround (asserzioni)

Sono condizioni che guardano *intorno* alla posizione corrente senza consumare caratteri: verificano che qualcosa ci sia (o non ci sia) prima/dopo, ma non lo includono nel match.

| Sintassi | Nome | Significato |
|---|---|---|
| `(?=...)` | look-ahead positivo | *seguito da* … |
| `(?!...)` | look-ahead negativo | *non seguito da* … |
| `(?<=...)` | look-behind positivo | *preceduto da* … |
| `(?<!...)` | look-behind negativo | *non preceduto da* … |

Esempio: `\d+(?= €)` trova le cifre in `50 €` senza includere ` €` nel match. `(?<=\$)\d+` trova le cifre in `$50` senza includere il `$`.

> Il lookaround non c'è in RE2 (Go) e in POSIX. È tipico di PCRE/ECMAScript.


### 3.8 Flag (modificatori)

Cambiano il comportamento generale del match. La sintassi per attivarli varia (spesso un argomento a parte, oppure `(?i)` all'inizio del pattern):

| Flag | Nome | Effetto |
|---|---|---|
| `i` | ignore case | ignora maiuscole/minuscole: `casa` trova anche `CASA` |
| `g` | global | trova tutte le occorrenze, non solo la prima |
| `m` | multiline | `^` e `$` valgono a inizio/fine di ogni riga |
| `s` | dotall / single line | `.` trova anche il newline |
| `x` | extended | permette spazi e commenti nel pattern (più leggibile) |




## 4. Come funziona davvero il matching (qui stanno i bug)

Conoscere la sintassi non basta: la maggior parte degli errori nasce da come il motore *applica* il pattern. Queste cinque cose spiegano il 90% dei "perché non funziona".


### 4.1 Greedy è il default

Come visto nel [§3.4](#34-quantificatori): se non specifichi, il motore prende il più possibile. Ricordalo ogni volta che un match "sconfina".


### 4.2 Match totale vs. ricerca parziale

Questa è una fonte di bug enorme perché cambia da linguaggio a linguaggio. Data la stringa `"27/08/2026"` e il pattern `\d+`: alcune funzioni chiedono che il pattern combaci con tutta la stringa (ancoraggio implicito), altre cercano una corrispondenza in un punto qualsiasi (match parziale).

| Linguaggio | "in un punto qualsiasi" | "tutta la stringa" |
|---|---|---|
| Java | `matcher.find()` | `matcher.matches()` |
| JavaScript | `str.match(re)` / `re.test(str)` | ancora tu con `^…$` |
| Go | `re.FindString` | `re.MatchString` con `^…$`, oppure `\A…\z` |
| Python | `re.search` | `re.fullmatch` (`re.match` àncora solo l'inizio) |

> Se vuoi validare un formato "esatto", àncora sempre con `^…$` (o usa la funzione "match totale"), altrimenti `\d+` trova le cifre *dentro* una stringa più lunga e credi di aver validato tutto.


### 4.3 Chi vince quando ci sono più match possibili? (POSIX vs Perl)

Se un pattern può combaciare in più modi, ci sono due filosofie: **leftmost-longest** (semantica POSIX), a parità di punto di partenza vince il match più lungo possibile — è un criterio globale; **leftmost-first** (semantica Perl/PCRE), il motore prova le alternative in ordine e si tiene la prima che funziona, guidato dal backtracking — non è detto sia la più lunga.

Esempio: pattern `a|ab` sul testo `ab`. Perl/PCRE prova `a` per prima, funziona → match = `a`. POSIX (leftmost-longest) sceglie il più lungo → match = `ab`.

La maggior parte dei linguaggi che userai è Perl-style; ma POSIX (C, `grep`, la libreria `regex-tdfa` di Haskell) segue l'altra regola. Se ottieni un match "più corto/lungo del previsto" tra due ambienti, quasi sempre è questa la ragione.


### 4.4 L'escaping doppio nelle stringhe

Trappola pratica indipendente dalla teoria: in molti linguaggi la regex si scrive dentro una stringa, e la stringa ha già il suo backslash come carattere speciale. Per ottenere la regex `\d` devi scrivere `"\\d"` nel sorgente.

| Linguaggio | Regex desiderata | Nel sorgente scrivi |
|---|---|---|
| Java | `\d` | `"\\d"` |
| C | `\.` | `"\\."` |
| R | `\d` | `"\\d"` |
| JavaScript (literal) | `\d` | `/\d/` (niente doppio escape nei literal `/…/`) |
| Go (raw string) | `\d` | `` `\d` `` (backtick = niente doppio escape) |

> Dove esistono, usa i *raw string* (`` `…` `` in Go, `r"…"` in Python/R…): eliminano il doppio escaping e rendono i pattern molto più leggibili.


### 4.5 Catastrophic backtracking e ReDoS

Alcuni pattern, su input costruiti ad arte, possono impiegare un tempo esponenziale. Succede con quantificatori annidati come `(a+)+` che, cercando di far combaciare qualcosa che poi *fallisce*, provano un numero enorme di combinazioni prima di arrendersi. Ordini di grandezza sul testo `"aaaa…aaa!"` (nessuna corrispondenza finale):

$$
\text{motore a backtracking (peggior caso): } O(2^{n})
\qquad\text{vs.}\qquad
\text{automa (Thompson/RE2): } O(n \cdot m)
$$

dove $n$ è la lunghezza del testo e $m$ quella del pattern. Con $n$ nell'ordine delle decine, $2^n$ diventa già impraticabile: il programma si "pianta". Quando un input dell'utente può scatenare questo comportamento si parla di **ReDoS** (Regular expression Denial of Service), una vulnerabilità di sicurezza reale.

Come difendersi: evita quantificatori annidati (`(x+)+`, `(x*)*`) e alternanze ambigue; àncora bene il pattern (`^…$`) per far fallire prima; usa quantificatori possessive o gruppi atomici `(?>...)` per impedire il backtracking; oppure usa un motore a tempo garantito lineare come RE2 (Go), che rinuncia a backreference e lookaround proprio per poter garantire $O(n)$.




## 5. Le operazioni che farai sempre

I nomi delle funzioni cambiano da linguaggio a linguaggio, il concetto no:

| Operazione | Cosa fa | Esempio d'uso |
|---|---|---|
| test / match | c'è una corrispondenza? (vero/falso) | validare un formato |
| search / find | trova la prima corrispondenza e dove | localizzare un token |
| extract (gruppi) | estrae le parti catturate `(...)` | prendere giorno/mese/anno |
| find all / iterate | scorre tutte le corrispondenze | tutti i numeri in un testo |
| replace / substitute | sostituisce (anche usando i gruppi) | mascherare le email |
| split | spezza la stringa sul pattern | separare un CSV |

Nel replace con i gruppi, nella stringa di sostituzione puoi riusare le parti catturate, di solito con `$1`, `$2` (o `\1`, `\2`). Esempio: trasformare `2026-08-27` in `27/08/2026` con pattern `(\d{4})-(\d{2})-(\d{2})` e sostituzione `$3/$2/$1`.




## 6. I flavor: perché la stessa regex non funziona ovunque

Le regex sembrano uguali dappertutto, ma sotto ci sono motori diversi con dialetti diversi. Conoscerli evita ore di frustrazione.

- **POSIX BRE** (*Basic Regular Expressions*) — il dialetto "vecchio" di `grep` e `sed`. Qui `+`, `?`, `{}`, `|`, `()` sono letterali; per dargli il significato speciale servono `\(`, `\{`, `\|`. Ha le backreference.
- **POSIX ERE** (*Extended*) — `grep -E`, `[[ =~ ]]` di Bash, C con `REG_EXTENDED`. Qui `+ ? { } | ( )` funzionano "normalmente". Niente `\d` (si usa `[[:digit:]]`), niente lookaround, niente lazy; le backreference non fanno parte dello standard.
- **PCRE / Perl-compatible** — lo standard *de facto* moderno. Ricchissimo: `\d`, gruppi con nome, lookaround, possessive, backreference. Motore a backtracking → potente ma vulnerabile al ReDoS.
- **ECMAScript** — il flavor di JavaScript. Molto vicino a PCRE (`\d`, gruppi con nome dal 2018, lookahead da sempre e lookbehind dal 2018). Sintassi literal comoda: `/pattern/flag`.
- **RE2** — il motore di Go (e opzionale altrove). Filosofia opposta a PCRE: rinuncia a backreference e lookaround per garantire tempo lineare $O(n)$ e immunità al ReDoS. Ha `\d` e i gruppi con nome `(?P<…>)`.
- **SRE / SRFI-115** — l'approccio di Guile/Scheme: la regex non è una stringa criptica ma una struttura dati (s-espressione). Concettualmente diverso, molto leggibile.

Morale: prima di copiare un pattern trovato online, chiediti in che flavor è scritto.




## 7. Lo stesso problema in ogni linguaggio (Rosetta)

**Problema comune:** dal testo `"Oggi è il 27/08/2026."` estrarre giorno, mese e anno. Pattern concettuale: `(\d{2})/(\d{2})/(\d{4})` (con gruppi con nome dove il flavor lo permette).


### C — POSIX ERE (`<regex.h>`)

```c
#include <stdio.h>
#include <regex.h>

int main(void) {
    regex_t re;
    /* POSIX ERE: niente \d, si usa [0-9]. I gruppi () catturano. */
    const char *pattern = "([0-9]{2})/([0-9]{2})/([0-9]{4})";
    const char *text    = "Oggi e' il 27/08/2026.";

    /* REG_EXTENDED = sintassi ERE (senza, sarebbe BRE) */
    if (regcomp(&re, pattern, REG_EXTENDED) != 0) {
        fprintf(stderr, "Pattern non valido\n");
        return 1;
    }

    /* m[0] = match intero; m[1..3] = i tre gruppi.
       Ogni gruppo è un intervallo [rm_so, rm_eo) sul testo originale. */
    regmatch_t m[4];
    if (regexec(&re, text, 4, m, 0) == 0) {
        printf("giorno: %.*s\n", (int)(m[1].rm_eo - m[1].rm_so), text + m[1].rm_so);
        printf("mese:   %.*s\n", (int)(m[2].rm_eo - m[2].rm_so), text + m[2].rm_so);
        printf("anno:   %.*s\n", (int)(m[3].rm_eo - m[3].rm_so), text + m[3].rm_so);
    }

    regfree(&re);   /* sempre liberare la regex compilata */
    return 0;
}
```

Il ciclo tipico del mondo POSIX: compila (`regcomp`) → esegui (`regexec`) → libera (`regfree`). Si lavora con indici sul testo, non con sottostringhe pronte.


### Bash — POSIX ERE (`[[ =~ ]]`)

```bash
text="Oggi è il 27/08/2026."

# L'operatore =~ usa ERE. I gruppi finiscono nell'array BASH_REMATCH.
if [[ $text =~ ([0-9]{2})/([0-9]{2})/([0-9]{4}) ]]; then
    # BASH_REMATCH[0] = match intero; [1..3] = gruppi
    echo "giorno: ${BASH_REMATCH[1]}"
    echo "mese:   ${BASH_REMATCH[2]}"
    echo "anno:   ${BASH_REMATCH[3]}"
fi

# In alternativa, dalla riga di comando con gli strumenti classici:
#   grep -oE '[0-9]{2}/[0-9]{2}/[0-9]{4}'   → ERE
#   grep -oP '\d{2}/\d{2}/\d{4}'            → PCRE (GNU grep)
#   sed -E 's#.*([0-9]{2})/([0-9]{2})/([0-9]{4}).*#\1 \2 \3#'
```

Bash da solo mostra il caos dei flavor sulla stessa macchina: `[[ =~ ]]` e `grep -E` usano ERE, `grep -P` usa PCRE, `sed` un altro dialetto ancora.


### Go — RE2 (`regexp`)

```go
package main

import (
	"fmt"
	"regexp"
)

func main() {
	// (?P<nome>...) è la sintassi RE2 per i gruppi con nome.
	// Backtick = raw string: niente doppio escaping, \d resta \d.
	re := regexp.MustCompile(`(?P<day>\d{2})/(?P<month>\d{2})/(?P<year>\d{4})`)
	text := "Oggi è il 27/08/2026."

	m := re.FindStringSubmatch(text) // m[0]=intero, m[1..3]=gruppi in ordine
	if m != nil {
		fmt.Println("giorno:", m[1])
		fmt.Println("mese:  ", m[2])
		fmt.Println("anno:  ", m[3])
	}
}
```

RE2 garantisce tempo lineare: in cambio non offre backreference né lookaround. Ottimo quando il pattern gira su input non fidati (niente ReDoS).


### Java — flavor PCRE-like (`Pattern`/`Matcher`)

```java
import java.util.regex.*;

public class Data {
    public static void main(String[] args) {
        // Doppio escaping: nella stringa Java "\\d" corrisponde alla regex \d
        Pattern p = Pattern.compile("(?<day>\\d{2})/(?<month>\\d{2})/(?<year>\\d{4})");
        String text = "Oggi è il 27/08/2026.";

        Matcher m = p.matcher(text);
        // find() = corrispondenza in un punto qualsiasi (match parziale).
        // matches() invece pretenderebbe l'intera stringa.
        if (m.find()) {
            System.out.println("giorno: " + m.group("day"));
            System.out.println("mese:   " + m.group("month"));
            System.out.println("anno:   " + m.group("year"));
        }
    }
}
```

Due lezioni in uno snippet: il doppio escaping (`"\\d"`) e la differenza `find()` (parziale) vs `matches()` (totale) del [§4.2](#42-match-totale-vs-ricerca-parziale).


### JavaScript — ECMAScript

```javascript
// Sintassi literal /.../ : dentro NON serve il doppio escaping.
// Ma lo '/' va protetto con \/ perché delimita il literal.
const re = /(?<day>\d{2})\/(?<month>\d{2})\/(?<year>\d{4})/;
const text = "Oggi è il 27/08/2026.";

const m = text.match(re);
if (m) {
    // I gruppi con nome finiscono in m.groups
    console.log("giorno:", m.groups.day);
    console.log("mese:  ", m.groups.month);
    console.log("anno:  ", m.groups.year);
}
```

Unico rappresentante "puro" del flavor ECMAScript. Comodo l'oggetto `m.groups` per i gruppi con nome. Per tutte le occorrenze si userebbe `str.matchAll(re)` con il flag `g`.


### R — base R (POSIX ERE e PCRE nello stesso ambiente)

```r
text <- "Oggi è il 27/08/2026."

# regexec + regmatches estraggono i gruppi.
# perl = TRUE attiva PCRE (così \d funziona). Nota il doppio escaping "\\d".
m <- regmatches(text, regexec("(\\d{2})/(\\d{2})/(\\d{4})", text, perl = TRUE))[[1]]

# m[1] = match intero; m[2..4] = i tre gruppi
cat("giorno:", m[2], "\n")
cat("mese:  ", m[3], "\n")
cat("anno:  ", m[4], "\n")

# Senza perl = TRUE il default è ERE: niente \d, useresti "([0-9]{2})/...".
# Alternativa moderna con stringr (motore ICU):
#   library(stringr)
#   str_match(text, "(\\d{2})/(\\d{2})/(\\d{4})")
```

R mostra bene "stessa lingua, due flavor": ERE di default, PCRE con `perl = TRUE`, e in più l'ecosistema `stringr`/`stringi` con un terzo motore ancora (ICU).


### Guile — SRFI-115 (regex come s-espressione)

```scheme
(import (srfi 115))   ; SRFI-115: la regex è una struttura Scheme, non una stringa

(define rx-data
  (rx (=> day   (** 2 2 numeric))   ; gruppo "day": esattamente 2 cifre
      "/"
      (=> month (** 2 2 numeric))   ; (** n m sre) = da n a m ripetizioni
      "/"
      (=> year  (** 4 4 numeric)))) ; gruppo con nome via (=> nome sre)

(define m (regexp-search rx-data "Oggi è il 27/08/2026."))

(display (regexp-match-submatch m 'day))   (newline)   ; 27
(display (regexp-match-submatch m 'month)) (newline)   ; 08
(display (regexp-match-submatch m 'year))  (newline)   ; 2026
```

Approccio radicalmente diverso: niente stringa criptica da decifrare, il pattern è codice che puoi comporre, commentare e riutilizzare come qualsiasi altra struttura dati.


### OCaml — libreria `Re` (approccio componibile)

```ocaml
(* La libreria Re costruisce il pattern combinando funzioni, non stringhe. *)
let re =
    let open Re in
    compile @@ seq [
        group (repn digit 2 (Some 2));   (* gruppo 1: esattamente 2 cifre *)
        char '/';
        group (repn digit 2 (Some 2));   (* gruppo 2 *)
        char '/';
        group (repn digit 4 (Some 4));   (* gruppo 3 *)
    ]

let () =
    let text = "Oggi è il 27/08/2026." in
    match Re.exec_opt re text with
    | Some g ->
        Printf.printf "giorno: %s\n" (Re.Group.get g 1);
        Printf.printf "mese:   %s\n" (Re.Group.get g 2);
        Printf.printf "anno:   %s\n" (Re.Group.get g 3)
    | None -> ()
```

`Re` (moderna, sicura, componibile) è preferibile al modulo standard `Str`, più basilare e non rientrante (stato globale condiviso → problemi con i thread).


### Haskell — `regex-tdfa`, l'operatore `=~` polimorfo

```haskell
{-# LANGUAGE ScopedTypeVariables #-}
import Text.Regex.TDFA ((=~))

main :: IO ()
main = do
    let text    = "Oggi è il 27/08/2026." :: String
        -- TDFA usa POSIX ERE: niente \d, si usa [0-9]
        pattern = "([0-9]{2})/([0-9]{2})/([0-9]{4})" :: String

    -- Lo STESSO operatore (=~) restituisce cose diverse a seconda del TIPO che chiedi:
    let ok :: Bool
        ok = text =~ pattern                 -- vero/falso

    -- [[String]] = lista di match; ogni match = [intero, gruppo1, gruppo2, ...]
    let groups :: [[String]]
        groups = text =~ pattern

    print ok                                 -- True
    case groups of
        ((_whole : g) : _) -> do
            putStrLn ("giorno: " ++ g !! 0)
            putStrLn ("mese:   " ++ g !! 1)
            putStrLn ("anno:   " ++ g !! 2)
        _ -> putStrLn "nessun match"
```

Due unicità di Haskell: **(1)** `=~` è polimorfo nel risultato — è il tipo che chiedi (`Bool`, `Int`, `String`, `[[String]]`…) a decidere cosa ottieni; **(2)** `regex-tdfa` implementa la semantica POSIX leftmost-longest del [§4.3](#43-chi-vince-quando-ci-sono-più-match-possibili-posix-vs-perl). Nota culturale: in Haskell idiomatico, per input strutturati si preferiscono spesso i *parser combinator* (es. `megaparsec`) alle regex.




## 8. Tabella comparativa dei flavor

| Caratteristica | POSIX BRE | POSIX ERE | PCRE / Perl | ECMAScript (JS) | RE2 (Go) |
|---|---|---|---|---|---|
| `\d` `\w` `\s` | no (usa `[[:digit:]]`) | no (usa `[[:digit:]]`) | sì | sì | sì |
| `+ ? { } \| ( )` senza escape | no (servono `\+` ecc.) | sì | sì | sì | sì |
| Quantificatori lazy `*?` | no | no | sì | sì | sì |
| Quantificatori possessive `*+` | no | no | sì | no | no |
| Gruppi con nome | no | no | sì `(?<n>)` | sì `(?<n>)` | sì `(?P<n>)` |
| Backreference `\1` | sì | no (standard) | sì | sì | no |
| Lookahead `(?=)` `(?!)` | no | no | sì | sì | no |
| Lookbehind `(?<=)` `(?<!)` | no | no | sì | sì (ES2018+) | no |
| Semantica del match | leftmost-longest | leftmost-longest | leftmost-first | leftmost-first | leftmost-first |
| Tempo garantito lineare | dipende | dipende | no (backtracking) | no (backtracking) | sì, $O(n)$ |

Riepilogo per linguaggio:

| Linguaggio | Motore / flavor | Nota chiave |
|---|---|---|
| C | POSIX ERE (`<regex.h>`) | compila → esegui → libera; lavori con indici |
| Bash | POSIX ERE (`[[ =~ ]]`) | ma `grep -P`/`sed`/`awk` cambiano flavor |
| Go | RE2 | tempo lineare, niente backref/lookaround |
| Java | PCRE-like | doppio escaping `"\\d"`; `find()` vs `matches()` |
| JavaScript | ECMAScript | literal `/…/`, `m.groups`, `matchAll` |
| R | ERE (default) / PCRE (`perl=TRUE`) | + `stringr`/`stringi` (ICU) |
| Guile | SRFI-115 (SRE) | pattern come s-espressione |
| OCaml | libreria `Re` | pattern componibile via funzioni |
| Haskell | `regex-tdfa` (POSIX) | `=~` polimorfo; leftmost-longest |




## 9. Checklist e trappole comuni

Prima di scrivere il pattern:

- Il testo è annidato (HTML/JSON/parentesi)? → non usare regex, usa un parser.
- In che flavor sto scrivendo? (`\d` esiste? servono lookaround/backref?)
- Devo validare "tutta la stringa"? → àncora con `^…$` o usa la funzione di match totale.

Mentre lo scrivo:

- Sto usando `.*` greedy dove volevo `.*?` lazy?
- I metacaratteri letterali (`. + ? ( )`) sono escapati con `\`?
- Serve il doppio escaping nella stringa del mio linguaggio? (`"\\d"`)
- Uso gruppi con nome invece di numeri, per leggibilità?
- L'alternanza `|` è racchiusa in un gruppo dove serve? (`^(?:a|b)$`)

Prima di mandarlo in produzione:

- Il pattern ha quantificatori annidati (`(x+)+`)? → rischio ReDoS, riscrivilo o usa RE2.
- L'ho testato su: caso valido, caso non valido, stringa vuota, e input "cattivo" lungo?
- Ho considerato Unicode (accenti, emoji) se il testo può contenerne?

Errori più frequenti in assoluto:

1. Greedy dove serviva lazy → il match "sconfina".
2. Dimenticare `^…$` → validi solo un pezzo della stringa.
3. Usare `\d`/`\w` in POSIX (C, Bash) dove non esistono.
4. Doppio escaping sbagliato → il pattern non è quello che credi.
5. Provare a parsare HTML/JSON con le regex.

> **Esercizio risolto (in Bash):** prendi il pattern data del [§7](#7-lo-stesso-problema-in-ogni-linguaggio-rosetta) e riscrivilo per estrarre un'altra cosa, ad esempio una riga di log `IP - - [data] "GET /path" 200` — costringe a usare gruppi, quantificatori e ancore tutti insieme. Bash è il linguaggio più snello per risolverlo: niente import, niente funzione, match ed estrazione dei gruppi in un solo `if`.
> ```bash
> line='93.184.216.34 - - [27/Aug/2026:14:32:05 +0200] "GET /index.html HTTP/1.1" 200'
>
> # ancore (§3.2): ^...$ pretende che il pattern copra l'intera riga
> # quantificatori (§3.4): + per IP e path, {3} per lo status
> # gruppi catturanti (§3.5): un gruppo per ciascun campo da estrarre
> pattern='^([0-9.]+) - - \[([^]]+)\] "([A-Z]+) ([^ ]+)[^"]*" ([0-9]{3})$'
>
> if [[ $line =~ $pattern ]]; then
>     echo "ip:     ${BASH_REMATCH[1]}"
>     echo "data:   ${BASH_REMATCH[2]}"
>     echo "metodo: ${BASH_REMATCH[3]}"
>     echo "path:   ${BASH_REMATCH[4]}"
>     echo "status: ${BASH_REMATCH[5]}"
> fi
> ```
> Il pattern mette in pratica tutti e tre gli ingredienti richiesti: le ancore `^…$` ([§3.2](#32-il-jolly-e-le-ancore)) obbligano il match a coprire l'intera riga, non un pezzo qualsiasi (senza, basterebbe un IP a caso in mezzo al testo — è lo stesso problema del [§4.2](#42-match-totale-vs-ricerca-parziale)); `[0-9.]+` e `[^ ]+` sono quantificatori ([§3.4](#34-quantificatori)) su classi di caratteri; i cinque `(...)` sono gruppi catturanti ([§3.5](#35-alternanza-e-gruppi)) che finiscono, in ordine, in `BASH_REMATCH[1..5]` — la stessa operazione di *extract* del [§5](#5-le-operazioni-che-farai-sempre).
