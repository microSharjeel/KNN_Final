#include "system.h"
#include "periphs.h"
#include <iob-uart.h>
#include "timer.h"
#include "iob_knn.h"
#include "random.h" //random generator for bare metal
#include "printf.h" 
#include "stdint.h"
#include "KNNsw_reg.h"
#include "interconnect.h"

//uncomment to use rand from C lib 
#define cmwc_rand rand
/*********************************NOT USED NOW************/
//square distance between 2 points a and b
//unsigned int sq_dist( struct datum a, struct datum b) {
//  short X = a.x-b.x;
//  unsigned int X2=X*X;
//  short Y = a.y-b.y;
//  unsigned int Y2=Y*Y;
//  return (X2 + Y2);
//}
/*********************************NOT USED NOW************/
//insert element in ordered array of neighbours
/*void insert (struct neighbor element, unsigned int position) {
  for (int j=K-1; j>position; j--)
    neighbor[j] = neighbor[j-1];

  neighbor[position] = element;

}*/
//Base address of KNN HW

int main() {

  unsigned long long elapsed;
  unsigned long long elapsedua;
  unsigned long long elapsedub;

  //init uart and timer
  uart_init(UART_BASE, FREQ/BAUD);
  printf("\nInit timer\n");
  uart_txwait();

  timer_init(TIMER_BASE);
  //read current timer count, compute elapsed time
  //elapsed  = timer_get_count();   
  int votes_acc[C] = {0};
  //generate random seed 
  random_init(S);
   inc=0;
   
  //init dataset
  for (int i=0; i<N; i++) {

    //init coordinates
    data[i].x = (short)cmwc_rand();//10+inc;//cmwc_rand();
    data[i].y = (short)cmwc_rand();//20+inc;//cmwc_rand();
   // inc= inc+10; 
   // printf("x:%d y:%d\n",data[i].x,data[i].y);
    //init label
    data[i].label = (unsigned char) (cmwc_rand()%C);
  }

/*#ifdef DEBUG
  printf("\n\n\nDATASET\n");
  printf("Idx \tX \tY \tLabel\n");
  for (int i=0; i<N; i++)
    printf("%d \t%d \t%d \t%d\n", i, data[i].x,  data[i].y, data[i].label);
#endif*/
  inc=0;
  //init test points
  for (int k=0; k<M; k++) {
    x[k].x  = (short)cmwc_rand();//10;//cmwc_rand();
    x[k].y  = (short)cmwc_rand();//15;//cmwc_rand();
   //  inc= inc+1; 
    //x[k].label will be calculated by the algorithm
  }

//#ifdef DEBUG
//  printf("\n\nTEST POINTS\n");
//  printf("Idx \tX \tY\n");
 // for (int k=0; k<M; k++)
  //  printf("%d \t%d \t%d\n", k, x[k].x, x[k].y);
//#endif
/************************************ NOT REQUIRED NOW, SINCE NEIGHBOURS ARE NOW DECIDED IN FPGA********/
    //init all k neighbors infinite distance
    //for (int j=0; j<K; j++)
      //neighbor[j].dist = INFINITE;

/************************************ START TIMER HERE ********************************/      

// PROCESS DATA

/************************************************* INITIATING KNN H/W GETTING IT BASE ADDRESS AND SENDING SOFT RESET***
*************/
  elapsedua = timer_time_usec();
  knn_init( KNN_BASE);
// WRITE DATA TO FPGA ONLY ONCE FOR ALL TEST POINTS . NOT USED NOW COMMENTED OUT//////////////
  
 // data_wrd = 0;
  /*for(int i=0;i<N;i++)
  {
   data_wrd = 0;
   data_wrd = data[i].x;
  // printf("val1:%d\n",data_wrd);
   data_wrd <<=16;
  // printf("val2:%d\n",data_wrd);
   data_wrd |= data[i].y;
  // printf("val3:%d\n",data_wrd);
  knn_validin_set();
   IO_SET(base,KNN_DATA_PT,data_wrd);
    knn_validin_reset();
   
     }*/
/********************************WRITING DATA POINTS IN ARRAY. EACH ELEMENT OF ARRAY HAS 32 BIT FIRST [31:16]
    ARE FOR X CO-ORDINATE AND 15:0 ARE FOR Y CO-ORDINATE*******************/ 
   for(int i=0;i<N;i++)
  {
   data_wrd[i] = data[i].x;
   data_wrd[i] <<=16;
   data_wrd[i] |= data[i].y;
   }
/**************************WRITING DATA POINTS AND VALID IN SIGNAL TO FPGA***************/  
   IO_SET(base,KNN_DATA_PT0,data_wrd[0]);
   IO_SET(base,KNN_DATA_PT1,data_wrd[1]);
   IO_SET(base,KNN_DATA_PT2,data_wrd[2]);
   IO_SET(base,KNN_DATA_PT3,data_wrd[3]); 
   IO_SET(base,KNN_DATA_PT4,data_wrd[4]);
   IO_SET(base,KNN_DATA_PT5,data_wrd[5]);
   IO_SET(base,KNN_DATA_PT6,data_wrd[6]);
   IO_SET(base,KNN_DATA_PT7,data_wrd[7]); 
   
   IO_SET(base,KNN_DATA_PT8,data_wrd[8]);
   IO_SET(base,KNN_DATA_PT9,data_wrd[9]);
   IO_SET(base,KNN_DATA_PT10,data_wrd[10]);
   IO_SET(base,KNN_DATA_PT11,data_wrd[11]); 
   IO_SET(base,KNN_DATA_PT12,data_wrd[12]);
   IO_SET(base,KNN_DATA_PT13,data_wrd[13]);
   IO_SET(base,KNN_DATA_PT14,data_wrd[14]);
   IO_SET(base,KNN_DATA_PT15,data_wrd[15]); 
   
   IO_SET(base,KNN_DATA_PT16,data_wrd[16]);
   IO_SET(base,KNN_DATA_PT17,data_wrd[17]);
   IO_SET(base,KNN_DATA_PT18,data_wrd[18]);
   IO_SET(base,KNN_DATA_PT19,data_wrd[19]); 
   IO_SET(base,KNN_DATA_PT20,data_wrd[20]);
   IO_SET(base,KNN_DATA_PT21,data_wrd[21]);
   IO_SET(base,KNN_DATA_PT22,data_wrd[22]);
   IO_SET(base,KNN_DATA_PT23,data_wrd[23]); 
   
   IO_SET(base,KNN_DATA_PT24,data_wrd[24]);
   IO_SET(base,KNN_DATA_PT25,data_wrd[25]);
   IO_SET(base,KNN_DATA_PT26,data_wrd[26]);
   IO_SET(base,KNN_DATA_PT27,data_wrd[27]); 
   IO_SET(base,KNN_DATA_PT28,data_wrd[28]);
   IO_SET(base,KNN_DATA_PT29,data_wrd[29]);
   IO_SET(base,KNN_DATA_PT30,data_wrd[30]);
   IO_SET(base,KNN_DATA_PT31,data_wrd[31]);
   
   IO_SET(base,KNN_DATA_PT32,data_wrd[32]);
   IO_SET(base,KNN_DATA_PT33,data_wrd[33]);
   IO_SET(base,KNN_DATA_PT34,data_wrd[34]);
   IO_SET(base,KNN_DATA_PT35,data_wrd[35]); 
   IO_SET(base,KNN_DATA_PT36,data_wrd[36]);
   IO_SET(base,KNN_DATA_PT37,data_wrd[37]);
   IO_SET(base,KNN_DATA_PT38,data_wrd[38]);
   IO_SET(base,KNN_DATA_PT39,data_wrd[39]);
   
   IO_SET(base,KNN_DATA_PT40,data_wrd[40]);
   IO_SET(base,KNN_DATA_PT41,data_wrd[41]);
   IO_SET(base,KNN_DATA_PT42,data_wrd[42]);
   IO_SET(base,KNN_DATA_PT43,data_wrd[43]); 
   IO_SET(base,KNN_DATA_PT44,data_wrd[44]);
   IO_SET(base,KNN_DATA_PT45,data_wrd[45]);
   IO_SET(base,KNN_DATA_PT46,data_wrd[46]);
   IO_SET(base,KNN_DATA_PT47,data_wrd[47]);
   
   IO_SET(base,KNN_DATA_PT48,data_wrd[48]);
   IO_SET(base,KNN_DATA_PT49,data_wrd[49]);
   IO_SET(base,KNN_DATA_PT50,data_wrd[50]);
   IO_SET(base,KNN_DATA_PT51,data_wrd[51]); 
   IO_SET(base,KNN_DATA_PT52,data_wrd[52]);
   IO_SET(base,KNN_DATA_PT53,data_wrd[53]);
   IO_SET(base,KNN_DATA_PT54,data_wrd[54]);
   IO_SET(base,KNN_DATA_PT55,data_wrd[55]);
   
   IO_SET(base,KNN_DATA_PT56,data_wrd[56]);
   IO_SET(base,KNN_DATA_PT57,data_wrd[57]);
   IO_SET(base,KNN_DATA_PT58,data_wrd[58]);
   IO_SET(base,KNN_DATA_PT59,data_wrd[59]); 
   IO_SET(base,KNN_DATA_PT60,data_wrd[60]);
   IO_SET(base,KNN_DATA_PT61,data_wrd[61]);
   IO_SET(base,KNN_DATA_PT62,data_wrd[62]);
   IO_SET(base,KNN_DATA_PT63,data_wrd[63]);
   
   IO_SET(base,KNN_DATA_PT64,data_wrd[64]);
   IO_SET(base,KNN_DATA_PT65,data_wrd[65]);
   IO_SET(base,KNN_DATA_PT66,data_wrd[66]);
   IO_SET(base,KNN_DATA_PT67,data_wrd[67]); 
   IO_SET(base,KNN_DATA_PT68,data_wrd[68]);
   IO_SET(base,KNN_DATA_PT69,data_wrd[69]);
   IO_SET(base,KNN_DATA_PT70,data_wrd[70]);
   IO_SET(base,KNN_DATA_PT71,data_wrd[71]);
   
   IO_SET(base,KNN_DATA_PT72,data_wrd[72]);
   IO_SET(base,KNN_DATA_PT73,data_wrd[73]);
   IO_SET(base,KNN_DATA_PT74,data_wrd[74]);
   IO_SET(base,KNN_DATA_PT75,data_wrd[75]); 
   IO_SET(base,KNN_DATA_PT76,data_wrd[76]);
   IO_SET(base,KNN_DATA_PT77,data_wrd[77]);
   IO_SET(base,KNN_DATA_PT78,data_wrd[78]);
   IO_SET(base,KNN_DATA_PT79,data_wrd[79]);
   
   IO_SET(base,KNN_DATA_PT80,data_wrd[80]);
   IO_SET(base,KNN_DATA_PT81,data_wrd[81]);
   IO_SET(base,KNN_DATA_PT82,data_wrd[82]);
   IO_SET(base,KNN_DATA_PT83,data_wrd[83]); 
   IO_SET(base,KNN_DATA_PT84,data_wrd[84]);
   IO_SET(base,KNN_DATA_PT85,data_wrd[85]);
   IO_SET(base,KNN_DATA_PT86,data_wrd[86]);
   IO_SET(base,KNN_DATA_PT87,data_wrd[87]);
   
   IO_SET(base,KNN_DATA_PT88,data_wrd[88]);
   IO_SET(base,KNN_DATA_PT89,data_wrd[89]);
   IO_SET(base,KNN_DATA_PT90,data_wrd[90]);
   IO_SET(base,KNN_DATA_PT91,data_wrd[91]); 
   IO_SET(base,KNN_DATA_PT92,data_wrd[92]);
   IO_SET(base,KNN_DATA_PT93,data_wrd[93]);
   IO_SET(base,KNN_DATA_PT94,data_wrd[94]);
   IO_SET(base,KNN_DATA_PT95,data_wrd[95]);
   
   IO_SET(base,KNN_DATA_PT96,data_wrd[96]);
   IO_SET(base,KNN_DATA_PT97,data_wrd[97]);
   IO_SET(base,KNN_DATA_PT98,data_wrd[98]);
   IO_SET(base,KNN_DATA_PT99,data_wrd[99]); 
   IO_SET(base,KNN_DATA_PT100,data_wrd[100]);
   IO_SET(base,KNN_DATA_PT101,data_wrd[101]);
   IO_SET(base,KNN_DATA_PT102,data_wrd[102]);
   IO_SET(base,KNN_DATA_PT103,data_wrd[103]);
   
   IO_SET(base,KNN_DATA_PT104,data_wrd[104]);
   IO_SET(base,KNN_DATA_PT105,data_wrd[105]);
   IO_SET(base,KNN_DATA_PT106,data_wrd[106]);
   IO_SET(base,KNN_DATA_PT107,data_wrd[107]); 
   IO_SET(base,KNN_DATA_PT108,data_wrd[108]);
   IO_SET(base,KNN_DATA_PT109,data_wrd[109]);
   IO_SET(base,KNN_DATA_PT110,data_wrd[110]);
   IO_SET(base,KNN_DATA_PT111,data_wrd[111]);
   
   IO_SET(base,KNN_DATA_PT112,data_wrd[112]);
   IO_SET(base,KNN_DATA_PT113,data_wrd[113]);
   IO_SET(base,KNN_DATA_PT114,data_wrd[114]);
   IO_SET(base,KNN_DATA_PT115,data_wrd[115]); 
   IO_SET(base,KNN_DATA_PT116,data_wrd[116]);
   IO_SET(base,KNN_DATA_PT117,data_wrd[117]);
   IO_SET(base,KNN_DATA_PT118,data_wrd[118]);
   IO_SET(base,KNN_DATA_PT119,data_wrd[119]);
   
   IO_SET(base,KNN_DATA_PT120,data_wrd[120]);
   IO_SET(base,KNN_DATA_PT121,data_wrd[121]);
   IO_SET(base,KNN_DATA_PT122,data_wrd[122]);
   IO_SET(base,KNN_DATA_PT123,data_wrd[123]); 
   IO_SET(base,KNN_DATA_PT124,data_wrd[124]);
   IO_SET(base,KNN_DATA_PT125,data_wrd[125]);
   IO_SET(base,KNN_DATA_PT126,data_wrd[126]);
   IO_SET(base,KNN_DATA_PT127,data_wrd[127]);

   IO_SET(base,KNN_VALID_IN,1);
   
  for (int k=0; k<M; k++) { 
	  //for all test points
	  //compute distances to dataset points

	#ifdef DEBUG
	    printf("\n\nProcessing x[%d]:\n", k);
	#endif
	#ifdef DEBUG
	    printf("Datum \tX \tY \tLabel \tDistance\n");
	#endif
	/*************************WRITING TEST POINT TO FPGA***************/
	IO_SET(base,KNN_VALID_IN,0);
	data_wrt=0;
	data_wrt = x[k].x;
	data_wrt <<=16;
	data_wrt |= x[k].y;
	IO_SET(base,KNN_TEST_PT,data_wrt);
	/******************************WRITING START FSM SIGMNAL TO FPGA*****/
	IO_SET(base,KNN_START,1); 
	/******************************POLLING FOR VALID OUT SIGNAL*********/
	  valid=0;	
	   while(1)
	   {
	   	valid = (int)IO_GET(base,KNN_VALID_OUT);
	   	if(valid)
	          break;
	   }
	/******************READING VALUES OF NEIGHBOURS AND THEIR INDEXS ********/  
	knn_sample_set();
	neighbor[0].dist = knn_rd_kn1();
   	neighbor[1].dist = knn_rd_kn2();
   	neighbor[2].dist = knn_rd_kn3();
	neighbor[3].dist = knn_rd_kn4();
	neighbor[4].dist = knn_rd_kn5();
   	neighbor[5].dist = knn_rd_kn6();
   	   
   	neighbor[0].idx = knn_rd_in1();
   	neighbor[1].idx = knn_rd_in2();
   	neighbor[2].idx = knn_rd_in3();
	neighbor[3].idx = knn_rd_in4();
	neighbor[4].idx = knn_rd_in5();
   	neighbor[5].idx = knn_rd_in6();
        knn_sample_reset();
	knn_stop();
	/********************NOT USED HERE ACCELERATED IN H/W--> EUCLIDEAN DISTANCE CALCULATION AND SORTING***********  
	    for (int i=3; i<N; i++) { 
	    
	    //for all dataset points
	    //compute distance to x[k]
	    //  unsigned int d = sq_dist(x[k], data[i]);   
	    //insert in ordered list
	    //for (int j=0; j<K; j++)
	     //   if ( distance[i] < neighbor[j].dist ) 
	      //  {
	       //  insert( (struct neighbor){i,distance[i]}, j);
	        // break;
	        //} 

	#ifdef DEBUG
	  // dataset
	      printf("%d \t%d \t%d \t%d \t%u\n", i, data[i].x, data[i].y, data[i].label, (uint32_t)neighbor[i].dist);
	#endif

	    }*/
	      
	    //classify test point

	    //clear all votes
	    int votes[C] = {0};
	    int best_votation = 0;
	    int best_voted = 0;

	    //make neighbours vote
	    for (int j=0; j<K; j++) { //for all neighbors
	      if ( (++votes[data[neighbor[j].idx].label]) > best_votation ) {
		best_voted = data[neighbor[j].idx].label;
		best_votation = votes[best_voted];
	      }
    	}

	    x[k].label = best_voted;

	    votes_acc[best_voted]++;
	    
	#ifdef DEBUG
	    printf("\n\nNEIGHBORS of x[%d]=(%d, %d):\n", k, x[k].x, x[k].y);
	    printf("K \tIdx \tX \tY \tDist \t\tLabel\n");
	    for (int j=0; j<K; j++)
	      printf("%d \t%d \t%d \t%d \t%d \t%d\n", j+1, neighbor[j].idx, data[neighbor[j].idx].x,  data[neighbor[j].idx].y, 				neighbor[j].dist,  data[neighbor[j].idx].label);
	    
	    printf("\n\nCLASSIFICATION of x[%d]:\n", k);
	    printf("X \tY \tLabel\n");
	    printf("%d \t%d \t%d\n\n\n", x[k].x, x[k].y, x[k].label);

	#endif

  } //all test points classified

  //stop knn here
  //read current timer count, compute elapsed time
  /******************READING TIMER COUNT****************************/
  elapsedub = timer_time_usec();
  printf("\nExecution time: Start Time of KNN %llu us \n Completion time of KNN %llu us. Execution time of KNN %llu us @%dMHz\n\n",
   elapsedua,elapsedub,(elapsedub-elapsedua), FREQ/1000000);

  
  //print classification distribution to check for statistical bias
  for (int l=0; l<C; l++)
    printf("%d ", votes_acc[l]);
  printf("\n");
 return 0; 
}
/********************************************/
// functions definitions
void knn_reset()
{
  IO_SET(base, KNN_RESET, 1);
  IO_SET(base, KNN_RESET, 0);	
}

