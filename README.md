# Containers Volumes Load Tests

## To use it on Docker

```bash

docker run -ti --rm \
   -v  \
   mariolet/volumes-perfs:latest

```

## To use it on OpenShift

Start a pod that mounts 3 different kinds of volumes:

1. A tmpsfs volume: in memory
2. A emptyDir volume: the filesystem node where the container is running
3. A persistent volume: whatever storage type the admin has configured (EBS, gluster, ceph, etc...)

```bash

echo "apiVersion: v1
kind: Pod
metadata:
  name: volumes-perfs-pod
  labels:
    app: volumes-perfs
spec:
  containers:
    - name: volumes-perfs
      image: mariolet/volumes-perfs:latest
      command: [\"tail\", \"-f\", \"/dev/null\"]
      volumeMounts:
        - mountPath: /tmpfs
          name: tmpfs
        - mountPath: /emptydir
          name: emptydir
        - mountPath: /gluster
          name: gluster
  volumes:
    - name: tmpfs
      emptyDir: {"medium": "Memory"}
    - name: emptydir
      emptyDir: {}
    - name: gluster
      persistentVolumeClaim:
        claimName: claim-che-workspace" | oc apply -f -

```

Open a shell in the container and run [fio]():

```bash

oc rsh volumes-perfs-pod /workdir/run_fio.sh

```

## To build the image

```bash

git clone l0rd/volumes-perfs/
cd volumese-perfs
docker build -t volumes-perfs .

```

14131567.524571
14037695.917379