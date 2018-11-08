# Containers Volumes Load Tests

## How to use it

### On OpenShift

4 different kinds of filesystems will be tested:

1. **tmpfs** volume: in memory
2. **emptyDir** volume: the filesystem node where the container is running
3. **CoW**: internal container storage
4. **Persistent**: whatever storage type the admin has configured (gluster, ceph, etc...)

To start the pod with the tooling ([fio](https://github.com/axboe/fio)) and with the volumes mounted run the following command:

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

Once the pod is started, run [fio](https://github.com/axboe/fio) with the corresponding config files:

```bash

oc rsh volumes-perfs-pod /workdir/run_fio.sh

```

## How to build the image

```bash

git clone l0rd/volumes-perfs/
cd volumese-perfs
docker build -t volumes-perfs .

```
