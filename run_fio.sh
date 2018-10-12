#! /bin/bash
fio --output-format=json ./fio-rand-RW-tmpfs.fio | jq '.jobs[]' 
fio --output-format=json ./fio-rand-RW-emptydir.fio | jq '.jobs[]' 
fio --output-format=json ./fio-rand-RW-cow.fio | jq '.jobs[]' 
fio --output-format=json ./fio-rand-RW-gluster.fio | jq '.jobs[]' 


# jq '.jobs | {type: .jobname, read_bw_min: .read.bw_min, read_bw_max: .read.bw_max, read_iops_min: .read.iops_min, read_iops_max: .read.iops_max, read_clat_ns_mean: .read.clat_ns.mean, write_bw_min: .write.bw_min, write_bw_max: .write.bw_max, write_iops_min: .write.iops_min, write_iops_max: .write.iops_max, write_clat_ns_mean: .write.clat_ns.mean}'
