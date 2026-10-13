# FHIR.MHDIG\Categorías de Documento Clínico para DocumentReference - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Categorías de Documento Clínico para DocumentReference**

## ValueSet: Categorías de Documento Clínico para DocumentReference 

| | |
| :--- | :--- |
| *Official URL*:http://mhd.ri.hsisalud.org/ValueSet/VSCategoriaDoc | *Version*:0.3.0 |
| Active as of 2026-09-02 | *Computable Name*:VSCategoriaDoc |

 
Categorías generales de documentos clínicos codificadas en LOINC para ser usadas en DocumentReference.category. 

 **References** 

* [ReferenciaDocumental](StructureDefinition-ReferenciaDocumental.md)

### Logical Definition (CLD)

 

### Expansion

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R4/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "VSCategoriaDoc",
  "url" : "http://mhd.ri.hsisalud.org/ValueSet/VSCategoriaDoc",
  "version" : "0.3.0",
  "name" : "VSCategoriaDoc",
  "title" : "Categorías de Documento Clínico para DocumentReference",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-09-02T10:42:41-04:00",
  "publisher" : "HSI Pladema",
  "contact" : [{
    "name" : "HSI Pladema",
    "telecom" : [{
      "system" : "url",
      "value" : "https://hsi.pladema.net"
    }]
  }],
  "description" : "Categorías generales de documentos clínicos codificadas en LOINC para ser usadas en DocumentReference.category.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "AR",
      "display" : "Argentina"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "http://loinc.org",
      "concept" : [{
        "code" : "26436-6",
        "display" : "Laboratory studies (set)"
      },
      {
        "code" : "18726-0",
        "display" : "Radiology studies (set)"
      },
      {
        "code" : "11506-3",
        "display" : "Progress note"
      },
      {
        "code" : "18842-5",
        "display" : "Discharge summary"
      },
      {
        "code" : "60591-5",
        "display" : "Patient summary document"
      }]
    }]
  }
}

```
