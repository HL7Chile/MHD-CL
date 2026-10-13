# FHIR.MHDIG\PrestadorArgInline - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **PrestadorArgInline**

## Example Practitioner: PrestadorArgInline

Profile: [Profesional Argentino](file:///builds/interoperabilidad/ips/output/StructureDefinition-PrestadorArg.html)

**identifier**: National unique individual identifier/12345678 (use: official, ), Accreditation/Certification Identifier/REFEPS-987654 (use: usual, period: 2020-01-15 00:00:00-0300 --> (ongoing))

**active**: true

**name**: María Laura Pérez (Official)

**telecom**: [+54 11 5555-1234](tel:+54115555-1234), [maria.perez@example.org](mailto:maria.perez@example.org)

**gender**: Female

**birthDate**: 1980-05-12

### Qualifications

| | |
| :--- | :--- |
| - | **Code** |
| * | Médica |



## Resource Content

```json
{
  "resourceType" : "Practitioner",
  "id" : "PrestadorArgInline",
  "meta" : {
    "profile" : ["http://ips.ri.hsisalud.org/StructureDefinition/PrestadorArg"]
  },
  "identifier" : [{
    "use" : "official",
    "type" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
        "code" : "NI"
      }]
    },
    "system" : "http://www.renaper.gob.ar/dni",
    "value" : "12345678",
    "assigner" : {
      "display" : "RENAPER"
    }
  },
  {
    "use" : "usual",
    "type" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
        "code" : "AC"
      }]
    },
    "system" : "http://refeps.msal.gob.ar",
    "value" : "REFEPS-987654",
    "period" : {
      "start" : "2020-01-15T00:00:00-03:00"
    }
  }],
  "active" : true,
  "name" : [{
    "use" : "official",
    "family" : "Pérez",
    "_family" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/StructureDefinition/humanname-fathers-family",
        "valueString" : "Pérez"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/humanname-mothers-family",
        "valueString" : "Gómez"
      }]
    },
    "given" : ["María", "Laura"]
  }],
  "telecom" : [{
    "system" : "phone",
    "value" : "+54 11 5555-1234",
    "use" : "work"
  },
  {
    "system" : "email",
    "value" : "maria.perez@example.org",
    "use" : "work"
  }],
  "gender" : "female",
  "birthDate" : "1980-05-12",
  "qualification" : [{
    "code" : {
      "text" : "Médica"
    }
  }]
}

```
