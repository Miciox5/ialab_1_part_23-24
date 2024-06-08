## ATTIVITÀ 2: ANSWER SET PROGRAMMING IN CLINGO
### (Versione 1) Comandi di esecuzione:
Esecuzione di esempio su un dominio con 4 squadre:
```
cd asp-project/v1/
clingo campionato-4squadre.cl 
```
Il risultato è un modello con le tempistiche di esecuzione e le informazioni sulle risorse utilizzate.

E' stata aggiunto uno script per accelerare le esecuzioni tramite una libreria python chiamata *clingo-dl*.
Questa libreria permette di aggiungere delle opzioni di esecuzione in modo da utilizzare delle ottimizzazioni,
soprattutto per le risorse utilizzate e nei domini più grandi (come *campionato-20squadre.cl*).

Esecuzione di esempio su un dominio con 20 squadre con ottimizzazioni:
```
cd asp-project/v1/
sudo chmod +x auto_clingo.sh
export NUM_SQUADRE=20
./auto_clingo.sh $NUM_SQUADRE
```

### (Versione 2) Comandi di esecuzione:
Esecuzione di esempio su un dominio con 4 squadre:
```
cd asp-project/v1/
clingo campionato-4squadre_v2.cl 
```
Il risultato è un modello con le tempistiche di esecuzione e le informazioni sulle risorse utilizzate.

E' stata aggiunto uno script per accelerare le esecuzioni tramite una libreria python chiamata *clingo-dl*.
Questa libreria permette di aggiungere delle opzioni di esecuzione in modo da utilizzare delle ottimizzazioni,
soprattutto per le risorse utilizzate e nei domini più grandi (come *campionato-20squadre.cl*).

Esecuzione di esempio su un dominio con 20 squadre con ottimizzazioni:
```
cd asp-project/v1/
sudo chmod +x auto_clingo.sh
export NUM_SQUADRE=20
./auto_clingo.sh $NUM_SQUADRE
```

>__NOTA__ Per testare gli altri domini, cambiare il file *campionato-4squadre.cl* con le seguenti possibilità:
>- campionato-4squadre_v2.cl
>- campionato-8squadre_v2.cl
>- campionato-12squadre_v2.cl
>- campionato-16squadre_v2.cl
>- campionato-20squadre_v2.cl

### Introduzione al progetto:
Nel progetto Clingo, è stato implementato un sistema per la generazione di un calendario di partite (andata e ritorno) con i vincoli richiesti dalla traccia.
Sono state fatte varie prove sui seguenti domini:
- un campionato a 4 squadre,
- un campionato a 8 squadre,
- un campionato a 12 squadre,
- un campionato a 16 squadre,
- un campionato a 20 squadre.

Tutto ciò è servito per esaminare il codice creato, analizzare le tempistiche di esecuzione ed ottimizzare alcuni aspetti implementativi.

>__NOTA__ L'implementazione, nella sua seconda versione, cambia soprattutto nella parte del Groud poiché sono stati tagliati dei predicati specifici del dominio. Di conseguenza, abbiamo modificato anche i predicati e con ciò, abbiamo notato come le prestazioni migliorano nettamente, tagliando in particolare il numero dei predicati.
