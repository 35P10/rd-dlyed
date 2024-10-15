El clúster Redis consta de 32 nodos, distribuidos en 16 nodos maestros y 16 nodos réplicas, todos configurados con la opción `nofailover`. Aquí te dejo un resumen estructurado del clúster:

### Maestros:
- **16 nodos maestros**, cada uno de los cuales tiene un rango específico de slots que maneja:
  - **172.31.65.163:50001** maneja slots `0-1023`
  - **172.31.65.163:50002** maneja slots `1024-2047`
  - **172.31.65.163:50003** maneja slots `2048-3071`
  - **172.31.65.163:50004** maneja slots `3072-4095`
  - **172.31.65.163:50005** maneja slots `4096-5119`
  - **172.31.65.163:50006** maneja slots `5120-6143`
  - **172.31.65.163:50007** maneja slots `6144-7167`
  - **172.31.65.163:50008** maneja slots `7168-8191`
  - **172.31.65.163:50009** maneja slots `8192-9215`
  - **172.31.65.163:50010** maneja slots `9216-10239`
  - **172.31.65.163:50011** maneja slots `10240-11263`
  - **172.31.65.163:50012** maneja slots `11264-12287`
  - **172.31.65.163:50013** maneja slots `12288-13311`
  - **172.31.65.163:50014** maneja slots `13312-14335`
  - **172.31.65.163:50015** maneja slots `14336-15359`
  - **172.31.65.163:50016** maneja slots `15360-16383`

### Réplicas:
- **16 nodos réplicas**, cada uno asociado a un nodo maestro para replicar sus datos, todos con la opción `nofailover` (sin conmutación por error automática):
  - **172.31.65.163:50017** es réplica de **50001**
  - **172.31.65.163:50018** es réplica de **50010**
  - **172.31.65.163:50019** es réplica de **50011**
  - **172.31.65.163:50020** es réplica de **50009**
  - **172.31.65.163:50021** es réplica de **50004**
  - **172.31.65.163:50022** es réplica de **50006**
  - **172.31.65.163:50023** es réplica de **50016**
  - **172.31.65.163:50024** es réplica de **50007**
  - **172.31.65.163:50025** es réplica de **50002**
  - **172.31.65.163:50026** es réplica de **50008**
  - **172.31.65.163:50027** es réplica de **50005**
  - **172.31.65.163:50028** es réplica de **50012**
  - **172.31.65.163:50029** es réplica de **50015**
  - **172.31.65.163:50030** es réplica de **50003**
  - **172.31.65.163:50031** es réplica de **50014**
  - **172.31.65.163:50032** es réplica de **50013**

### Observaciones:
- Todos los nodos están conectados y funcionan correctamente (`connected`).
- La opción `nofailover` está activa, lo que significa que no hay conmutación por error automática configurada. En caso de que un nodo maestro falle, las réplicas no asumirán automáticamente el rol de maestro.



# Instalar este Repo

```
sudo apt install git
```


```bash
git clone https://github.com/35P10/rd-dlyed
```

```bash
cd rd-dlyed/test
```

Copiar los archivos .conf

```bash
sudo mv redis-*.conf /etc/redis/
```

Check:
```bash
sudo ls /etc/redis/ -l
```

Copiar los servicios:
```bash
sudo mv redis-*.service /etc/systemd/system/
```
Check:
```bash
sudo ls /etc/systemd/system/ -l
```


## Configurar un Clúster de Redis


2. Crear directorios
```bash
sudo mkdir -p /var/lib/redis/50001 /var/lib/redis/50002 /var/lib/redis/50003 /var/lib/redis/50004 /var/lib/redis/50005 /var/lib/redis/50006 /var/lib/redis/50007 /var/lib/redis/50008 /var/lib/redis/50009 /var/lib/redis/50010 /var/lib/redis/50011 /var/lib/redis/50012 /var/lib/redis/50013 /var/lib/redis/50014 /var/lib/redis/50015 /var/lib/redis/50016 /var/lib/redis/50017 /var/lib/redis/50018 /var/lib/redis/50019 /var/lib/redis/50020 /var/lib/redis/50021 /var/lib/redis/50022 /var/lib/redis/50023 /var/lib/redis/50024 /var/lib/redis/50025 /var/lib/redis/50026 /var/lib/redis/50027 /var/lib/redis/50028 /var/lib/redis/50029 /var/lib/redis/50030 /var/lib/redis/50031 /var/lib/redis/50032

```
permiso redis:redis
```bash
sudo chown redis:redis /var/lib/redis/50001 /var/lib/redis/50002 /var/lib/redis/50003 /var/lib/redis/50004 /var/lib/redis/50005 /var/lib/redis/50006 /var/lib/redis/50007 /var/lib/redis/50008 /var/lib/redis/50009 /var/lib/redis/50010 /var/lib/redis/50011 /var/lib/redis/50012 /var/lib/redis/50013 /var/lib/redis/50014 /var/lib/redis/50015 /var/lib/redis/50016 /var/lib/redis/50017 /var/lib/redis/50018 /var/lib/redis/50019 /var/lib/redis/50020 /var/lib/redis/50021 /var/lib/redis/50022 /var/lib/redis/50023 /var/lib/redis/50024 /var/lib/redis/50025 /var/lib/redis/50026 /var/lib/redis/50027 /var/lib/redis/50028 /var/lib/redis/50029 /var/lib/redis/50030 /var/lib/redis/50031 /var/lib/redis/50032
```
permiso 750
```bash
sudo -s
```

