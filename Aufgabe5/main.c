#include <pthread.h>

struct thread_args {
	unsigned int start, end;
	double **matOldValues, **matNewValues;
};

pthread_barrier_t bbegin, bend;
double dResiduum, temp;

void* thread_func(void* args)
{
	struct thread_args arg = *((struct thread_args*) args);
	double** matOldValues = arg.matOldValues;
	double** matNewValues = arg.matNewValues;
	int i, j, t;

	for(t=0, t<MAX_ITER, t++) {
		for(i = arg.start; i < arg.end; i++) {
			for(j = 1; j < M+1; j++) {
				matNewValues[i][j] = 0.25 * (matOldValues[i-1][j] +
								matOldValues[i+1][j] +
								matOldValues[i][j-1] +
								matOldValues[i][j+1]);
			}
		}
		
		if (t % RES_STEPS == 0) {
			pthread_barrier_wait(&bbegin);
			dResiduum = calc_residual(matNewValues, matOldValues);
			if (dResiduum <= Epsilon) {
				t++;
				break;
			}
		}

		swap_matrices(&(arg.matNewValues), &(arg.matOldValues));
		pthread_barrier_wait(&bend);
	}

	return NULL;
}

int main(int argc, char** argv)
{
	int i;
	double** matOldValues;
	double** matNewValues;

	init(&matNewValues, &matOldValues);
	pthread_barrier_init(&bbegin, NULL, MAX_THREADS);
	pthread_barrier_init(&bend, NULL, MAX_THREADS);

	pthread_t threads[MAX_THREADS];
	struct thread_args[MAX_THREADS];

	for(i = 0; i < MAX_THREADS; i++) {
		thread_args[i].start = i * N/MAX_THREADS + 1;
		thread_args[i].end = (i+1) * N/MAX_THREADS + 1;	
		thread_args[i].matOldValues = matOldValues;
		thread_args[i].matNewValues = matNewValues;

		pthread_create(&threads[i], NULL, thread_func, &thread_args[i]);
	}
	
	for(i = 0; i < MAX_THREADS; i++) {
		pthread_join(threads[i], NULL);
	}

	pthread_barrier_destroy(&bbegin);
	pthread_barrier_destroy(&bend);

	return 0;
}
