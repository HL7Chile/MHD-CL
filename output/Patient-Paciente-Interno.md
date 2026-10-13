# FHIR.MHDIG\Paciente-Interno - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Paciente-Interno**

## Example Patient: Paciente-Interno

Profile: [Paciente Argentino](file:///builds/interoperabilidad/ips/output/StructureDefinition-PacienteArg.html)

Pablo Fernandez Perez(official) Male, DoB: 1912-06-12 ( http://www.dummy.org#1234567 (use: usual, ))

-------

| | |
| :--- | :--- |
| Active: | true |
| Other Id: | `http://www.renaper.gob.ar/dni`/99999999 (use: official, ) |
| Contact Detail | ph: 1141233100 |



## Resource Content

```json
{
  "resourceType" : "Patient",
  "id" : "Paciente-Interno",
  "meta" : {
    "profile" : ["http://ips.ri.hsisalud.org/StructureDefinition/PacienteArg"]
  },
  "identifier" : [{
    "use" : "official",
    "system" : "http://www.renaper.gob.ar/dni",
    "value" : "99999999"
  },
  {
    "use" : "usual",
    "system" : "http://www.dummy.org",
    "value" : "1234567"
  }],
  "active" : true,
  "name" : [{
    "use" : "official",
    "text" : "Pablo Fernandez Perez",
    "family" : "Fernandez Perez",
    "_family" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/StructureDefinition/humanname-fathers-family",
        "valueString" : "Fernandez"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/humanname-mothers-family",
        "valueString" : "Perez"
      }]
    },
    "given" : ["Pablo"]
  }],
  "telecom" : [{
    "system" : "phone",
    "value" : "1141233100"
  }],
  "gender" : "male",
  "birthDate" : "1912-06-12"
}

```
