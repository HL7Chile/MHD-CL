Instance: Paciente-Interno
InstanceOf: PacienteArg
Description: "Ejemplo de paciente argentino conforme al perfil PacienteArg, con identificador de dominio y nombre legal."
Usage: #example
//* meta.profile = "http://fhir.msal.gob.ar/core/StructureDefinition/Patient-ar-core"
* identifier[DocumentoUnico].use = #official
* identifier[DocumentoUnico].system = "http://www.renaper.gob.ar/dni"
* identifier[DocumentoUnico].value = "99999999"
* identifier[IdentificadorDominio].use = #usual
* identifier[IdentificadorDominio].system = "http://www.dummy.org"
* identifier[IdentificadorDominio].value = "1234567"
* active = true
* name[NombreLegal].use = #official
* name[NombreLegal].text = "Pablo Fernandez Perez"
* name[NombreLegal].family = "Fernandez Perez"
* name[NombreLegal].family.extension[humanname-fathers-family].url = "http://hl7.org/fhir/StructureDefinition/humanname-fathers-family"
* name[NombreLegal].family.extension[humanname-fathers-family].valueString = "Fernandez"
* name[NombreLegal].family.extension[humanname-mothers-family].url = "http://hl7.org/fhir/StructureDefinition/humanname-mothers-family"
* name[NombreLegal].family.extension[humanname-mothers-family].valueString = "Perez"
* name[NombreLegal].given = "Pablo"
* telecom.system = #phone
* telecom.value = "1141233100"
* gender = #male
* birthDate = "1912-06-12"
