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

    
    // use a delegate to access the previous context 
    void do_more_stuff() {
        int a = 1;
        void f() {
            a = 2;
            writeln("HI", a);
        }
        do_more_stuff2(&f); 
    }

    void do_more_stuff2(void delegate () f) {
        f();
    }
}

void main() {
    auto t = new Test();
    t.do_stuff();
    t.do_more_stuff();
}

