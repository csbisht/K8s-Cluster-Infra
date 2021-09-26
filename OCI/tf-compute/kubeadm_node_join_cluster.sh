#!/bin/bash
masterip=`terraform output public-ip-for-compute-instance-master |awk -F '"' '{print $2}'`
nodeip=`terraform output public-ip-for-compute-instance-node |awk -F '"' '{print $2}'`

kubeadmjoin=`ssh -o "StrictHostKeyChecking no" -i ../oci_key/K8s_test ubuntu@"${masterip}" "sudo kubeadm token create --print-join-command"`

ssh -o "StrictHostKeyChecking no" -i ../oci_key/K8s_test ubuntu@"${nodeip}" "sudo ${kubeadmjoin}"
