import Iter "mo:base/Iter";

import EQueue "../src/EvictingQueue";

let q = EQueue.EvictingQueue<Nat>(2);

assert(Iter.toArray(q.vals()) == []);
q.push(3);
q.push(2);
assert(Iter.toArray(q.vals()) == [2, 3]);
q.push(1);
assert(Iter.toArray(q.vals()) == [1, 2]);
