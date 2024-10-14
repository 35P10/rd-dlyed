#!/bin/bash

# Iniciar los nodos de Redis
redis-server /etc/redis/redis-master-01.conf --supervised &
redis-server /etc/redis/redis-master-02.conf --supervised &
redis-server /etc/redis/redis-master-03.conf --supervised &
redis-server /etc/redis/redis-master-04.conf --supervised &
redis-server /etc/redis/redis-replica-01.conf --supervised &
redis-server /etc/redis/redis-replica-02.conf --supervised &
redis-server /etc/redis/redis-replica-03.conf --supervised &
redis-server /etc/redis/redis-replica-04.conf --supervised &

# Esperar a que todos los nodos terminen
wait
