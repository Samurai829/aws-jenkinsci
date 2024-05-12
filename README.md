# PROYECTO CI/CD AWS EC2, JENKINS Y MAVEN

## PREPARACION DE LA INSTANCIA EC2:
Creamos los recursos con Terraform, para esto es necesario tener una cuenta en AWS, en la cuenta de AWS procedemos a crear el usuario en IAM con los permisos necesarios, tambien crearemos las **CLAVES PARES** de acuerdo a la region que usaremos en EC2.

Ya por ultimo vinculamos Terraform con nuestro Usuario creado en la cuenta de AWS y creamos los recursos necesarios: `Instancia de EC2` y el `Grupo de seguridad`.

En la creacion del recurso indicamos en EC2_USER la instalacion de Java para luego instalar Jenkins.

las INTRUCCIONES para la instalacion:

`yum install java-1.8`
`yum remove java-1.7.0`

Ya con eso procedemos desde el Terminal comprobar la version con `java -version`.

Es importante agregar la RUTA en `.BASH_PROFILE` para esto tenemos que ir al terminal de la instancia de EC2 y escribir `cd ~` por ultimo agregar la ruta:
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04–1.el8_0.x86_64

Luego de escribir la ruta y guardar en el fichero en el Terminal colocamos el comando echo `$JAVA_HOME` si no funciona cerramos sesion o simplemente escribimos `exit` y luego accedemos como root usando `sudo su`.

### 2.PROCEDEMOS A INSTALAR JENKINS:
Pasos de instalacion en el **LINK oficial de Jenkins** https://jenkins.io/download/-
Instalacion debe hacerse en el Terminal de la Instancia de EC2.

1- `sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo`
2- `sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key`
3- `yum install fontconfig java-17-openjdk`
4- `yum install jenkins -y`
5- `service jenkins start`

Dentro de la Terminal de la instancia usar el comando `service jenkins status` para verificar el estado de Jenkins una vez instalado, luego tomar la IP publica de la instancia colocando **:8080** para acceder la interfaz de jenkins. 

Para la contraseña de acceso a jenkins tienes qure ir al terminal de la instancia y colocar `cat /var/lib/jenkins/secrets/initialAdminPassword` aqui te monstrara la contraseña.

**NOTA: Cambiar contraseña luego de acceder.**


## PROCESOS DE CONFIGURACION DE JENKINS:
Luego de CAMBIAR LA CONTRASEÑA, accedemos a Jenkins y luego a **"Administrar Jenkins"** seguido de **"Configuración global de la herramienta"**. En la sección JDK, agregue el nombre de JDK: **"JAVA_HOME"** y debajo agregue la ruta de JAVA_HOME que puede encontrar escribiendo el comando `echo $JAVA_HOME` en el terminal.

Ya hecho esto, instalamos GIT.

`yum install git -y`

Luego procedemos **Instalar el plugin de GIT sin reiniciar**

`Manage Jenkins` > `Jenkins Plugins` > `Available` > `Github`
Configurar la ruta de acceso de Git.

`Manage Jenkins` > `Global Tool Configuration` > `Git`

## CONFIGURANDO MAVEN EN JENKINS

### INSTALAR MAVEN EN EL DIRECTORIO /opt
`mkdir /opt/maven`
Luego accedemos al directorio `cd /opt/maven`

Descargamos Maven version 3.9.2
`wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz`

`tar xf apache-maven-3.9.2-bin.tar.gz`
Configuramos las rutas **M2_HOME** y **M2** en **.bash_profile** del usuario y agrégamos a la variable de ruta de la siguiente manera:
`vi ~/.bash_profile`
**AGREGAMOS ESTO:**
    M2_HOME=/opt/maven/apache-maven-3.9.2
    M2=$M2_HOME/bin
    PATH=$PATHñ$HOME/bin:$JAVA_HOME:$M2:$M2_HOME:$M2

    **NOTA: En el directorio packages esta el fichero con las rutas correspondientes.
    
Cerramos Sesion en la instancia y Accedemos nuevamente para comprobar la version de Maven:
`mvn --version`

Configurar maven en la consola Jenkins
Instale el complemento maven sin reiniciar
`Manage Jenkins` > `Jenkins Plugins` > `Available` > `Maven Invoker`
`Manage Jenkins` > `Jenkins Plugins` > `Available` > `Maven Integration`
Configuración de la ruta de acceso de maven
`Manage Jenkins` > `Global Tool Configuration` > `Maven`

NOMBRE: `M2_HOME`

`Maven_home — /opt/maven`