# FHIR.MHDIG\Referencia documental mínima para DocumentoArg - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Referencia documental mínima para DocumentoArg**

## Example DocumentReference: Referencia documental mínima para DocumentoArg

Profile: [ReferenciaDocumental](StructureDefinition-ReferenciaDocumental.md)

**masterIdentifier**: `https://repositorio.hsi.ar/documentos/ips`/IPS-ARG-2026-00001

**status**: Current

**type**: Summary of episode note

**category**: Resumen clínico de paciente

**subject**: [Pablo Fernandez Perez(official) Male, DoB: 1912-06-12 ( http://www.dummy.org#1234567 (use: usual, ))](Bundle-bundle-mhd-referencia-documental-ejemplo.md#urn-uuid-991a7102-d221-498d-9157-c4192934e3b7)

**date**: 2026-07-06 10:30:00-0300

**author**: [Practitioner María Laura Pérez (official)](Practitioner-PrestadorArgInline.md)

> **content**

### Attachments

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| - | **ContentType** | **Url** | **Title** | **Creation** |
| * | application/fhir+json | [https://SecServerPEPE:2012/pba/santamarina/docs/ips-123](https://SecServerPEPE:2012/pba/santamarina/docs/ips-123) | Documento IPS argentino mínimo | 2026-07-06 10:30:00-0300 |


### Contexts

| | |
| :--- | :--- |
| - | **Period** |
| * | 2026-07-06 10:30:00-0300 --> (ongoing) |



## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "ReferDocEjemplo",
  "meta" : {
    "profile" : ["http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental"]
  },
  "masterIdentifier" : {
    "system" : "https://repositorio.hsi.ar/documentos/ips",
    "value" : "IPS-ARG-2026-00001"
  },
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "34133-9",
      "display" : "Summary of episode note"
    }]
  },
  "category" : [{
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "60591-5"
    }],
    "text" : "Resumen clínico de paciente"
  }],
  "subject" : {
    "reference" : "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
  },
  "date" : "2026-07-06T10:30:00-03:00",
  "author" : [{
    "reference" : "Practitioner/PrestadorArgInline"
  }],
  "content" : [{
    "attachment" : {
      "contentType" : "application/fhir+json",
      "url" : "https://SecServerPEPE:2012/pba/santamarina/docs/ips-123",
      "title" : "Documento IPS argentino mínimo",
      "creation" : "2026-07-06T10:30:00-03:00"
    }
  }],
  "context" : {
    "period" : {
      "start" : "2026-07-06T10:30:00-03:00"
    }
  }
}

```
