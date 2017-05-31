# Subset Matching Schemes
Implementations of some subset matching schemes.

### Egress Pruning
A solution to subset matching is to simply use a single multicast group to send
a copy of each packet to all interfaces and then, drop the redundant copies
for interfaces that are not in the multicast group at the egress pipeline.

### Bitstring Compression
With bitstring compression, we map sets of inputs to conservative covering
multicast groups, and then rely on egress pruning to remove unnecessary
replicas.


## Running
Each implementation is a self-contained
[p4app](https://github.com/p4lang/p4app). For example, you can run:

    p4app egress_prune_v14.p4app

