
## Descripción General del Clúster

### Número de Nodos:

El clúster está compuesto por un total de 8 nodos.
Hay 4 nodos maestros (master) y 4 nodos esclavos (slave).
Direcciones IP y Puertos:

Todos los nodos están en la misma dirección IP 10.0.132.78 pero están distribuidos en diferentes puertos:

* Maestros:
  * 50001: Es un maestro con la capacidad de gestionar la partición de datos 0-4095.
  * 50002: Es un maestro que gestiona la partición de datos 4096-8191.
  * 50003: Es un maestro que gestiona la partición de datos 8192-12287.
  * 50004: Es un maestro que gestiona la partición de datos 12288-16383.
* Esclavos:
  * 50005: Es un esclavo del maestro 50001.
  * 50006: Es un esclavo del maestro 50002.
  * 50007: Es un esclavo del maestro 50003.
  * 50008: Es un esclavo del maestro 50004.

### Detalles Adicionales

* Failover: Todos los nodos están configurados con nofailover, lo que significa que no habrá un cambio automático a un nodo maestro en caso de que uno falle. Esto es algo a considerar dependiendo de los requisitos de alta disponibilidad de tu aplicación.
* Epochs: Todos los nodos tienen la variable currentEpoch configurada en 4 y lastVoteEpoch en 0, lo que sugiere que todos están en la misma etapa de configuración y sincronización.

## Install AWSCli aarch64 (en caso sea necesario)

Descarga la AWS CLI correcta para aarch64:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
```

Descomprime el archivo descargado:
```bash
unzip awscliv2.zip
```

Ejecuta el instalador:
```bash
sudo ./aws/install
```

Verifica la instalación:
```bash
aws --version
```

## Instalar Redis

Para instalar Redis en Ubuntu, sigue estos pasos:

### 1. **Actualizar el sistema**

Primero, asegúrate de que tu sistema esté actualizado:

```bash
sudo apt update
sudo apt upgrade
```

### 2. **Instalar Redis**

```bash
sudo apt install redis-server
```

### 3. **Configurar Redis**

Una vez instalado, puedes editar la configuración de Redis según tus necesidades. El archivo de configuración se encuentra en:

```bash
/etc/redis/redis.conf
```

Puedes abrirlo con un editor de texto, por ejemplo:

```bash
sudo nano /etc/redis/redis.conf
```

En este caso vamos a eliminarlo.
```bash
sudo rm /etc/redis/redis.conf
```

### 4. **Habilitar y arrancar el servicio**

Después de configurar Redis, habilita y arranca el servicio:


```bash
sudo systemctl start redis
```
### Modificar los host

```
sudo nano /etc/hosts
```
```
127.0.0.1   localhost
127.0.1.1   ip-10-0-135-188
```

### 5. **Verificar que Redis esté funcionando**

Puedes verificar que Redis esté funcionando correctamente con el siguiente comando:

```bash
redis-cli ping
```

Si está funcionando correctamente, deberías recibir la respuesta `PONG`.

## Desinstalar redis

1. **Detener el servicio de Redis** (si está en ejecución):

```bash
sudo systemctl stop redis
```

2. **Desinstalar Redis**

Si instalaste Redis usando `apt`, puedes desinstalarlo con:

```bash
sudo apt remove redis-server
```

O si deseas eliminar también los archivos de configuración:

```bash
sudo apt purge redis-server
sudo rm -r /etc/redis
```

3. **Eliminar dependencias no utilizadas** (opcional):

```bash
sudo apt autoremove
```

4. **Verificar que Redis se haya desinstalado**:

Puedes comprobar que Redis ya no está instalado con:

```bash
redis-cli
```

Si recibes un mensaje de que el comando no se encuentra, significa que la desinstalación fue exitosa.

# Instalar este Repo

```
sudo apt install git
```


```bash
git clone https://github.com/35P10/rd-dlyed
```

```bash
cd rd-dlyed/dyed
```

```bash
sudo mv redis-*.conf /etc/redis/
```
Check:
```bash
sudo ls /etc/redis/ -l
```

## Setup

---

1. Crea archivos de configuración para cada nodo.
2. Inicia los nodos con sus respectivos archivos de configuración.
3. Usa redis-cli para crear y verificar el clúster.

## Redis

---

### Nodos

---

* Nodos Maestros (Master Nodes):

  * Función: Son responsables de manejar las operaciones de escritura y replicar sus datos a los nodos réplicas.
  * Ejemplo: En un clúster con tres nodos maestros, cada nodo maestro puede tener dos nodos réplicas para asegurar la disponibilidad y la tolerancia a fallos.
* Nodos Réplica (Esclados) (Replica Nodes):

  * Función: Se encargan de replicar los datos de un nodo maestro. Su objetivo es proporcionar alta disponibilidad. En caso de que el nodo maestro falle, un nodo réplica puede ser promovido a maestro.

## Configurar un Clúster de Redis

1. Preparación del Entorno
   Asegúrate de tener instalados Redis y sus dependencias en todos los nodos que formarán el clúster. Además, cada nodo debe tener una IP accesible y estar en la misma red.
2. Configuración de Archivos de Configuración
   Crea un archivo de configuración para cada nodo en la carpeta ```copiar archivos en el directorio
   `/etc/redis/`.

