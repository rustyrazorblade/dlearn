
import std.stdio;
import std.container;

// T is a vertex type
class TraversalStateManager(T) {

    alias sm = TraversalStateManager!T;

    alias element = Element!T;
    
    T root;
    element[][] paths;

    this(T vertex) {
        this.root = vertex;
    }
    this(T vertex, element[][] paths) {
        this.root = vertex;
        this.paths = paths;
    }
    // each traversal, filter, or operation should return a new instance of the state manager

    // ?
    sm outV() {
        return this;
    }

    sm inV() {
        return this;
    }

    // step to apply to the state manager
    // removes the need for a loop on every action, we can just
    // utilize the step.  pass a lambda.  it will be applied to every
    // path in the current traversal
    alias StepOperation = element[] function(element vertex);
    private sm traversal(StepOperation f) {
        element[][] paths;
        foreach(element[] p; this.paths) {
            // need to look at the tail of p
            //paths ~= f(p);
        }
        return new sm(this.root, paths);
    }

}

class Element(T) {

}

/// T is the node pk type.  
class Vertex(T) : Element!T {
    
    T id;
    string[string] properties;

    // using the T as index for edge so we can quickly tell if we have edge to specific nodes
    // trading off memory for speed
    // there can be many edges
    alias vertex = Vertex!T;

    // the edge needs the typed vertex so we alias it
    alias edge = Edge!vertex;

    alias traversal = TraversalStateManager!vertex;

    DList!edge[] out_edges;
    DList!edge[] in_edges;

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

    void addEdge(string label, Vertex!T v2) {
        auto e = new edge(label, this, v2);
        
        this.out_edges[v2.id].insert(e);
        v2.in_edges[this.id].insert(e);
    }

    traversal query() {
        return new traversal(this);
    }
}

class Edge(T) : Element!T {

    string label;
    T in_v, out_v;

    this(string label, T in_v, T out_v) {
        this.label = label;
        this.in_v = in_v;
        this.out_v = out_v;
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
    Vertex!U addVertex(U id) {
        auto v = new Vertex!U(id);
        this.put(v);
        return v;
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
    v1.addEdge("knows", v2);
}

unittest {
    // set up a simple graph
    auto g = new Graph!IntVertex();
    auto v1 = g.addVertex(1);
    auto v2 = g.addVertex(2);
    v1.addEdge("knows", v2);
    
    v1.query().outV().inV();
}

void main() {
    writeln("Done.");
}





