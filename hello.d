
import std.stdio;


class Tree {
    Node root;

    /// returns null if the node already exists
    Node add(int value) {
        debug writeln("Adding ", value);
        if(root is null) {
            root = new Node(value);
            return root;
        }
        Node n = root;
        Node parent = null;
        while(true) {
            if(n.value == value) {
                // already exists
                return null;
            }
            auto dir = cast(int) (value > n.value); 
            debug writeln("branching ", dir);

            if(n.links[dir] is null) {
                debug writeln("Position found, child of ", n.value);
                auto new_node = new Node(value);
                new_node.parent = n;
                n.links[dir] = new_node;
                return new_node;
            }
            n = n.links[dir];
        }
        
    }

    unittest {
        debug writeln("basic tree check");

        auto t = new Tree();
        auto n = t.add(10);
        assert(n.parent is null);

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
        debug writeln("get and child checks");
        auto tree = new Tree();
        auto n = tree.get(10);
        assert(n is null);

        auto ten = tree.add(10);
        n = tree.get(10);

        assert(n !is null);
        assert(ten is n);

        auto eleven = tree.add(11);
        Node n2 = tree.get(11);
        assert(n !is null);

        assert(n.links[1].value == 11);
        assert(n.links[1] is eleven);
        
        assert(eleven.parent is ten);
        
    }

}

class Node {
    int value;
    Node[2] links;
    Node parent;

    this(int value) {
        this.value = value;
    }

    void rotate(int dir) {
        // normalize the terms
        // dir lets us treat rotations as left always
        auto left = dir;
        auto right = cast(int) !dir;

        auto left_child = links[left];
        auto right_child = links[right];

        auto grand_child = right_child.links[left];

        links[right] = grand_child;

        if(grand_child !is null) {
            grand_child.parent = this;
        }

        right_child.parent = parent;
        right_child.links[left] = this;

        if(parent) {
            parent.links[left] = right_child;
            
            // has to be last or weird shit happens
            parent = right_child;
        }

    }

    /// left rotation
    unittest {
        writeln("rotation check");

        auto tree = new Tree();
        auto fifteen = tree.add(15);
        auto eight = tree.add(8);
        auto seven = tree.add(7);
        auto eleven = tree.add(11);
        auto ten = tree.add(10);
        auto twelve = tree.add(12);

        eight.rotate(0);

        assert(eleven.links[0] is eight);
        assert(eleven.parent is fifteen, "nine parent fail");
        assert(eight.parent is eleven, "eight child of nine fail");
        assert(eight.links[1] is ten);
        assert(ten.parent is eight);
        
    }

    /// left rotation.  this simulates a RB 1/2/3 left rotate on 1
    unittest {
        auto tree = new Tree();
        auto one = tree.add(1);
        auto two = tree.add(2);
        auto three = tree.add(3);
        one.rotate(0);

        assert(two.links[0] is one);
        assert(two.links[1] is three);

    }

}


void main() {

}