```bash
/etc/redis/redis-master-01.conf
/etc/redis/redis-master-02.conf
/etc/redis/redis-master-03.conf
/etc/redis/redis-master-04.conf
/etc/redis/redis-replica-01.conf
/etc/redis/redis-replica-02.conf
/etc/redis/redis-replica-03.conf
/etc/redis/redis-replica-04.conf
```

2. Crear directorios
```bash
sudo mkdir -p  /var/lib/redis/50001
sudo mkdir -p  /var/lib/redis/50002
sudo mkdir -p  /var/lib/redis/50003
sudo mkdir -p  /var/lib/redis/50004
sudo mkdir -p  /var/lib/redis/50005
sudo mkdir -p  /var/lib/redis/50006
sudo mkdir -p  /var/lib/redis/50007
sudo mkdir -p  /var/lib/redis/50008
```
permiso redis:redis
```bash
sudo chown redis:redis /var/lib/redis/50001
sudo chown redis:redis /var/lib/redis/50002
sudo chown redis:redis /var/lib/redis/50003
sudo chown redis:redis /var/lib/redis/50004
sudo chown redis:redis /var/lib/redis/50005
sudo chown redis:redis /var/lib/redis/50006
sudo chown redis:redis /var/lib/redis/50007
sudo chown redis:redis /var/lib/redis/50008
```
permiso 750
```bash
sudo -s
```

```bash
sudo chmod 750 /var/lib/redis/50001
sudo chmod 750 /var/lib/redis/50002
sudo chmod 750 /var/lib/redis/50003
sudo chmod 750 /var/lib/redis/50004
sudo chmod 750 /var/lib/redis/50005
sudo chmod 750 /var/lib/redis/50006
sudo chmod 750 /var/lib/redis/50007
sudo chmod 750 /var/lib/redis/50008
```



3. Iniciar los Nodos
   Inicia cada instancia de Redis con su archivo de configuración correspondiente:


```bash
sudo redis-server /etc/redis/redis-master-01.conf
sudo redis-server /etc/redis/redis-replica-01.conf
sudo redis-server /etc/redis/redis-master-02.conf
sudo redis-server /etc/redis/redis-replica-02.conf
sudo redis-server /etc/redis/redis-master-03.conf
sudo redis-server /etc/redis/redis-replica-03.conf
sudo redis-server /etc/redis/redis-master-04.conf
sudo redis-server /etc/redis/redis-replica-04.conf
```


Si hay un error, revisa el log del nodo:
```bash
cat /var/log/redis/redis-50005.log
```

## Crear servicio -------------------

```bash
sudo nano /etc/systemd/system/redis-replica-01.service
```
Agrega la configuración del servicio
Recarga el demonio de systemd para asegurarte de que el nuevo servicio se registre:

