Instance: Paciente-Interno
InstanceOf: PacienteCLIps
Description: "Ejemplo de paciente Chileno conforme al perfil PacienteCLIps, con rut y nombre oficial."
Usage: #example

* identifier.use = #official
* identifier.system = "https://www.registrocivil.cl/run"
* identifier.value = "99999999-9"
* active = true
* name[NombreOficial].use = #official
* name[NombreOficial].text = "Pablo Fernandez Perez"
* name[NombreOficial].family = "Fernandez"
* name[NombreOficial].family.extension[segundoApellido] = Perez
* name[NombreOficial].given = "Pablo"
* telecom.system = #phone
* telecom.value = "1141233100"
* gender = #male
* birthDate = "1912-06-12"

Instance: Perez
InstanceOf: SegundoApellido
Usage: #inline

* valueString = "Perez"