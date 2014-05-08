
import std.stdio;

/// T is the node pk type.  
class Vertex(T) {
    
    T id;
    string[string] properties;

    Vertex!T[T] out_edges;
    Vertex!T[T] in_edges;
    
    this() {}
    this(T id) {
        this.id = id;
    }

    void addProperty(string k, string v) {
        properties[k] = v;
    }
    T getKey() {
        return id;
    }
    void addEdge(Vertex!T v2) {
        this.out_edges[v2.id] = v2;
        v2.in_edges[this.id] = this;
    }

    
}

class Edge {
    string label;
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
    auto v1 = new IntVertex(1);
    auto v2 = new IntVertex(2);
    v1.addEdge(v2);
}



void main() {
    writeln("Done.");
}