```bash
sudo chmod 750 /var/lib/redis/50001 /var/lib/redis/50002 /var/lib/redis/50003 /var/lib/redis/50004 /var/lib/redis/50005 /var/lib/redis/50006 /var/lib/redis/50007 /var/lib/redis/50008 /var/lib/redis/50009 /var/lib/redis/50010 /var/lib/redis/50011 /var/lib/redis/50012 /var/lib/redis/50013 /var/lib/redis/50014 /var/lib/redis/50015 /var/lib/redis/50016 /var/lib/redis/50017 /var/lib/redis/50018 /var/lib/redis/50019 /var/lib/redis/50020 /var/lib/redis/50021 /var/lib/redis/50022 /var/lib/redis/50023 /var/lib/redis/50024 /var/lib/redis/50025 /var/lib/redis/50026 /var/lib/redis/50027 /var/lib/redis/50028 /var/lib/redis/50029 /var/lib/redis/50030 /var/lib/redis/50031 /var/lib/redis/50032
```

3. Iniciar los Nodos
   Inicia cada instancia de Redis con su archivo de configuración correspondiente:

```bash
sudo redis-server /etc/redis/redis-master-01.conf && \
sudo redis-server /etc/redis/redis-replica-01.conf && \
sudo redis-server /etc/redis/redis-master-02.conf && \
sudo redis-server /etc/redis/redis-replica-02.conf && \
sudo redis-server /etc/redis/redis-master-03.conf && \
sudo redis-server /etc/redis/redis-replica-03.conf && \
sudo redis-server /etc/redis/redis-master-04.conf && \
sudo redis-server /etc/redis/redis-replica-04.conf && \
sudo redis-server /etc/redis/redis-master-05.conf && \
sudo redis-server /etc/redis/redis-replica-05.conf && \
sudo redis-server /etc/redis/redis-master-06.conf && \
sudo redis-server /etc/redis/redis-replica-06.conf && \
sudo redis-server /etc/redis/redis-master-07.conf && \
sudo redis-server /etc/redis/redis-replica-07.conf && \
sudo redis-server /etc/redis/redis-master-08.conf && \
sudo redis-server /etc/redis/redis-replica-08.conf && \
sudo redis-server /etc/redis/redis-master-09.conf && \
sudo redis-server /etc/redis/redis-replica-09.conf && \
sudo redis-server /etc/redis/redis-master-10.conf && \
sudo redis-server /etc/redis/redis-replica-10.conf && \
sudo redis-server /etc/redis/redis-master-11.conf && \
sudo redis-server /etc/redis/redis-replica-11.conf && \
sudo redis-server /etc/redis/redis-master-12.conf && \
sudo redis-server /etc/redis/redis-replica-12.conf && \
sudo redis-server /etc/redis/redis-master-13.conf && \
sudo redis-server /etc/redis/redis-replica-13.conf && \
sudo redis-server /etc/redis/redis-master-14.conf && \
sudo redis-server /etc/redis/redis-replica-14.conf && \
sudo redis-server /etc/redis/redis-master-15.conf && \
sudo redis-server /etc/redis/redis-replica-15.conf && \
sudo redis-server /etc/redis/redis-master-16.conf && \
sudo redis-server /etc/redis/redis-replica-16.conf
```

Si hay un error, revisa el log del nodo:
```bash
cat /var/log/redis/redis-50001.log
```


## Crear servicio 

1. Recargar los servicios:

Para asegurarte de que el sistema reconozca cualquier cambio en los archivos de servicio:

```bash
sudo systemctl daemon-reload
```

2. Habilitar todos los servicios:

