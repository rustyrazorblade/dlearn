
import std.stdio;
import std.container;

// T is a vertex type
class TraversalStateManager(T) {

    alias sm = TraversalStateManager!T;

    alias element = Element!T;
    
    T root;

    DList!element[] paths;  // unbounded array of V1->V2->E3 type paths

    this(T vertex) {
        this.root = vertex;
    }

    T[] vertices() {
        T[] result;
        return result;
    }
    // each traversal, filter, or operation should return a new instance of the state manager

    sm outV() {
        // f() returns a list of elements that are outV from e.  
        // traversal returns a new state
        element[] f(element e) {
            element[] result;
            return result;
        }
        return this.traversal(f);
    }


    sm inV() {
        return this;
    }

    sm bothV() {
        return this;
    }
    
    sm outE() {
        return this;
    }

    sm inE() {
        return this;

    }
    sm bothE() {
        return this;

    }

    sm label() {
        // label a step
        return this;
    }

    sm back() {
        // go back to a label
        return this;
    }

    // step to apply to the state manager
    // removes the need for a loop on every action, we can just
    // utilize the step.  pass a lambda.  it will be applied to every
    // path in the current traversal
    alias StepOperation = element[] function(element e);
    private sm traversal(StepOperation f) {
        auto result = new sm(this.root);

        foreach(path; this.paths) {
            auto tail = path.back; // we always operate on the last element
            auto elements = f(tail); // apply f() step operation to the tail element
            if(elements !is null) {
                // null means we couldn't perform the op
                foreach(e; elements) {
                    // we're going to get back a bunch of elements
                    // for each element, we push a new path into the new path manager
                    // SList.dup only duplicates pointers, not the data
                    result.paths[result.paths.length] = path.dup ~ [e];
                }
            }

        }

        return result;
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

    alias edge_list = DList!edge;

    edge_list[T] out_edges;
    edge_list[T] in_edges;

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

    void addEdge(string label, vertex v2) {
        auto e = new edge(label, this, v2);
        
        edge_list* oe; // out edges

        oe = (v2.id in this.out_edges);

        if(oe is null) {
            auto tmp = edge_list();
            oe = &tmp;
            this.out_edges[v2.id] = *oe;
        }
        oe.insert(e);

        // set the in edge
        edge_list* ie; // in edges

        ie = (this.id in v2.in_edges);

        if(ie is null) {
            auto tmp2 = edge_list();
            ie = &tmp2;
            v2.in_edges[this.id] = *ie;
        }
        ie.insert(e);
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

    assert(v1.out_edges.length == 1);
    assert(v1.in_edges.length == 0);

    assert(v2.out_edges.length == 0);
    assert(v2.in_edges.length == 1);
    
    
    auto vertices = v1.query().outV().vertices();

    // this should return an array of vertices
}

void main() {
    writeln("Done.");
}





