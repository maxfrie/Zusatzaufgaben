#include <stdlib.h>
#include <stdio.h>

extern int parseStr(char* src, char** p_dest);

int main(int argc, char* argv[])
{
	char* msg = "aa12F_:101";
	char* p_dest;

	int laenge = parseStr(msg, &p_dest);
	printf("Summe: %d\n", laenge);
	printf("%s\n", p_dest);

	return 0;
}

//Hier wollte ich etwas hinzufügen
