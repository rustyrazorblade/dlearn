
import std.stdio;


class Tree {
    Node root;

    void add(int value) {
        if(root is null) {
            root = new Node(value);
            return;
        }
        Node n = root;
        while(true) {
            if(n.value == value) {
                // already exists
                return;
            }
            auto dir = cast(int) (value > n.value); 
            if(n.links[dir] is null) {
                n.links[dir] = new Node(value);
                return;
            }
        }
        
    }

    unittest {
        auto t = new Tree();
        t.add(10);
    }

    Node get(int value) {
        Node n = root;
        while(true) {
            if(n is null) {
                return null;
            } 
            if(n.value == value) {
                return n;
            }
            auto dir = cast(int) (value > n.value);
            n = n.links[dir];
        }

    }

    /// demonstrates that the proper node is returned for a get
    unittest {
        auto t = new Tree();
        auto n = t.get(10);
        assert(n is null);

        t.add(10);
        n = t.get(10);
        assert(n !is null);

        t.add(11);
        Node n2 = t.get(11);
        assert(n !is null);

        assert(n.links[1].value == 11);

    }

}

class Node {
    int value;
    Node[2] links;

    this(int value) {
        this.value = value;
    }

}


void main() {

}
