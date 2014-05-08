
import std.stdio;

/// T is the node type.  
class Vertex(T) {
    
    T id;
    
    this() {}
    this(T id) {
        this.id = id;
    }

    void addProperty(string k, string v) {

    }
    T getKey() {
        return id;
    }
}


/// U is the Vertex key type
class Graph(V : Vertex!U, U) {
    V[U] nodes;

    void put(Vertex!U node) {
        auto key = node.getKey();
        this.nodes[key] = node;
    }
    V get(U key) {
        return this.nodes.get(key, null);
    }
}


alias IntVertex = Vertex!int;
alias StringVertex = Vertex!int;

/// make sure get by key works
unittest {
    auto g = new Graph!(IntVertex)();
    auto n = new IntVertex(1);
    n.addProperty("test", "value");

    g.put(new IntVertex(1));

    auto n1 = g.get(1);

    assert(n1 !is null);
    // if we request a non existing key we get back null
    auto n2 = g.get(2);
    assert(n2 is null);
}

unittest {
    auto g = new Graph!(IntVertex)();
    //auto n1 = new SimpleNode(1);
    //g.put(n1);
    //auto n2 = new SimpleNode(2);
    //g.put(n2);



}


void main() {
    writeln("Done.");
}





