#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define HORAS 11

int sum(int* v, int len) {
	int i, tmp = 0;
	for (i = 0; i <= len; i++)
		tmp += v[i];
	return tmp;
}

int main() {
    srand(time(NULL));

    float total = 60.0*HORAS;
    float parcial = 0.0;
    
    int len = 29; // len-1
    int v[] = {1,1,1,1, 2,2,2,2, 4,4,4,4, 12,12,12,12, 13,13,13,13, 20,20,20,20, 15,15,15,15, 10,10,10,10, 8,8,8,8, 3,3,3,3 };
    //int v[] = {1,2,4,5,5,3,2,1};
	
	int i, aa;
	float a, b, res, n;

	int cont = 0;

    while (parcial < total) {
        n = rand()%sum(v, len);
        //printf("n %f\n", n);
        for (i = 0; i <= len; i++) {
        	//printf("%d < %d?\n", n, sum(v, i));
			if (n < sum(v, i)) {
				a = i;
				break;
			}
		}
        
        b = (float)(rand()%100)/100.0;
        //res = a + b;
		res = a + b + 10;

        if (parcial + res > total)
            break;

        parcial += res;
        printf("%.2f ", res);
        cont++;
        if(cont == 30)
        	break;
    }
    //printf("\n cont %d \n", cont);
    return 0;
}
