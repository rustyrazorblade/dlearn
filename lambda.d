import std.stdio;

class Test {
    
    void do_stuff() {
        static void f() {
            writeln("HI");
        }
        do_stuff2(&f); // lambda.d(9): Error: function lambda.Test.do_stuff2 (void function() f) is not callable using argument types (void)
    }

    void do_stuff2(void function () f) {
        f();
    }

}

void main() {
    auto t = new Test();
    t.do_stuff();
}

