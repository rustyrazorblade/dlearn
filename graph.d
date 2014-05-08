
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
}


class Graph(V : Vertex!U, U) {
    //Vertex[K] nodes;

    void put(Vertex!U node) {
        //auto key = node.getKey();
        //this.nodes[key] = node;
    }
    //V get(K key) {
     //   return this.nodes.get(key, null);
    //}
}

class SimpleNode : Vertex!int {

    /// make sure get by key works
    unittest {
        auto g = new Graph!(SimpleNode)();

        //g.put(new SimpleNode(1));

        //auto n = g.get(1);

        // if we request a non existing key we get back null
        //auto n2 = g.get(2);
        //assert(n2 is null);
    }

    unittest {
        auto g = new Graph!(SimpleNode)();
        //auto n1 = new SimpleNode(1);
        //g.put(n1);
        //auto n2 = new SimpleNode(2);
        //g.put(n2);



    }

}

void main() {
    writeln("Done.");
}





