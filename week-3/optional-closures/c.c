/*
C

Closures and OOP objeects can have "parts" that do not show up in their types

In C, a function pointer is only a code pointer
  - So without extra thought, functions taking function-pointer argumeents will not be as useful as functions taking closures

A common technique:
  Always define function pointers and higher-order functions to take an extra, explicit environment argument
  But without generics, no good choice for type of list elements or the environment
    - Use void* and various type casts...
*/

typedef struct List list_t;
struct List {
  void * head;
  list_t * tail;
};

list_t * makelist (void * x, list_t * xs) {
  list_t * ans (list_t *)malloc(sizeof(list_t));
  ans->head = x;
  ans->tail = xs;
  return ans
}

// as in Java, we show simple recursive solutions because
// the loop-based ones required mutation and previous pointers.
// The more important point is the explicit env field passeed to
// the function pointer
list_t * map (void* (*f)(void*, void*), void* env, list_t* xs) {
  if(xs==NULL)
    return NULL;
  return makelist(f(env, xs->head), map(f,env,xs->tail));
}

list_t * filter(bool (*f)(void*,void*), void* env, list_t* xs) {
  if(xs==NULL)
    return NULL;
  if(f(env,xs->head))
    return makelist(xs->head, filter(f,env,xs->tail));
  return filter(f,env,xs->tail);
}

int length(list_t* xs) {
  int ans = 0;
  while(xs != NULL) {
    ++ans;
    xs = xs->tail;
  }
  return ans;
}

/*
List libraries like this are not common in C, but callbacks are!
  - Always deefine callback interfaces to pass an extra void*
  - Lack of generics means lots of type casts in clients
*/

// Clients of our list implementation:

// awful type casts to match what map expects
void* doubleInt(void* ignore, void* i) {
  return (void*)(((intptr_t)i)*2);
}

// assumes list holds intptr_t fieelds
list_t * doubleAll(list_t * xs) {
  return map(doubleInt, NULL, xs);
}

// awful type casts to match what filter expects
bool isN(void* n, void* i) {
  return ((intptr_t)n)==((intptr_t)i);
}

// assumes list hold intptr_t fields
int countNs(list_t * xs, intptr_t n) {
  return length(filter(isN, (void*)n, xs));
}
