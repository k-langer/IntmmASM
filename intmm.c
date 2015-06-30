/* Stanford IntMM
    Playing around with the inner loop
    Basically just learning x86 assembly
    Have the loop down to 8 instructions
    Not faster than OFast =)
*/ 

#include <stdio.h>
#include <stdlib.h>
    /* Intmm, Mm */
#define rowsize      400
    /* global */
    /* Intmm, Mm */
int   ima[rowsize+1][rowsize+1], imb[rowsize+1][rowsize+1], imr[rowsize+1][rowsize+1];
int seed; 
void Initrand () {
    seed = 74755L;   /* constant to long WR*/
}
int Rand () {
    seed = (seed * 1309L + 13849L) & 65535L;  /* constants to long WR*/
    return( (int)seed );     /* typecast back to int WR*/
}
    /* Multiplies two integer matrices. */
void Initmatrix (int m[rowsize+1][rowsize+1]) {
    int temp, i, j;
    for ( i = 1; i <= rowsize; i++ )
        for ( j = 1; j <= rowsize; j++ ) {
        temp = Rand();
        m[i][j] = temp - (temp/120)*120 - 60;
    }
}
void Innerproduct( int *result, int a[rowsize+1][rowsize+1], int b[rowsize+1][rowsize+1], int row, int column) {
    /* computes the inner product of A[row,*] and B[*,column] */
    int i;
    *result = 0;
    for(i = 1; i <= rowsize; i++ )*result = *result+a[row][i]*b[i][column];
}
void InnerproductPASM( int *result, int a[rowsize+1][rowsize+1], int b[rowsize+1][rowsize+1], int row, int column) {
    /* computes the inner product of A[row,*] and B[*,column] */
    int i,ai,bi;
    *result = 0;
    char * a_ptr = (char*) *a;  
    char * b_ptr = (char*) *b; 
    a_ptr += 4*((rowsize+1)*row);
    b_ptr += 4*column; 
    int * endcnt = (int*) (rowsize*4 + a_ptr); 
    int mul; 
    do {
        a_ptr += 4; 
        b_ptr += 4*(rowsize+1); 
        ai = *a_ptr; 
        bi = *b_ptr;
        mul = ai*bi;
        *result += mul;  
    } while ((int*)(a_ptr) < endcnt);
}
void InnerproductASM( int *result, int a[rowsize+1][rowsize+1], int b[rowsize+1][rowsize+1], int row, int column) {
    /* computes the inner product of A[row,*] and B[*,column] */
    int i,ai,bi;
    *result = 0;
    char * a_ptr = (char*) *a;  
    char * b_ptr = (char*) *b; 
    a_ptr += 4*((rowsize+1)*row);
    b_ptr += 4*column; 
    int a_const = 4; 
    int b_const = 4*(rowsize+1); 
    int * endcnt = (int*) (rowsize*4 + a_ptr); 
    int mul; 
        asm volatile (
             "xor %%r9,%%r9\n\t"
             "inner: "
             "addq $4, %%rbx\n\t"
             "addq %%rdi, %%rcx\n\t"
             "movl (%%rbx),%%r8d\n\t"
             "movl (%%rcx),%%eax\n\t" 
             "imull %%r8d\n\t"
             "addl %%eax,%%r9d\n\t"
             "cmp %%esi,%%ebx\n\t"
             "jl inner\n\t"
             "mov %%r9d,%%edx"
             :"=d"(*result)
             :"b"(a_ptr), "c"(b_ptr), "D"(b_const), "S"(endcnt)    
             :  
         );
    asm volatile ( "nop" : : : "rax","rbx","rcx","r8","rdx" );
}
void Intmm (int run) {
    int i, j;
    Initrand();
    Initmatrix (ima);
    Initmatrix (imb);
    for ( i = 1; i <= rowsize; i++ )
        for ( j = 1; j <= rowsize; j++ )
          InnerproductASM(&imr[i][j],ima,imb,i,j);
    printf("%d\n", imr[run+1][run+1]);
}
int main()
{
    int i;
    for (i = 0; i < 10; i++) 
    Intmm(i);
    return 0;
}
