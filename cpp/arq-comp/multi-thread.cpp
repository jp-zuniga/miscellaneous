#include <cstdlib>
#include <iostream>
#include <pthread.h>
#include <unistd.h>

#define NUM_THREADS 5

void *print_hello(void *threadid) {
  long tid = (long)threadid;

  sleep(tid + 1);
  std::cout << "Starting thread #" << tid << "!\n";

  sleep(tid + 1);
  std::cout << "Ending thread #" << tid << "\n";

  pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
  pthread_t threads[NUM_THREADS];
  int rc;
  long t;
  void *status;

  // too many threads and short sleep() calls
  // in print_hello() lead to a race condition
  // for std::cout calls.

  for (t = 0; t < NUM_THREADS; t++) {
    std::cout << "In main: creating thread #" << t << "\n";

    rc = pthread_create(&threads[t], NULL, print_hello, (void *)t);

    if (rc) {
      std::cout << "ERROR!\nReturn code from pthread_create() is " << rc << "\n";
      exit(-1);
    }
  }

  // makes sure all threads have finished executing
  for (t = 0; t < NUM_THREADS; t++) {
    rc = pthread_join(threads[t], &status);

    if (rc) {
      std::cout << "ERROR!\nReturn code from pthread_join() is " << rc << "\n";
      exit(-1);
    }

    std::cout << "Thread #" << t << " joined with main with a status of "
              << (long)status << "\n";
  }

  sleep(3);
  std::cout << "Ending main()" << std::endl;

  // last thing that main() should do
  pthread_exit(NULL);
}
