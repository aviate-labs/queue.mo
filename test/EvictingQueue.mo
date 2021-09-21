import Iter "mo:base/Iter";
import List "mo:base/List";

import Queue "../src/Queue";
import EQueue "../src/EvictingQueue";

let q = EQueue.EvictingQueue<Nat>(2);

assert(Iter.toArray(q.vals()) == []);
q.push(3);
q.push(2);
assert(Iter.toArray(q.vals()) == [2, 3]);
q.push(1);
assert(Iter.toArray(q.vals()) == [1, 2]);

func remove2ndElement<V>(q : EQueue.EvictingQueue<V>) {
    func drop2nd(l : List.List<V>) : List.List<V> {
        switch (l) {
            case (?(x, ?(y, ys))) { ?(x, ys); };
            case (_) { l; };
        };
    };
    q.custom(func ((i, o) : Queue.Queue<V>) : Queue.Queue<V> {
        switch (List.size(i)) {
            case (0) {
                let ro = List.reverse(o);
                (null, List.reverse(drop2nd(ro)));
            };
            case (1) {
                let ro = List.reverse(o);
                switch (ro) {
                    case (?(x, xs)) {
                        (i, List.reverse(xs));
                    };
                    case (null) {
                        (i, null);
                    };
                };
            };
            case (_) {
                (drop2nd(i), o);
            };
        };
    });
};

remove2ndElement(q);
assert(Iter.toArray(q.vals()) == [1]);
remove2ndElement(q);
assert(Iter.toArray(q.vals()) == [1]);
