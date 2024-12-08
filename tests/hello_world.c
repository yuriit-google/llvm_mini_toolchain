#include <stdio.h>

int main() {
  //test();
  printf("Hello C world!\n");

  FILE *fp;
  char *filename = "/tmp/hello_world.txt";

  fp = fopen(filename, "w");

  if (fp == NULL) {
    printf("Could not open file %s\n", filename);
    return 1;
  }

  fprintf(fp, "Hello C world!\n");
  fclose(fp);

  return 0;
}
