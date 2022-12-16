import Iter "mo:base-0.7.3/Iter";
import List "mo:base-0.7.3/List";

import Queue "Queue";

module {
    public class EvictingQueue<V>(n : Nat) {
        var q : Queue.Queue<V> = (null, null);

        // Returns the size of the queue.
        public func size() : Nat = Queue.size<V>(q);

        // Pops an element from the queue.
        public func pop() : ?V {
            let (v, q_) = Queue.pop(q);
            q := q_; v;
        };

        // Pushes an element onto the queue.
        public func push(v : V) {
            q := Queue.push<V>(v, q);
            if (n < size()) ignore pop();
        };

        // Peeks at the top element from the queue.
        public func peek() : ?V {
            let (v, q_) = Queue.peek(q);
            q := q_; v;
        };

        // Execute the given function on the underlying queue.
        // WARNING: Use at own risk.
        //          If the limit is exceeded, elements will get removed.
        public func custom(f : (Queue.Queue<V>) -> Queue.Queue<V>) {
            q := f(q);
            while (n < size()) { ignore pop(); };
        };

        // Returns the values of the queue.
        public func vals() : Iter.Iter<V> {
            let (i_, o_) = q;
            var i = i_;
            var o = List.reverse(o_);
            object {
                public func next() : ?V {
                    switch (i) {
                        case (null) {
                            switch (o) {
                                case (null) { null; };
                                case (? o_)  {
                                    i := ?o_;
                                    o := null;
                                    next();
                                };
                            };
                        };
                        case (? (x, xs)) {
                            i := xs;
                            ?x;
                        };
                    };
                };
            };
        };
    };
};
