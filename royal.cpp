#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

typedef struct {
    int vida;
    int ataque;
    int defensa;
    int evasion;
} Jugador;

int generarAleatorio(int min, int max) {
    return min + rand() % (max - min + 1);
}

void inicializarJugador(Jugador *jugador) {
    jugador->vida = 100;
    jugador->ataque = generarAleatorio(30, 40);
    jugador->defensa = generarAleatorio(10, 25);
    jugador->evasion = 60 - jugador->defensa;
}

int esquivarAtaque(Jugador *jugador) {
    int evasion = generarAleatorio(1, 100);
    if (evasion <= jugador->evasion) {
        printf("¡Esquivo el ataque!\n");
        return 1;
    } else {
        return 0;
    }
}

int contarJugadoresVivos(Jugador *jugadores, int numJugadores) {
    int count = 0;
    for (int i = 0; i < numJugadores; i++) {
        if (jugadores[i].vida > 0) {
            count++;
        }
    }
    return count;
}

void mezclar(int *array, int n) {
    if (n > 1) {
        for (int i = 0; i < n - 1; i++) {
            int j = i + rand() / (RAND_MAX / (n - i) + 1);
            int t = array[j];
            array[j] = array[i];
            array[i] = t;
        }
    }
}

void imprimirEstadoJugadores(Jugador *jugadores, int numJugadores) {
    for (int i = 0; i < numJugadores; i++) {
        printf("Estado del jugador %d\n", i+1);
        printf("Vida: %d\n", jugadores[i].vida);
    }
}

int main() {
    srand(time(NULL));
    Jugador jugadores[4];
    int pipes[4][2];
    int ronda = 1;

    for (int i = 0; i < 4; i++) {
        pipe(pipes[i]);
    }

    for (int i = 0; i < 4; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            // Código del hijo
            int jugadorAtacado;
            if (i == 0) { // Si es el jugador 1
                printf("Estas en la ronda %d. Los jugadores que quedan son:\n", ronda);
                for (int j = 1; j < 4; j++) {
                    printf("Jugador %d: Vida = %d\n", j+1, jugadores[j].vida);
                }
                printf("Elige a quien atacar (2, 3 o 4): ");
                scanf("%d", &jugadorAtacado);
                jugadorAtacado--; // Restar 1 para que los IDs de los jugadores vayan de 0 a 3
            } else {
                do {
                    jugadorAtacado = generarAleatorio(0, 3);
                } while (jugadorAtacado == i); // Asegurarse de que el jugador no se ataque a sí mismo
            }
            write(pipes[i][1], &jugadorAtacado, sizeof(int)); // Escribir el ID del jugador atacado en el pipe
            exit(0);
        } else {
            // Código del padre
            inicializarJugador(&jugadores[i]);
            printf("Estadisticas del jugador %d\n", i+1);
            printf("Vida: %d\n Ataque: %d\n Defensa: %d\n Evasion %d\n", jugadores[i].vida, jugadores[i].ataque, jugadores[i].defensa, jugadores[i].evasion);
        }
    }

    int orden[4] = {0, 1, 2, 3};

    while (contarJugadoresVivos(jugadores, 4) > 1) {
        mezclar(orden, 4);
        for (int i = 0; i < 4; i++) {
            int jugador = orden[i];
            if (jugadores[jugador].vida > 0) {
                int jugadorAtacado;
                read(pipes[jugador][0], &jugadorAtacado, sizeof(int)); // Leer el ID del jugador atacado del pipe
                if (!esquivarAtaque(&jugadores[jugadorAtacado])) { // Si el jugador atacado no esquiva el ataque
                    int dano = jugadores[jugador].ataque - jugadores[jugadorAtacado].defensa;
                    if (dano < 0) { 
                        dano = 0;
                    }
                    printf("El jugador %d recibió %d de daño\n", jugadorAtacado+1, dano);
                    jugadores[jugadorAtacado].vida -= dano; // Aplicar el daño al jugador atacado
                }
            }
        }
        imprimirEstadoJugadores(jugadores, 4); // Imprimir el estado de los jugadores después de cada ronda
        ronda++;
    }
    // Imprimir el jugador que gana
    for (int i = 0; i < 4; i++) {
    if (jugadores[i].vida > 0) {
        printf("El jugador %d gana!\n", i+1);
        break;
    }
    }
    // Esperar a que todos los procesos hijos terminen
    for (int i = 0; i < 4; i++) {
        wait(NULL);
    }

    return 0;
}