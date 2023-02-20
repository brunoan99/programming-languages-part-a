/*
Java
Java 8 scheduled to have closures (like C#, Scala, Ruby, ...)
- Write like xs.map((x) => x.age)
               .filter((x) => x > 21)
              .length()
- Make parallelism and collections much easier
- Encourage less mutation
But how could we program in an ML style without help
  - Will not look like the code above
  - Was even more painful before Java had generics
*/

interface Func<B,A> { B m(A x); }

interface Pred<A> { boolean m(A x); }

/*
An interface is a named [polymoirphic] type
An object with one method can serve as a closure
  - Different instances can have different fields [possibly different types] like different closures can have different environments [possibly different types]
So an interface with one method can serve as a function type

Creating a generic list class works fine
  - Assuming null for empty list here, a choice we may regret
*/
class List<T> {
  T head;
  List<T> tail;
  List(T x, List<T> xs) {
    head = x;
    tail = xs;
  }
  /*
  (*
  Let's use static methods for map, filter, length
  Use our earlier generic interfaces for "function arguments"
  These methods are recursive
     - Less efficient in Java
     - Much simpler than common previous-pointer acrobatics
  *)

  * the advantage of a static method is it lets xs be null
     -- a more OO way would be a subclass for empty list
  * a more efficient way in Java would be a messyt while loop
  where you keep a mutable pointer to the previous element
  */
  static <A,B>List<B> map(Func<B,A> f, List<A> xs) {
    if (xs==null) return null;
    return new List<B>(f.m(xs.head), map(f,xs.tail));
  }
  static <A> list<A> filter(Pred<A> f, List<A> xs) {
    if (xs==null) return null;
    if (f.m(xs.head))
      return new List<A>(xs.head), filter(f,xs.tail);
    return filter(f,xs.tail)
  }
  // * again recursion would be more elegant but less efficient
  // * again an instance method would be more common, but then all client have to special-case null
  static <A> length(List<A>) {
    int ans = 0;
    while(xs != null) {
      ans++;
      xs = xs.tail
    }
    return ans;
  }
}
/*
A more OO aproach would be instance methods:

class List<T> {
  <B> List<B> map (Func<B,T> f) {...}
  List<T> filter(Pred<T> f) {...}
  int length() {...}
}
Can work, but interacts poorly with null for empty list
   - Cannot call a method on null (NullPointerException)
   - So leads to extra cases in a ll clients of these methods if a list might be empty

An even more OO alternative uses a sublcass of List for empty lists rather than null
   - Then instance methods work fine


Clients
- To use map method to make a List<Bar> from a List<Foo>:
  - Define a class C that impelemtns Func<Bar,Foo>
    - UIse fields to hold any "private data"
  - Makes an object of class C, passing private data to constructor
  - Pass the object to map

- As a convenience, can combine all 3 steps with anonymous inner classes
  - Mostly just syntatic sugar
  - But can directly access enclosing fields and final variables
  - Added to language to better support callbacks
  - Syntax an acquired taste?

*/

class ExampleClient {
  static List<Integer> doubleALL(List<Integer> xs) {
    return List.map((new Func<Integer, Integer>() {
      public Integer m(Integer x) {
        return x * 2;
      }}), xs);
  }
  static int countNs(List<Integer> xs, final int n) {
    return List.length(List.filter(
      (new Pred<Integer>() {
        public boolean m(Integer x) { return x==n;}
      }), xs));
  }
}
