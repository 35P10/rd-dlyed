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

Copiar los servicios:
```bash
sudo mv redis-*.service /etc/systemd/system/
```

Check:
```bash
sudo ls /etc/redis/ -l
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
sudo redis-server /etc/redis/redis-replica-04.conf
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

```bash
redis-cli --cluster add-node 10.0.136.127:50017 10.0.132.78:50001 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50018 10.0.132.78:50010 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50019 10.0.132.78:50011 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50020 10.0.132.78:50009 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50021 10.0.132.78:50004 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50022 10.0.132.78:50006 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50023 10.0.132.78:50016 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50024 10.0.132.78:50007 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50025 10.0.132.78:50002 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50026 10.0.132.78:50008 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50027 10.0.132.78:50005 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50028 10.0.132.78:50012 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50029 10.0.132.78:50015 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50030 10.0.132.78:50003 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50031 10.0.132.78:50014 --cluster-slave
redis-cli --cluster add-node 10.0.136.127:50032 10.0.132.78:50013 --cluster-slave
```

