#pragma once
 static int base;
//Functions
void knn_reset();
void knn_init( int base_address);
void knn_validin_set();
void knn_validin_reset();
void knn_start();
void knn_stop();

int knn_validout();

uint32_t knn_rd_kn1();
uint32_t knn_rd_kn2();
uint32_t knn_rd_kn3();
uint32_t knn_rd_kn4();
uint32_t knn_rd_kn5();
uint32_t knn_rd_kn6();

uint32_t knn_rd_in1();
uint32_t knn_rd_in2();
uint32_t knn_rd_in3();
uint32_t knn_rd_in4();
uint32_t knn_rd_in5();
uint32_t knn_rd_in6();

void knn_sample_set();

void knn_sample_reset();


#ifdef DEBUG //type make DEBUG=1 to print debug info
#define S 3  //random seed
#define N 128  //data set size
#define K 6   //number of neighbours (K)
#define C 4   //number data classes
#define M 2   //number samples to be classified
#else
#define S 12   
#define N 100000
#define K 10  
#define C 4  
#define M 100 
#endif
//#define INFINITE ~0
struct datum {
  short x;
  short y;
  unsigned char label;
} data[N], x[M];

//neighbor info
struct neighbor {
  uint32_t idx; //index in dataset array
  uint32_t dist; //distance to test point
} neighbor[K];

//#define INFINITE ~0
uint32_t data_wrt=0;

int inc=1;

uint32_t data_wrd[N];

volatile int valid=0;
