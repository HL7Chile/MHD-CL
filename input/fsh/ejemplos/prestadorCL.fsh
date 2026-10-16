Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $identifier-type = http://hl7.org/fhir/ValueSet/identifier-type
Alias: $fathers-family = http://hl7.org/fhir/StructureDefinition/humanname-fathers-family
Alias: $mothers-family = http://hl7.org/fhir/StructureDefinition/humanname-mothers-family

Instance: PrestadorCLInline
InstanceOf: PrestadorClIps
Usage: #example
Description: "Ejemplo inline de profesional argentino conforme al perfil PrestadorArg."

* identifier[run].use = #official
* identifier[run].type.coding
  * system = "https://hl7chile.cl/fhir/ig/clcore/CodeSystem/CSTipoIdentificador"
  * code = #01
* identifier[run].system = "https://www.registrocivil.cl/run"
* identifier[run].value = "12345678-K"

* identifier[rnpi].use = #usual
* identifier[rnpi].type.coding
  * system = "https://hl7chile.cl/fhir/ig/clcore/CodeSystem/CSTipoIdentificador"
  * code = #13
* identifier[rnpi].system = "https://rnpi.superdesalud.gob.cl/#"
* identifier[rnpi].value = "987654"


* active = true

* name[0].use = #official
* name[0].family = "Gómez"
* name[0].family.extension[segundoApellido]  = Perez
* name[0].given[0] = "María"
* name[0].given[1] = "Laura"

* telecom[0].system = #phone
* telecom[0].value = "+56 9 5555-1234"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "maria.perez@example.org"
* telecom[1].use = #work

* gender = #female
* birthDate = "1980-05-12"

* qualification[TituloProfesional].identifier.value = "cert"
* qualification[TituloProfesional].code.text = "Médica"