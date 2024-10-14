```
sudo apt install git
```


```bash
git clone https://github.com/35P10/rd-dlyed
```

```bash
cd rd-dlyed/
```

```bash
sudo mv redis-*.conf /etc/redis/
```
Check:
```bash
sudo ls /etc/redis/
```
## Install AWSCli aarch64

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

Puedes instalar Redis usando `apt` con el siguiente comando:

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
sudo systemctl enable redis
sudo systemctl start redis
```

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

### 6. **(Opcional) Prueba de uso**

Puedes acceder al cliente de Redis para realizar pruebas:

```bash
redis-cli
```

Una vez dentro, puedes probar comandos como:

```bash
set mi_clave "Hola, Redis!"
get mi_clave
```

## Desinstalar redis

1. **Detener el servicio de Redis** (si está en ejecución):

   ```bash
   sudo systemctl stop redis
   ```
2. **Desinstalar Redis**:
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
  * 60001: Es un esclavo del maestro 50001.
  * 60002: Es un esclavo del maestro 50002.
  * 60003: Es un esclavo del maestro 50003.
  * 60004: Es un esclavo del maestro 50004.

### Detalles Adicionales

* Failover: Todos los nodos están configurados con nofailover, lo que significa que no habrá un cambio automático a un nodo maestro en caso de que uno falle. Esto es algo a considerar dependiendo de los requisitos de alta disponibilidad de tu aplicación.
* Epochs: Todos los nodos tienen la variable currentEpoch configurada en 4 y lastVoteEpoch en 0, lo que sugiere que todos están en la misma etapa de configuración y sincronización.

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

2. Crear directorio mkdir
```bash
sudo mkdir -p  /var/lib/redis/50001
sudo mkdir -p  /var/lib/redis/50002
sudo mkdir -p  /var/lib/redis/50003
sudo mkdir -p  /var/lib/redis/50004
sudo mkdir -p  /var/lib/redis/60001
sudo mkdir -p  /var/lib/redis/60002
sudo mkdir -p  /var/lib/redis/60003
sudo mkdir -p  /var/lib/redis/60004
```
permiso redis:redis
```bash
sudo chown redis:redis /var/lib/redis/50001
sudo chown redis:redis /var/lib/redis/50002
sudo chown redis:redis /var/lib/redis/50003
sudo chown redis:redis /var/lib/redis/50004
sudo chown redis:redis /var/lib/redis/60001
sudo chown redis:redis /var/lib/redis/60002
sudo chown redis:redis /var/lib/redis/60003
sudo chown redis:redis /var/lib/redis/60004
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
sudo chmod 750 /var/lib/redis/60001
sudo chmod 750 /var/lib/redis/60002
sudo chmod 750 /var/lib/redis/60003
sudo chmod 750 /var/lib/redis/60004
```

## Configurar los nodos maestros

Los archivos de los nodos maestros son:
```bash
/etc/redis/redis-master-01.conf
/etc/redis/redis-master-02.conf
/etc/redis/redis-master-03.conf
/etc/redis/redis-master-04.conf
```

### Crea los directorios necesarios para cada nodo:


### Crear servicios de systemd para los nodos maestros:

en la ruta `/etc/systemd/system/`

sudo nano /etc/systemd/system/redis-50001.service

```bash
sudo mv redis-*.service /etc/systemd/system/
```

### Habilitar y arrancar los servicios para los maestros:

``` bash
sudo systemctl daemon-reload
sudo systemctl enable redis-50001 redis-50002 redis-50003 redis-50004
sudo systemctl start redis-50001 redis-50002 redis-50003 redis-50004

```



3. Iniciar los Nodos
   Inicia cada instancia de Redis con su archivo de configuración correspondiente:


```bash
redis-server /etc/redis/redis-master-01.conf
redis-server /etc/redis/redis-replica-01.conf
redis-server /etc/redis/redis-master-02.conf
redis-server /etc/redis/redis-replica-02.conf
redis-server /etc/redis/redis-master-03.conf
redis-server /etc/redis/redis-replica-03.conf
redis-server /etc/redis/redis-master-04.conf
redis-server /etc/redis/redis-replica-04.conf
```

## Crear servicio

```bash
sudo nano /etc/systemd/system/redis-master-01.service
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


4. Crear el Clúster

Una vez que todos los nodos están funcionando, necesitas crear el clúster usando la herramienta `redis-cli`. Asegúrate de que todos los nodos están activos.


redis-cli -h 10.0.132.78 -p 50001

```
redis-cli --cluster create 10.0.132.78:50001 10.0.132.78:50002 10.0.132.78:50003 10.0.132.78:50004 10.0.132.78:60001 10.0.132.78:60002 10.0.132.78:60003 10.0.132.78:60004 --cluster-replicas 1
```

El orden de los nodos: En el comando anterior, los primeros cuatro nodos (puertos 50001 a 50004) se consideran nodos maestros, y los siguientes cuatro (puertos 60001 a 60004) se consideran nodos esclavos.

Asignación automática: Redis automáticamente asigna un nodo esclavo a cada nodo maestro en el mismo orden. Por ejemplo:

El esclavo en el puerto 60001 se asignará al maestro en el puerto 50001.
El esclavo en el puerto 60002 se asignará al maestro en el puerto 50002.
Y así sucesivamente.

5. Asignar Slots
Redis utiliza un espacio de 16384 slots para distribuir las claves entre los nodos. Cada nodo maestro debe ser asignado a un rango de slots. Usa el siguiente comando para asignar slots a los nodos maestros:

```

redis-cli -h 10.0.132.78 -p 50001 cluster addslots 0-4095
redis-cli -h 10.0.132.78 -p 50002 cluster addslots 4096-8191
redis-cli -h 10.0.132.78 -p 50003 cluster addslots 8192-12287
redis-cli -h 10.0.132.78 -p 50004 cluster addslots 12288-16383

```

6. Verificar la Configuración
Puedes verificar que el clúster se ha configurado correctamente usando el siguiente comando:
```

redis-cli -h 10.0.132.78 -p 50001 cluster info

```

Verificar la asignación de slots:
```

redis-cli -h 10.0.132.78 -p 50001 cluster slots

```

7.  Monitorizar el Clúster
```

redis-cli -c -h 172.31.20.83 -p 50001 cluster nodes

```

### Notas
* currentEpoch y lastVoteEpoch: Se gestionan internamente por Redis y no se pueden establecer directamente en el archivo de configuración.

### Que falta?

* Configurar nofailover
```

redis-cli -h `<ip-nodo>` -p `<puerto-nodo>` cluster failover nofailover

```

* Copiar la data
```
