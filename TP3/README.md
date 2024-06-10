# Trabajo Practico N°3 - Mateo Delgado Costa
1. a) El tiempo de la primera ejecucion de ambos archivos es de 6.5 segundos aprox. Luego disminuyen, en mi caso, 1 segundo teniendo minimas diferencias en las siguientes ejecuciones.

  b) Los tiempos de ejecucion son muy similares con otros compañeros.

  c) El código original produce un resultado final de 0. Cuando descomentamos las líneas, el resultado varía entre números negativos y positivos. Después de descomentar las líneas mencionadas, el tiempo de ejecución aumenta considerablemente, llegando hasta los 4 segundos. Esto se debe a un incremento en la cantidad de condiciones de carrera (race conditions) en la zona crítica del algoritmo. Las líneas descomentadas introducían pequeñas pausas, lo que facilitaba la alternancia entre los hilos y reducía las condiciones de carrera. Sin estas pausas, los hilos acceden y modifican el acumulador con menos interrupciones, aumentando las condiciones de carrera y, por lo tanto, el tiempo de ejecución.

2. a)
```
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0;

void *comer_hamburguesa(void *tid)
{
    while (1 == 1)
    { 
        while (turno != (int) tid);
        // INICIO DE LA ZONA CRÍTICA
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int) tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
        	turno = (turno + 1) % NUMBER_OF_THREADS;
            pthread_exit(NULL); // forzar terminacion del hilo
        }
        // SALIDA DE LA ZONA CRÍTICA
		turno = (turno + 1) % NUMBER_OF_THREADS;   
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
    }
    pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}
```

c)
![2c](https://github.com/zCosmi/ASO2024TPs/assets/150198701/d9e83ac5-380d-4bcf-92ee-7f5c7cd8beda)