```bash
sudo systemctl daemon-reload
```
Habilita y arranca el servicio:

```bash
sudo systemctl enable redis-master-01
```

Para iniciar el servicio inmediatamente:
```bash
sudo systemctl start redis-master-01
```

Verifica el estado del servicio:
```bash
sudo systemctl status redis-master-01
```

2. Hacer lo mismo para los demas nodos maestros y esclavos:

```bash
sudo systemctl daemon-reload
sudo systemctl enable redis-master-01.service redis-master-02.service redis-master-03.service redis-master-04.service
sudo systemctl start redis-master-01.service redis-master-02.service redis-master-03.service redis-master-04.service
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable redis-replica-01.service redis-replica-02.service redis-replica-03.service redis-replica-04.service
sudo systemctl start redis-replica-01.service redis-replica-02.service redis-replica-03.service redis-replica-04.service
```


## Crear el Clúster -------------------

Una vez que todos los nodos están funcionando, necesitas crear el clúster usando la herramienta `redis-cli`. Asegúrate de que todos los nodos están activos.

```bash
redis-cli -h 10.0.132.78 -p 50001
```

1. Forma 1

```bash
redis-cli --cluster create 10.0.132.78:50001 10.0.132.78:50002 10.0.132.78:50003 10.0.132.78:50004 10.0.132.78:50005 10.0.132.78:50006 10.0.132.78:50007 10.0.132.78:50008 --cluster-replicas 1
```

El orden de los nodos: En el comando anterior, los primeros cuatro nodos (puertos 50001 a 50004) se consideran nodos maestros, y los siguientes cuatro (puertos 50005 a 50008) se consideran nodos esclavos.

Asignación automática: Redis automáticamente asigna un nodo esclavo a cada nodo maestro en el mismo orden. Por ejemplo:

El esclavo en el puerto 50005 se asignará al maestro en el puerto 50001.
El esclavo en el puerto 50006 se asignará al maestro en el puerto 50002.
Y así sucesivamente.

1. Forma 2 (Si forma 1 no funciona)

```bash
redis-cli -h 10.0.132.78 -p 50001 --cluster create 10.0.132.78:50001 10.0.132.78:50002 10.0.132.78:50003 10.0.132.78:50004
```

```bash
redis-cli --cluster add-node 10.0.132.78:50005 10.0.132.78:50001 --cluster-slave
redis-cli --cluster add-node 10.0.132.78:50006 10.0.132.78:50002 --cluster-slave
redis-cli --cluster add-node 10.0.132.78:50007 10.0.132.78:50003 --cluster-slave
redis-cli --cluster add-node 10.0.132.78:50008 10.0.132.78:50004 --cluster-slave
```




5. Asignar Slots (No es necesrio)
Redis utiliza un espacio de 16384 slots para distribuir las claves entre los nodos. Cada nodo maestro debe ser asignado a un rango de slots. Usa el siguiente comando para asignar slots a los nodos maestros:

```bash
redis-cli -h 10.0.132.78 -p 50001 cluster addslots 0-4095
redis-cli -h 10.0.132.78 -p 50002 cluster addslots 4096-8191
redis-cli -h 10.0.132.78 -p 50003 cluster addslots 8192-12287
redis-cli -h 10.0.132.78 -p 50004 cluster addslots 12288-16383

```

6. Verificar la Configuración
Puedes verificar que el clúster se ha configurado correctamente usando el siguiente comando:
```bash
redis-cli -h 10.0.132.78 -p 50001 cluster info
```

Verificar la asignación de slots:
```bash
redis-cli -h 10.0.132.78 -p 50001 cluster slots
```

7.  Monitorizar el Clúster
```bash
redis-cli -c -h 172.31.20.83 -p 50001 cluster nodes
```

### Notas
* currentEpoch y lastVoteEpoch: Se gestionan internamente por Redis y no se pueden establecer directamente en el archivo de configuración.

### Que falta?