void knn_init( int base_address)
{
  base = base_address;
  knn_reset();
  knn_validin_reset();
}

void knn_validin_set()
{
 IO_SET(base,KNN_VALID_IN,1);
}

void knn_validin_reset()
{
 IO_SET(base,KNN_VALID_IN,0);
}

void knn_start()
{
 IO_SET(base,KNN_START,1);
 	
}

void knn_stop()
{
 IO_SET(base,KNN_START,0);	
}

 int   knn_validout ()
{
 return (int)IO_GET(base,KNN_VALID_OUT);	
}

uint32_t knn_rd_kn1()
{
  return (uint32_t) IO_GET(base,KNN_KN1); 
}

uint32_t knn_rd_kn2()
{
  return (uint32_t) IO_GET(base,KNN_KN2); 
}

uint32_t knn_rd_kn3()
{
  return (uint32_t) IO_GET(base,KNN_KN3); 
}

uint32_t knn_rd_kn4()
{
  return (uint32_t) IO_GET(base,KNN_KN4); 
}

uint32_t knn_rd_kn5()
{
  return (uint32_t) IO_GET(base,KNN_KN5); 
}

uint32_t knn_rd_kn6()
{
  return (uint32_t) IO_GET(base,KNN_KN6); 
}


uint32_t knn_rd_in1()
{
  return (uint32_t) IO_GET(base,KNN_IN1); 
}

uint32_t knn_rd_in2()
{
  return (uint32_t) IO_GET(base,KNN_IN2); 
}

uint32_t knn_rd_in3()
{
  return (uint32_t) IO_GET(base,KNN_IN3); 
}

uint32_t knn_rd_in4()
{
  return (uint32_t) IO_GET(base,KNN_IN4); 
}

uint32_t knn_rd_in5()
{
  return (uint32_t) IO_GET(base,KNN_IN5); 
}

uint32_t knn_rd_in6()
{
  return (uint32_t) IO_GET(base,KNN_IN6); 
}

void knn_sample_set()
{
 IO_SET(base,KNN_SAMPLE,1);	
}

void knn_sample_reset()
{
 IO_SET(base,KNN_SAMPLE,0);	
}