```bash
sudo systemctl enable redis-master-01.service
sudo systemctl enable redis-master-02.service
sudo systemctl enable redis-master-03.service
sudo systemctl enable redis-master-04.service
sudo systemctl enable redis-master-05.service
sudo systemctl enable redis-master-06.service
sudo systemctl enable redis-master-07.service
sudo systemctl enable redis-master-08.service
sudo systemctl enable redis-master-09.service
sudo systemctl enable redis-master-10.service
sudo systemctl enable redis-master-11.service
sudo systemctl enable redis-master-12.service
sudo systemctl enable redis-master-13.service
sudo systemctl enable redis-master-14.service
sudo systemctl enable redis-master-15.service
sudo systemctl enable redis-master-16.service

sudo systemctl enable redis-replica-01.service
sudo systemctl enable redis-replica-02.service
sudo systemctl enable redis-replica-03.service
sudo systemctl enable redis-replica-04.service
sudo systemctl enable redis-replica-05.service
sudo systemctl enable redis-replica-06.service
sudo systemctl enable redis-replica-07.service
sudo systemctl enable redis-replica-08.service
sudo systemctl enable redis-replica-09.service
sudo systemctl enable redis-replica-10.service
sudo systemctl enable redis-replica-11.service
sudo systemctl enable redis-replica-12.service
sudo systemctl enable redis-replica-13.service
sudo systemctl enable redis-replica-14.service
sudo systemctl enable redis-replica-15.service
sudo systemctl enable redis-replica-16.service
```

3. Iniciar todos los servicios:
```bash
sudo systemctl start redis-master-01.service
sudo systemctl start redis-master-02.service
sudo systemctl start redis-master-03.service
sudo systemctl start redis-master-04.service
sudo systemctl start redis-master-05.service
sudo systemctl start redis-master-06.service
sudo systemctl start redis-master-07.service
sudo systemctl start redis-master-08.service
sudo systemctl start redis-master-09.service
sudo systemctl start redis-master-10.service
sudo systemctl start redis-master-11.service
sudo systemctl start redis-master-12.service
sudo systemctl start redis-master-13.service
sudo systemctl start redis-master-14.service
sudo systemctl start redis-master-15.service
sudo systemctl start redis-master-16.service

sudo systemctl start redis-replica-01.service
sudo systemctl start redis-replica-02.service
sudo systemctl start redis-replica-03.service
sudo systemctl start redis-replica-04.service
sudo systemctl start redis-replica-05.service
sudo systemctl start redis-replica-06.service
sudo systemctl start redis-replica-07.service
sudo systemctl start redis-replica-08.service
sudo systemctl start redis-replica-09.service
sudo systemctl start redis-replica-10.service
sudo systemctl start redis-replica-11.service
sudo systemctl start redis-replica-12.service
sudo systemctl start redis-replica-13.service
sudo systemctl start redis-replica-14.service
sudo systemctl start redis-replica-15.service
sudo systemctl start redis-replica-16.service
```

## Crear Cluster
1. 

