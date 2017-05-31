#include "header.p4"
#include "parser.p4"

metadata intrinsic_metadata_t intrinsic_metadata;

action _drop() {
    drop();
}

action _nop() {
}

action set_nhop(nhop_ipv4, port) {
    modify_field(ipv4.dstAddr, nhop_ipv4);
    modify_field(standard_metadata.egress_spec, port);
}

table ipv4_lpm {
    reads {
        ipv4.dstAddr : lpm;
    }
    actions {
        set_nhop;
        _drop;
    }
    size: 1024;
}

action set_dmac(dmac) {
    modify_field(ethernet.dstAddr, dmac);
    modify_field(udp.checksum, 0);
}

table forward {
    reads {
        ipv4.dstAddr: exact;
    }
    actions {
        set_dmac;
        _drop;
    }
    size: 512;
}

action set_mgid(mgid) {
    modify_field(intrinsic_metadata.mcast_grp, mgid, mgid);
}

table mg_exact0 {
    reads {
        tag.tag0: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact1 {
    reads {
        tag.tag1: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact2 {
    reads {
        tag.tag2: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact3 {
    reads {
        tag.tag3: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact4 {
    reads {
        tag.tag4: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact5 {
    reads {
        tag.tag5: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact6 {
    reads {
        tag.tag6: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

table mg_exact7 {
    reads {
        tag.tag7: exact;
    }
    actions {
        _nop;
        set_mgid;
        _drop;
    }
    size: 512;
}

action rewrite_mac(smac) {
    modify_field(ethernet.srcAddr, smac);
}

table send_frame {
    reads {
        standard_metadata.egress_port: exact;
    }
    actions {
        rewrite_mac;
        _drop;
    }
    size: 256;
}

control ingress {
    if(valid(ipv4)) {
        if (valid(tag)) {
            apply(mg_exact0);
            apply(mg_exact1);
            apply(mg_exact2);
            apply(mg_exact3);
            apply(mg_exact4);
            apply(mg_exact5);
            apply(mg_exact6);
            apply(mg_exact7);
        }

        if (intrinsic_metadata.mcast_grp == 0) {
            apply(ipv4_lpm);
        }

        apply(forward);
    }
}

control egress {
    if (valid(ipv4)) {
        apply(send_frame);
    }
}