* Configurar nofailover
```bash
redis-cli -h `<ip-nodo>` -p `<puerto-nodo>` cluster failover nofailover
```

* Copiar la data

### El mensaje MOVED
 El mensaje (error) indica que el comando SET que intentaste ejecutar no se pudo completar en el nodo actual porque la clave que estás intentando establecer está asignada a otro nodo en el clúster.

¿Por qué ocurre esto?
En un clúster de Redis, los datos se distribuyen entre los nodos maestros utilizando un hash de slot. Cada clave se asigna a un slot, y cada slot se mapea a un nodo maestro. En tu caso:

El nodo en el que estás conectado no es el maestro responsable de gestionar el slot donde se encuentra la clave nombre.

¿Qué puedes hacer?
* Conectarte al nodo correcto:
Puedes conectarte directamente al nodo maestro que gestiona el slot correspondiente. 

* Utilizar el redireccionamiento automático:
Redis está diseñado para manejar automáticamente el redireccionamiento a nodos correctos cuando ejecutas comandos. Si el cliente Redis está configurado para seguir el redireccionamiento, debería hacer esto por ti. Asegúrate de que estás usando una versión reciente de redis-cli que soporte esta funcionalidad.

```bash
redis-cli -c -h 10.0.132.78 -p 50001
SET name "hello world!"
GET name
```

* Comprobando el Slot
Si deseas saber qué clave pertenece a qué slot, puedes usar el comando CLUSTER SLOTS para ver la asignación de slots en tu clúster:

```bash
redis-cli -h 10.0.132.78 -p 50001
```

Luego, ejecuta:

```plaintext
CLUSTER SLOTS
```

Esto te mostrará un rango de slots y a qué nodos están asignados.

## Recursos:
- https://redis.io/docs/latest/operate/oss_and_stack/management/scaling/#adding-a-new-node-as-a-replica




## Copiar Data:

1. Identifica los nodos maestros: Los nodos maestros están en los puertos 50001, 50002, 50003, y 50004. Estos son los nodos en los que debes sobreescribir los archivos RDB.

2. Detén los nodos maestros: Detén los servicios Redis de los nodos maestros para evitar que escriban en los archivos mientras los sobrescribes:

```bash
sudo systemctl stop redis-master-01
sudo systemctl stop redis-master-02
sudo systemctl stop redis-master-03
sudo systemctl stop redis-master-04
```

3. Sobreescribe los archivos RDB en los nodos maestros: Sobrescribe los archivos dump.rdb en los directorios correspondientes a los nodos maestros. Aquí están las rutas para tus nodos maestros:




```bash
Nodo maestro 1 (Puerto 50001): /var/lib/redis/50001/dump.rdb
Nodo maestro 2 (Puerto 50002): /var/lib/redis/50002/dump.rdb
Nodo maestro 3 (Puerto 50003): /var/lib/redis/50003/dump.rdb
Nodo maestro 4 (Puerto 50004): /var/lib/redis/50004/dump.rdb
```
Copia el archivo dump.rdb del Redis original (el que contiene los datos que deseas importar) y colócalo en estas rutas.


Los nodos esclavos no requieren sobreescribir la data: No es necesario sobreescribir los archivos en los nodos esclavos, ya que estos nodos sincronizarán automáticamente los datos desde sus respectivos nodos maestros.

```bash
sudo aws s3 s3://quotemedia-backups/my-redis/dump-01.rdb cp /var/lib/redis/50001/dump.rdb

sudo aws s3 s3://quotemedia-backups/my-redis/dump-02.rdb cp /var/lib/redis/50002/dump.rdb

sudo aws s3 s3://quotemedia-backups/my-redis/dump-03.rdb cp /var/lib/redis/50003/dump.rdb

sudo aws s3 s3://quotemedia-backups/my-redis/dump-04.rdb cp /var/lib/redis/50004/dump.rdb

```

3. Reinicia los nodos maestros: Después de sobreescribir los archivos RDB, reinicia los servicios Redis en cada nodo maestro para que carguen los nuevos datos: