#include <stdlib.h>
#include <stdio.h>

extern void scalar_product_sse(float *x,float *y, int veclength, float* ergebnis);

//float ergebnis;

int main(int argc, char** argv)
{
	float x[] = {1.5f, 2.5f, 3.5f, 4.5f};
	float y[] = {1.0f, 2.0f, 3.0f, 4.0f};
	float ergebnis;

	scalar_product_sse(x, y, 4, &ergebnis);
	printf("Result: %f\n", ergebnis);

	return 0;
}
