### Intelligenza Artificiale e Laboratorio
# Progetto d’esame per la parte programmazione logica/ASP
(docente: Gian Luca Pozzato)

E’ richiesta la realizzazione di un progetto (sviluppato anche in gruppo) che comprende le due attività seguenti descritte nel seguito. Oltre all’implementazione degli esercizi è necessario predisporre una breve presentazione (di circa 10 minuti) accompagnata da slides per la presentazione delle implementazioni realizzate, mettendo in evidenza le scelte di progetto più significative e l’analisi critica dei risultati sperimentali ottenuti con opportune prove. 

## ATTIVITÀ 1: PROLOG
Si richiede di implementare un sistema intelligente in grado di risolvere un problema a scelta in un dominio a scelta (anche “giocattolo”), ad eccezione del labirinto con una sola uscita. Sono esempi (ma la scelta NON è da considerarsi limitata ad essi) il mondo dei blocchi, il gioco del 15 (sliding block puzzle), il labirinto con più uscite, il percorso della metropolitana. Si richiede di implementare in Prolog una strategia di ricerca informata (con euristica) nello spazio degli stati. In linea con quanto visto a lezione, è richiesto che il sistema sia composto da almeno tre file:
- un file contenente le definizioni dei predicati trasforma/3 e applicabile/2;
- un file contenente i fatti che descrivono il dominio, lo stato iniziale e i goal;
- un file contenente l’implementazione della strategia di ricerca con un predicato prova/1 il cui argomento corrisponda ad un termine di output con il risultato, ossia abbia il formato prova(+ListaAzioni).
## ATTIVITÀ 2: CLINGO
Si richiede l’utilizzo del paradigma ASP (Answer Set Programming) per la generazione con clingo del calendario di una competizione sportiva, in particolare di un campionato avente le seguenti caratteristiche:
- sono iscritte 20 squadre;
- il campionato prevede 38 giornate, 19 di andata e 19 di ritorno NON
simmetriche, ossia la giornata 1 di ritorno non coincide necessariamente con la giornata 1 di andata a campi invertiti;
- ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
- ogni squadra affronta due volte tutte le altre squadre, una volta in casa e una volta fuori casa, ossia una volta nella propria città di riferimento e una volta in quella dell’altra squadra;
- Due delle 20 squadre fanno riferimento alla medesima città e condividono la stessa struttura di gioco, quindi non possono giocare entrambe in casa nella stessa giornata. Ovviamente, fanno eccezione le due giornate in cui giocano l’una contro l’altra (derby).
---
FACOLTATIVO: in aggiunta alle caratteristiche sopra indicate, da considerarsi obbligatorie, si richiede di considerare i seguenti vincoli ulteriori, che si potranno aggiungere (tutti o alcuni) a discrezione del gruppo nel caso non rendano privo di soluzione il problema:
- ciascuna squadra non deve giocare mai più di due partite consecutive in casa o fuori casa;
- la distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate, ossia se SquadraA vs SquadraB è programmata per la giornata 12, il ritorno SquadraB vs SquadraA verrà schedulato non prima dalla giornata 22.