```bash
redis-cli -h 10.0.136.127 -p 50001 --cluster create 10.0.136.127:50001 10.0.136.127:50002 10.0.136.127:50003 10.0.136.127:50004 10.0.136.127:50005 10.0.136.127:50006 10.0.136.127:50007 10.0.136.127:50008 10.0.136.127:50009 10.0.136.127:50010 10.0.136.127:50011 10.0.136.127:50012 10.0.136.127:50013 10.0.136.127:50014 10.0.136.127:50015 10.0.136.127:50016
```
La salida debe parecese a
```
>>> Performing hash slots allocation on 16 nodes...
Master[0] -> Slots 0 - 1023
Master[1] -> Slots 1024 - 2047
Master[2] -> Slots 2048 - 3071
Master[3] -> Slots 3072 - 4095
Master[4] -> Slots 4096 - 5119
Master[5] -> Slots 5120 - 6143
Master[6] -> Slots 6144 - 7167
Master[7] -> Slots 7168 - 8191
Master[8] -> Slots 8192 - 9215
Master[9] -> Slots 9216 - 10239
Master[10] -> Slots 10240 - 11263
Master[11] -> Slots 11264 - 12287
Master[12] -> Slots 12288 - 13311
Master[13] -> Slots 13312 - 14335
Master[14] -> Slots 14336 - 15359
Master[15] -> Slots 15360 - 16383
M: 64e9d64513025e5e7757f83d491e1d58f19113c2 10.0.136.127:50001
   slots:[0-1023] (1024 slots) master
M: 3929ba09af450d47a8ed75d8bb6362773c95d33d 10.0.136.127:50002
   slots:[1024-2047] (1024 slots) master
M: c13b538365c8eb5f83b0e58f728c3a4e3835c2fb 10.0.136.127:50003
   slots:[2048-3071] (1024 slots) master
M: 47376aed095929d6c9bc6e84f8f1e2984a3b0021 10.0.136.127:50004
   slots:[3072-4095] (1024 slots) master
M: f68e82ab0422e096a1a40300b19af2d3d133b0c9 10.0.136.127:50005
   slots:[4096-5119] (1024 slots) master
M: d2a21cea9757d72e3b356b8cadc8fc7aeba69d7a 10.0.136.127:50006
   slots:[5120-6143] (1024 slots) master
M: 712c2b84d629bc38840dd44c5b6836c7bedbf5ee 10.0.136.127:50007
   slots:[6144-7167] (1024 slots) master
M: 874c5a83b99f82aaac59d52ba11a69d0e27ccfe7 10.0.136.127:50008
   slots:[7168-8191] (1024 slots) master
M: dbbc6719d8ec6faff4d281b1bf2e4e738a688bbb 10.0.136.127:50009
   slots:[8192-9215] (1024 slots) master
M: 46308801bee2fe6b4c61d885dcb23575d8e62643 10.0.136.127:50010
   slots:[9216-10239] (1024 slots) master
M: 5a0b0413275b7721fa5ccf1c622b8d842438af06 10.0.136.127:50011
   slots:[10240-11263] (1024 slots) master
M: 51713f02ace132aa2848548824477b3f16f06ae9 10.0.136.127:50012
   slots:[11264-12287] (1024 slots) master
M: f81237fe69802f02bdf9cf61dbd06bfe1f814c61 10.0.136.127:50013
   slots:[12288-13311] (1024 slots) master
M: 30b56c20877e0fef303814dfcbf05614f7fe53b3 10.0.136.127:50014
   slots:[13312-14335] (1024 slots) master
M: 38a74174055e64b5d5ff545aadccea461ab9c1e1 10.0.136.127:50015
   slots:[14336-15359] (1024 slots) master
Can I set the above configuration? (type 'yes' to accept):
```
ingresar yes `yes`
```
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
........
>>> Performing Cluster Check (using node 10.0.136.127:50001)
M: 64e9d64513025e5e7757f83d491e1d58f19113c2 10.0.136.127:50001
   slots:[0-1023] (1024 slots) master
M: d2a21cea9757d72e3b356b8cadc8fc7aeba69d7a 10.0.136.127:50006
   slots:[5120-6143] (1024 slots) master
M: 47376aed095929d6c9bc6e84f8f1e2984a3b0021 10.0.136.127:50004
   slots:[3072-4095] (1024 slots) master
M: f68e82ab0422e096a1a40300b19af2d3d133b0c9 10.0.136.127:50005
   slots:[4096-5119] (1024 slots) master
M: 51713f02ace132aa2848548824477b3f16f06ae9 10.0.136.127:50012
   slots:[11264-12287] (1024 slots) master
M: c13b538365c8eb5f83b0e58f728c3a4e3835c2fb 10.0.136.127:50003
   slots:[2048-3071] (1024 slots) master
M: 5a0b0413275b7721fa5ccf1c622b8d842438af06 10.0.136.127:50011
   slots:[10240-11263] (1024 slots) master
M: 38a74174055e64b5d5ff545aadccea461ab9c1e1 10.0.136.127:50015
   slots:[14336-15359] (1024 slots) master
M: 30b56c20877e0fef303814dfcbf05614f7fe53b3 10.0.136.127:50014
   slots:[13312-14335] (1024 slots) master
M: 712c2b84d629bc38840dd44c5b6836c7bedbf5ee 10.0.136.127:50007
   slots:[6144-7167] (1024 slots) master
M: 3929ba09af450d47a8ed75d8bb6362773c95d33d 10.0.136.127:50002
   slots:[1024-2047] (1024 slots) master
M: 46308801bee2fe6b4c61d885dcb23575d8e62643 10.0.136.127:50010
   slots:[9216-10239] (1024 slots) master
M: dbbc6719d8ec6faff4d281b1bf2e4e738a688bbb 10.0.136.127:50009
   slots:[8192-9215] (1024 slots) master
M: f81237fe69802f02bdf9cf61dbd06bfe1f814c61 10.0.136.127:50013
   slots:[12288-13311] (1024 slots) master
M: 874c5a83b99f82aaac59d52ba11a69d0e27ccfe7 10.0.136.127:50008
   slots:[7168-8191] (1024 slots) master
M: 78ee96d30dfc2d9403f208997e05f836dd93a908 10.0.136.127:50016
   slots:[15360-16383] (1024 slots) master
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```


asignar esclavos

```bash
redis-cli --cluster add-node 10.0.136.127:50017 10.0.136.127:50001 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50018 10.0.136.127:50010 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50019 10.0.136.127:50011 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50020 10.0.136.127:50009 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50021 10.0.136.127:50004 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50022 10.0.136.127:50006 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50023 10.0.136.127:50016 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50024 10.0.136.127:50007 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50025 10.0.136.127:50002 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50026 10.0.136.127:50008 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50027 10.0.136.127:50005 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50028 10.0.136.127:50012 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50029 10.0.136.127:50015 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50030 10.0.136.127:50003 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50031 10.0.136.127:50014 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50032 10.0.136.127:50013 --cluster-slave
```

