# ATTIVITÀ 1: PROLOG

## Introduzione al progetto

Nel progetto di Prolog, è stato implementato un Sudoku Solver. Sono stati rappresentati 4 domini localizzati nella directory [sudoku/](./sudoku/) :

- [4x4 facile](./sudoku/dominio4x4facile.pl)
- [4x4 difficile](./sudoku/dominio4x4difficile.pl)  
- [9x9 facile](./sudoku/dominio9x9difficile.pl)
- [9x9 difficile](./sudoku/dominio9x9difficile.pl)

In [azioni.pl](./sudoku/azioni.pl) viene implementata una configurazione di predicati che, con forza bruta, cercano di risolvere il sudoku in input con i **costrutti built-in di Prolog**.

In [azioni_v2.pl](./sudoku/azioni_v2.pl) viene implementata una seconda versione delle azioni, cercano di risolvere il sudoku in input con la sola **metodologia della risoluzione SLD, senza costrutti built-in di Prolog**.

In [azioni-euristiche.pl](./sudoku/azioni-euristiche.pl) è stata implementata l'euristica chiamata *Singoli Ovvi* che permette una risoluzione più veloce ed efficiente, implementando l'informazione nella strategia di ricerca.

In [azioni-euristiche_v2.pl](./sudoku/azioni-euristiche_v2.pl) è stata implementata sempre la stessa euristica *Singoli Ovvi* con **la sola risoluzione SLD**.

In [strategia.pl](./sudoku/strategia.pl) è contenuta la strategia di risoluzione, con i predicati di riferimento presi nei file di *azioni*.

## Versione 1

Nella prima versione abbiamo utilizzato più predicati per rappresentare il ground del dominio. Questo risulta essere più leggibile ma meno performante.

>**NOTA**: Per facilitare l'esecuzione, è stato creato uno script in cui vengono eseguiti tutti gli esempi e riportati i risultati su terminale:
>
>```shell
>cd prolog-project/
>sudo chmod +x run_all.sh
>./run_all.sh
>```

### Comandi di esecuzione (senza euristiche)

Esecuzione di esempio del codice:

```shell
cd prolog-project/
swipl -s startProject4x4facile.pl 
```

>**NOTA**: Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
>
> - startProject4x4facile.pl
> - startProject4x4difficile.pl
> - startProject9x9facile.pl
> - startProject9x9difficile.pl

### Comandi di esecuzione (con euristiche)

Esecuzione di esempio del codice:

```shell
cd prolog-project/
swipl -s startProject4x4facile-euristiche.pl 
```

>**NOTA**: Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
>
> - startProject4x4facile-euristiche.pl
> - startProject4x4difficile-euristiche.pl
> - startProject9x9facile-euristiche.pl
> - startProject9x9difficile-euristiche.pl

## Versione 2

Nella seconda versione abbiamo ottimizzato il ground rendendolo più piccolo e, di conseguenza, diminuendo il numero di vincoli. Questo risulta essere più efficiente dal punto di vista delle prestazioni.

### Comandi di esecuzione v2 (senza euristiche)

Esecuzione di esempio del codice:

```shell
cd prolog-project/
swipl -s startProject4x4facile_v2.pl 
```

>**NOTA** Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
>
> - startProject4x4facile_v2.pl
> - startProject4x4difficile_v2.pl
> - startProject9x9facile_v2.pl
> - startProject9x9difficile_v2.pl


### Comandi di esecuzione v2 (con euristiche)

Esecuzione di esempio del codice:

```shell
cd prolog-project/
swipl -s startProject4x4facile-euristiche_v2.pl 
```

>**NOTA** Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
>
> - startProject4x4facile-euristiche_v2.pl
> - startProject4x4difficile-euristiche_v2.pl
> - startProject9x9facile-euristiche_v2.pl
> - startProject9x9difficile-euristiche_v2.pl
