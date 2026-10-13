Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $identifier-type = http://hl7.org/fhir/ValueSet/identifier-type
Alias: $fathers-family = http://hl7.org/fhir/StructureDefinition/humanname-fathers-family
Alias: $mothers-family = http://hl7.org/fhir/StructureDefinition/humanname-mothers-family

Instance: PrestadorArgInline
InstanceOf: PrestadorArg
Usage: #example
Description: "Ejemplo inline de profesional argentino conforme al perfil PrestadorArg."

* identifier[DocumentoUnico].use = #official
* identifier[DocumentoUnico].type.coding
  * system = $v2-0203
  * code = #NI
* identifier[DocumentoUnico].system = "http://www.renaper.gob.ar/dni"
* identifier[DocumentoUnico].value = "12345678"
* identifier[DocumentoUnico].assigner.display = "RENAPER"

* identifier[REFEPSid].use = #usual
* identifier[REFEPSid].type.coding
  * system = $v2-0203
  * code = #AC
* identifier[REFEPSid].system = "http://refeps.msal.gob.ar"
* identifier[REFEPSid].value = "REFEPS-987654"
* identifier[REFEPSid].period.start = "2020-01-15T00:00:00-03:00"

* active = true

* name[0].use = #official
* name[0].family = "Pérez"
* name[0].family.extension[$fathers-family].valueString = "Pérez"
* name[0].family.extension[$mothers-family].valueString = "Gómez"
* name[0].given[0] = "María"
* name[0].given[1] = "Laura"

* telecom[0].system = #phone
* telecom[0].value = "+54 11 5555-1234"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "maria.perez@example.org"
* telecom[1].use = #work

* gender = #female
* birthDate = "1980-05-12"

* qualification[0].code.text = "Médica"