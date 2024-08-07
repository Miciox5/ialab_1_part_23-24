# ATTIVITÀ 2: ANSWER SET PROGRAMMING IN CLINGO

## Introduzione al progetto:

Nel progetto Clingo, è stato implementato un sistema per la generazione di un calendario di partite (andata e ritorno) con i vincoli richiesti dalla traccia.
Sono state fatte varie prove sui seguenti domini:

- un campionato a 4 squadre,
- un campionato a 8 squadre,
- un campionato a 12 squadre,
- un campionato a 16 squadre (consigliato con **ottimizzazione**),
- un campionato a 20 squadre (consigliato con **ottimizzazione**).

Tutto ciò è servito per esaminare il codice creato, analizzare le tempistiche di esecuzione ed ottimizzare alcuni aspetti implementativi.

>**NOTA** L'implementazione, nella sua seconda versione, cambia soprattutto nella parte del Groud poiché sono stati tagliati dei predicati specifici del dominio. Di conseguenza, abbiamo modificato anche i predicati e con ciò, abbiamo notato come le prestazioni migliorano nettamente, tagliando in particolare il numero dei predicati.

## (Versione 1) Comandi di esecuzione

Esecuzione di esempio su un dominio con 4 squadre:

```shell
cd asp-project/v1/
clingo --models=1 campionato-4squadre.cl 
```

>**NOTA** Per testare gli altri domini, cambiare il file *campionato-4squadre.cl* con le seguenti possibilità:
>
> - [campionato-4squadre.cl](./v1/campionato-4squadre.cl)
> - [campionato-8squadre.cl](./v1/campionato-8squadre.cl)
> - [campionato-12squadre.cl](./v1/campionato-12squadre.cl)
> - [campionato-16squadre.cl](./v1/campionato-16squadre.cl)
> - [campionato-20squadre.cl](./v1/campionato-20squadre.cl)

Il risultato è un modello con le tempistiche di esecuzione e le informazioni sulle risorse utilizzate.

E' stata aggiunto uno script per accelerare le esecuzioni tramite una libreria python chiamata [clingo-dl](https://github.com/potassco/clingo-dl/blob/master/INSTALL.md).
Questa libreria permette di aggiungere delle opzioni di esecuzione in modo da utilizzare delle ottimizzazioni,
soprattutto per le risorse utilizzate e nei domini più grandi (come *campionato-20squadre.cl* ).

## (Versione 2) Comandi di esecuzione

Esecuzione di esempio su un dominio con 4 squadre:

```shell
cd asp-project/v1/
clingo --models=1 campionato-4squadre_v2.cl 
```

>**NOTA** Per testare gli altri domini, cambiare il file *campionato-4squadre.cl* con le seguenti possibilità:
>
> - [campionato-4squadre_v2.cl](./v2/campionato-4squadre_v2.cl)
> - [campionato-8squadre_v2.cl](./v2/campionato-8squadre_v2.cl)
> - [campionato-12squadre_v2.cl](./v2/campionato-12squadre_v2.cl)
> - [campionato-16squadre_v2.cl](./v2/campionato-16squadre_v2.cl)
> - [campionato-20squadre_v2.cl](./v2/campionato-20squadre_v2.cl)
>
> Con domini di grandi dimensioni, è consigliato la definizione dei threads tramite la specifica ```-t <n-threads>``` nel comando di esecuzione. E' consigliata la definizione di 1 singolo threads per CPU.

Il risultato è un modello con le tempistiche di esecuzione e le informazioni sulle risorse utilizzate.

Anche qui, è stata aggiunta la possibilità di esecuzione tramite [clingo-dl](https://github.com/potassco/clingo-dl/blob/master/INSTALL.md).

## Pre-requisiti per ottimizzazione

Per poter eseguire le versioni ottimizzate che troverete più avanti, è consigliato creare un *python environment* tramite, ad esempio, [conda](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html) oppure tramite [virtualenv](https://virtualenv.pypa.io/en/latest/installation.html).
Dopo aver creato l'ambiente, è necessario installare [clingo-dl](https://github.com/potassco/clingo-dl/blob/master/INSTALL.md):

```shell
conda activate <your-environment>
pip install clingo-dl
```

### Configurazione notifiche telegram

Bisogna poi configurarsi un canale telegram personale ([link di esempio](https://www.directual.com/lesson-library/how-to-create-a-telegram-bot)).
Da qui, bisogna recuperare **BOT_TOKEN** e **CHAT_ID**, creare un file ```.env``` e definire le variabili di ambiente all'interno di esso.

Esempio del file ```.env```:

```shell
export BOT_TOKEN="<your-bot-token>" && echo "BOT_TOKEN=\"$BOT_TOKEN\"" >> .env
export CHAT_ID="<your-chat-id>" && echo "CHAT_ID=\"$CHAT_ID\"" >> .env
```

## Esecuzione di V1 e V2 con ottimizzazioni

Esecuzione di esempio su un dominio con 20 squadre con ottimizzazioni e notifica su un proprio canale Telegram.

```shell
cd asp-project/v2/
chmod +x auto_clingo.sh
export NUM_SQUADRE=20
./auto_clingo.sh $NUM_SQUADRE
```

L'esempio riportato è su *v2*. Se lo si vuole eseguire sulla prima versione, basta sostituire *v2* con *v1*.

>**NOTA**: Consultare la sezione [Pre-requisito](#pre-requisiti-per-ottimizzazione) prima di eseguire.
