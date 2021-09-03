#include <SDL2/SDL.h>

#include "common.hh"

int main(void)
{
    fprintf(stderr, "hello sample\n");
    SDL_Init(SDL_INIT_VIDEO);

    return 0;
}
